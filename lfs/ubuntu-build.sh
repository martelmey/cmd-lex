#!/bin/bash

# 1.) building a cross compiler and its associated libraries
# 2.) use this cross toolchain to build several utilities in a way that isolates them from the host
# 3.) enter the chroot environment and build the remaining tools needed to build the final system

apt update && apt upgrade -y

apt install binutils binutils-dev bison bzip2 coreutils \
diffutils findutils gawk gcc grep gzip make patch perl \
sed tar xz-utils g++ texinfo net-tools expect

ln -sf bash /bin/sh
ln -sf gawk /usr/bin/awk
ln -sf bison /usr/bin/yacc

./version-check

mkdir -p /lfs/sources/patches && mkdir /lfs/build
cd /lfs/build
echo "export LFS=/lfs" >> /root/.profile && source /root/.profile
echo "export LFS=/lfs" >> /home/mxana/.profile && source /home/mxana/.profile
chmod -v a+wt /lfs/sources
wget --input-file=wget-list --continue --directory-prefix=/lfs/sources
wget --input-file=wget-list_patches --continue --directory-prefix=/lfs/sources/patches

pushd /lfs/sources
  md5sum -c /root/md5sums
popd

pushd /lfs/sources/patches
  md5sum -c /root/md5sums_patches
popd

mkdir -pv $LFS/{bin,etc,lib,sbin,usr,var}
case $(uname -m) in
  x86_64) mkdir -pv $LFS/lib64 ;;
esac

mkdir -pv $LFS/tools

[ ! -e /etc/bash.bashrc ] || mv -v /etc/bash.bashrc /etc/bash.bashrc.NOUSE

groupadd lfs
useradd -s /bin/bash -g lfs -m -k /dev/null lfs
passwd lfs #lfs
chown -v lfs $LFS/{usr,lib,var,etc,bin,sbin,tools}
case $(uname -m) in
  x86_64) chown -v lfs $LFS/lib64 ;;
esac
chown -v lfs $LFS/sources
sudo su - lfs

cat > ~/.bash_profile << "EOF"
	exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' /bin/bash
EOF
cat > ~/.bashrc << "EOF"
set +h
umask 022
LFS=/lfs
LC_ALL=POSIX
LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=/usr/bin
if [ ! -L /bin ]; then PATH=/bin:$PATH; fi
PATH=$LFS/tools/bin:$PATH
CONFIG_SITE=$LFS/usr/share/config.site
export LFS LC_ALL LFS_TGT PATH CONFIG_SITE
EOF
source ~/.bash && source ~/.bash_profile
export MAKEFLAGS='-j1'

# check for ptys
expect -c "spawn ls"

# check name of dynamic linker
readelf -l /usr/bin/bash | grep interpreter
# show linker library search paths & order
$LFS_TGT-ld --verbose | grep SEARCH
# show files opened successfully during the linking ^
$LFS_TGT-gcc dummy.c -Wl,--verbose 2>&1 | grep succeeded
# see which std linker gcc will use
LFS_TGT-gcc -print-prog-name=ld
# show info on preprocessor, compilation, assembly stages + search paths & order
gcc -v dummy.c

# check bison & gawk symlinks
ls -la /usr/bin/awk
ls -la /usr/bin/yacc

# Binutils
cd /lfs/sources
tar -xvf binutils-2.36.1.tar.xz
cd binutils-2.36.1
mkdir -v build && cd build
../configure --prefix=$LFS/tools \
	--with-sysroot=$LFS \
	--target=$LFS_TGT \
	--disable-nls \
	--disable-werror
make
make install

# GCC + MPFR & GMP & MPC
cd ../../ # /lfs/sources
tar -xvf gcc-10.2.0.tar.xz
tar -xf mpfr-4.1.0.tar.xz
mv -v mpfr-4.1.0 gcc-10.2.0/mpfr
tar -xf gmp-6.2.1.tar.xz
mv -v gmp-6.2.1 gcc-10.2.0/gmp
tar -xf mpc-1.2.1.tar.gz
mv -v mpc-1.2.1 /gcc-10.2.0/mpc
mkdir -v gcc-10.2.0/build && cd gcc-10.2.0/build
case $(uname -m) in
  x86_64)
    sed -e '/m64=/s/lib64/lib/' \
        -i.orig gcc/config/i386/t-linux64
 ;;
esac
mkdir -v build
cd       build
../configure \
	--target=$LFS_TGT \
	--prefix=$LFS/tools \
	--with-glibc-version=2.11 \
	--with-sysroot=$LFS \
	--with-newlib \
	--without-headers \
	--enable-initfini-array \
	--disable-nls \
	--disable-shared \
	--disable-multilib \
	--disable-decimal-float \
	--disable-threads \
	--disable-libatomic \
	--disable-libgomp \
	--disable-libquadmath \
	--disable-libssp \
	--disable-libvtv \
	--disable-libstdcxx \
	--enable-languages=c,c++
make
make install
# Create full version of the internal header
cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
  `dirname $($LFS_TGT-gcc -print-libgcc-file-name)`/install-tools/include/limits.h

# Linux API headers
cd ../../ # /lfs/sources
tar -xvf linux-5.10.17.tar.xz
cd linux-5.10.17
make mrproper
make headers
find usr/include -name '.*' -delete
rm usr/include/Makefile
cp -rv usr/include $LFS/usr

# GLIBC
cd ../
tar -xvf glibc-2.33.tar.xz
cd glibc-2.33
case $(uname -m) in
    i?86)   ln -sfv ld-linux.so.2 $LFS/lib/ld-lsb.so.3
    ;;
    x86_64) ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64
            ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64/ld-lsb-x86-64.so.3
    ;;
esac
patch -Np1 -i ../glibc-2.33-fhs-1.patch
mkdir -v build
cd build
../configure \
      --prefix=/usr \
      --host=$LFS_TGT \
      --build=$(../scripts/config.guess) \
      --enable-kernel=3.2 \
      --with-headers=$LFS/usr/include \
      libc_cv_slibdir=/lib
make
make DESTDIR=$LFS install

# Sanity check
echo 'int main(){}' > dummy.c
$LFS_TGT-gcc dummy.c
readelf -l a.out | grep '/ld-linux'
rm -v dummy.c a.out
$LFS/tools/libexec/gcc/$LFS_TGT/10.2.0/install-tools/mkheaders

# libstdc++
cd ../../gcc-10.2.0
rm -rf build/
mkdir -v build
cd build
../libstdc++-v3/configure\
    --host=$LFS_TGT \
    --build=$(../config.guess) \
    --prefix=/usr \
    --disable-multilib \
    --disable-nls \
    --disable-libstdcxx-pch \
    --with-gxx-include-dir=/tools/$LFS_TGT/include/c++/10.2.0
make
make DESTDIR=$LFS install

# M4
cd ../../
tar -xvf m4-1.4.18.tar.xz
cd m4-1.4.18
sed -i 's/IO_ftrylockfile/IO_EOF_SEEN/' lib/*.c
echo "#define _IO_IN_BACKUP 0x100" >> lib/stdio-impl.h
./configure --prefix=/usr \
	--host=$LFS_TGT \
	--build=$(build-aux/config.guess)
make
make DESTDIR=$LFS install

# ncurses
cd ../
tar -xvf ncurses-6.2.tar.gz
cd ncurses-6.2
sed -i s/mawk// configure
mkdir build
pushd build
  ../configure
  make -C include
  make -C progs tic
popd
./configure --prefix=/usr \
	--host=$LFS_TGT \
	--build=$(./config.guess) \
	--mandir=/usr/share/man \
	--with-manpage-format=normal \
	--with-shared \
	--without-debug \
	--without-ada \
	--without-normal \
	--enable-widec
make
make DESTDIR=$LFS TIC_PATH=$(pwd)/build/progs/tic install
echo "INPUT(-lncursesw)" > $LFS/usr/lib/libncurses.so
mv -v $LFS/usr/lib/libncursesw.so.6* $LFS/lib
ln -sfv ../../lib/$(readlink $LFS/usr/lib/libncursesw.so) $LFS/usr/lib/libncursesw.so

# Bash
cd ../
tar -xvf bash-5.1.tar.gz
cd bash-5.1
./configure --prefix=/usr \
	--build=$(support/config.guess) \
	--host=$LFS_TGT \
	--without-bash-malloc
make
make DESTDIR=$LFS install
mv $LFS/usr/bin/bash $LFS/bin/bash
ln -sv bash $LFS/bin/sh

# Coreutils
cd ../
tar -xvf coreutils-8.32.tar.xz
cd coreutils-8.32
./configure --prefix=/usr \
	--host=$LFS_TGT \
	--build=$(build-aux/config.guess) \
	--enable-install-program=hostname \
	--enable-no-install-program=kill,uptime
make
make DESTDIR=$LFS install
mv -v $LFS/usr/bin/{cat,chgrp,chmod,chown,cp,date,dd,df,echo} $LFS/bin
mv -v $LFS/usr/bin/{false,ln,ls,mkdir,mknod,mv,pwd,rm} $LFS/bin
mv -v $LFS/usr/bin/{rmdir,stty,sync,true,uname} $LFS/bin
mv -v $LFS/usr/bin/{head,nice,sleep,touch} $LFS/bin
mv -v $LFS/usr/bin/chroot $LFS/usr/sbin
mkdir -pv $LFS/usr/share/man/man8
mv -v $LFS/usr/share/man/man1/chroot.1 $LFS/usr/share/man/man8/chroot.8
sed -i 's/"1"/"8"/' $LFS/usr/share/man/man8/chroot.8

# Diffutils
cd ../
tar -xvf diffutils-3.7.tar.xz
cd diffutils-3.7
./configure --prefix=/usr --host=$LFS_TGT
make
make DESTDIR=$LFS install

# File
cd ../
tar -xvf file-5.39.tar.gz
cd file-5.39
mkdir build
pushd build
  ../configure --disable-bzlib \
   --disable-libseccomp \
   --disable-xzlib \
   --disable-zlib
  make
popd
./configure --prefix=/usr --host=$LFS_TGT --build=$(./config.guess)
make FILE_COMPILE=$(pwd)/build/src/file
make DESTDIR=$LFS install

# Findutils
cd ../
tar -xvf findutils-4.8.0.tar.xz
cd findutils-4.8.0
./configure --prefix=/usr \
	--host=$LFS_TGT \
	--build=$(build-aux/config.guess)
make
make DESTDIR=$LFS install
mv -v $LFS/usr/bin/find $LFS/bin
sed -i 's|find:=${BINDIR}|find:=/bin|' $LFS/usr/bin/updatedb

# Gawk
cd ../
tar -xvf gawk-5.1.0.tar.xz
cd gawk-5.1.0
sed -i 's/extras//' Makefile.in
./configure --prefix=/usr \
	--host=$LFS_TGT \
	--build=$(./config.guess)
make
make DESTDIR=$LFS install

# Grep
cd ../
tar -xvf grep-3.6.tar.xz
cd grep-3.6
./configure --prefix=/usr \
	--host=$LFS_TGT \
	--bindir=/bin
make
make DESTDIR=$LFS install

# Gzip
cd ../
tar -xvf gzip-1.10.tar.xz
cd gzip-1.10
./configure --prefix=/usr --host=$LFS_TGT
make
make DESTDIR=$LFS install
mv -v $LFS/usr/bin/gzip $LFS/bin

# Make
cd ../
tar -xvf make-4.3.tar.gz
cd make-4.3
./configure --prefix=/usr \
	--without-guile \
	--host=$LFS_TGT \
	--build=$(build-aux/config.guess)
make
make DESTDIR=$LFS install

# Patch
cd ../
tar -xvf patch-2.7.6.tar.xz
cd patch-2.7.6
./configure --prefix=/usr \
	--host=$LFS_TGT \
	--build=$(build-aux/config.guess)
make
make DESTDIR=$LFS install

# Sed
cd ../
tar -xvf sed-4.8.tar.xz
cd sed-4.8
./configure --prefix=/usr \
	--host=$LFS_TGT \
	--bindir=/bin
make
make DESTDIR=$LFS install

# Tar
cd ../
tar -xvf tar-1.34.tar.xz
cd tar-1.34
./configure --prefix=/usr \
	--host=$LFS_TGT \
	--build=$(build-aux/config.guess) \
	--bindir=/bin
make
make DESTDIR=$LFS install

# Xz
cd ../
tar -xvf xz-5.2.5.tar.xz
cd xz-5.2.5
./configure --prefix=/usr \
	--host=$LFS_TGT \
	--build=$(build-aux/config.guess) \
	--disable-static \
	--docdir=/usr/share/doc/xz-5.2.5
make
make DESTDIR=$LFS install
mv -v $LFS/usr/bin/{lzma,unlzma,lzcat,xz,unxz,xzcat} $LFS/bin
mv -v $LFS/usr/lib/liblzma.so.* $LFS/lib
ln -svf ../../lib/$(readlink $LFS/usr/lib/liblzma.so) $LFS/usr/lib/liblzma.so

# Binutils Pass #2
cd ../binutils-2.36.1
rm -rfv build
mkdir -v build
cd build
../configure \
    --prefix=/usr \
    --build=$(../config.guess) \
    --host=$LFS_TGT \
    --disable-nls \
    --enable-shared \
    --disable-werror \
    --enable-64-bit-bfd
make DESTDIR=$LFS install
install -vm755 libctf/.libs/libctf.so.0.0.0 $LFS/usr/lib

# GCC Pass #2
cd ../../gcc-10.2.0
tar -xf ../mpfr-4.1.0.tar.xz
mv -v mpfr-4.1.0 mpfr
tar -xf ../gmp-6.2.1.tar.xz
mv -v gmp-6.2.1 gmp
tar -xf ../mpc-1.2.1.tar.gz
mv -v mpc-1.2.1 mpc
case $(uname -m) in
  x86_64)
    sed -e '/m64=/s/lib64/lib/' -i.orig gcc/config/i386/t-linux64
  ;;
esac
rm -rf build
mkdir -v build
cd build
mkdir -pv $LFS_TGT/libgcc
ln -s ../../../libgcc/gthr-posix.h $LFS_TGT/libgcc/gthr-default.h
../configure \
    --build=$(../config.guess) \
    --host=$LFS_TGT \
    --prefix=/usr \
    CC_FOR_TARGET=$LFS_TGT-gcc \
    --with-build-sysroot=$LFS \
    --enable-initfini-array \
    --disable-nls \
    --disable-multilib \
    --disable-decimal-float \
    --disable-libatomic \
    --disable-libgomp \
    --disable-libquadmath \
    --disable-libssp \
    --disable-libvtv \
    --disable-libstdcxx \
    --enable-languages=c,c++
make
make DESTDIR=$LFS install
ln -sv gcc $LFS/usr/bin/cc

# Chroot
exit
sudo su - root
chown -R root:root $LFS/{usr,lib,var,etc,bin,sbin,tools}
case $(uname -m) in
  x86_64) chown -R root:root $LFS/lib64 ;;
esac
mkdir -pv $LFS/{dev,proc,sys,run}
mknod -m 600 $LFS/dev/console c 5 1
mknod -m 666 $LFS/dev/null c 1 3
mount -v --bind /dev $LFS/dev
mount -v --bind /dev/pts $LFS/dev/pts
mount -vt proc proc $LFS/proc
mount -vt sysfs sysfs $LFS/sys
mount -vt tmpfs tmpfs $LFS/run
if [ -h $LFS/dev/shm ]; then
  mkdir -pv $LFS/$(readlink $LFS/dev/shm)
fi
chroot "$LFS" /usr/bin/env -i \
    HOME=/root \
    TERM="$TERM" \
    PS1='(lfs chroot) \u:\w\$ ' \
    PATH=/bin:/usr/bin:/sbin:/usr/sbin \
    /bin/bash --login +h

# Setup
mkdir -pv /{boot,home,mnt,opt,srv}
mkdir -pv /etc/{opt,sysconfig}
mkdir -pv /lib/firmware
mkdir -pv /media/{floppy,cdrom}
mkdir -pv /usr/{,local/}{bin,include,lib,sbin,src}
mkdir -pv /usr/{,local/}share/{color,dict,doc,info,locale,man}
mkdir -pv /usr/{,local/}share/{misc,terminfo,zoneinfo}
mkdir -pv /usr/{,local/}share/man/man{1..8}
mkdir -pv /var/{cache,local,log,mail,opt,spool}
mkdir -pv /var/lib/{color,misc,locate}
ln -sfv /run /var/run
ln -sfv /run/lock /var/lock
ln -sv /proc/self/mounts /etc/mtab
echo "127.0.0.1 localhost $(hostname)" > /etc/hosts
cat > /etc/passwd << "EOF"
root:x:0:0:root:/root:/bin/bash
bin:x:1:1:bin:/dev/null:/bin/false
daemon:x:6:6:Daemon User:/dev/null:/bin/false
messagebus:x:18:18:D-Bus Message Daemon User:/run/dbus:/bin/false
uuidd:x:80:80:UUID Generation Daemon User:/dev/null:/bin/false
nobody:x:99:99:Unprivileged User:/dev/null:/bin/false
EOF
cat > /etc/group << "EOF"
root:x:0:
bin:x:1:daemon
sys:x:2:
kmem:x:3:
tape:x:4:
tty:x:5:
daemon:x:6:
floppy:x:7:
disk:x:8:
lp:x:9:
dialout:x:10:
audio:x:11:
video:x:12:
utmp:x:13:
usb:x:14:
cdrom:x:15:
adm:x:16:
messagebus:x:18:
input:x:24:
mail:x:34:
kvm:x:61:
uuidd:x:80:
wheel:x:97:
nogroup:x:99:
users:x:999:
EOF
echo "tester:x:$(ls -n $(tty) | cut -d" " -f3):101::/home/tester:/bin/bash" >> /etc/passwd
echo "tester:x:101:" >> /etc/group
install -o tester -d /home/tester
exec /bin/bash --login +h
touch /var/log/{btmp,lastlog,faillog,wtmp}
chgrp -v utmp /var/log/lastlog
chmod -v 664  /var/log/lastlog
chmod -v 600  /var/log/btmp

# Libstdc++ from GCC-10.2.0, pass #2 #STOP HERE, RESTART ON SLACKWARE
cd /sources/gcc-10.2.0
ln -s gthr-posix.h libgcc/gthr-default.h
rm -rf build
mkdir -v build
cd build
../libstdc++-v3/configure \
    CXXFLAGS="-g -O2 -D_GNU_SOURCE" \
    --prefix=/usr \
    --disable-multilib \
    --disable-nls \
    --host=$(uname -m)-lfs-linux-gnu \
    --disable-libstdcxx-pch