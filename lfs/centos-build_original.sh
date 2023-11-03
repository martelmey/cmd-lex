#!/bin/bash

sudo su - root

# Pre-req
yum update -y

# no gcc-c++ ?
yum -y install bison bzip2-devel coreutils diffutils findutils gawk \
gcc gcc-c++ glibc glibc-devel glibc-headers grep gzip m4 make make-devel \
patch perl perl-devel python3 python3-devel expect \
sed tar info xz xz-devel

tar -xvf texinfo-6.7.tar.gz
cd texinfo-6.7
./configure --prefix=/usr
make
make install

ln -sf bash /bin/sh
ln -sf gawk /usr/bin/awk
ln -sf bison /usr/bin/yacc

./version-check

export LFS=/lfs
echo "export LFS=/lfs" >> /root/.profile && source /root/.profile
echo "export LFS=/lfs" >> /root/.profile && source /root/.bash_profile

# Sources
mkdir -vp $LFS/sources/patches
chmod -vR a+wt $LFS/sources
wget --input-file=wget-list --continue --directory-prefix=$LFS/sources
wget --input-file=wget-list_patches --continue --directory-prefix=/lfs/sources/patches

pushd /lfs/sources
  md5sum -c md5sums
popd

pushd /lfs/sources/patches
  md5sum -c md5sums_patches
popd

# Setup
mkdir -pv $LFS/{bin,etc,lib,sbin,usr,var}
case $(uname -m) in
  x86_64) mkdir -pv $LFS/lib64 ;;
esac
mkdir -pv $LFS/tools

groupadd lfs
useradd -s /bin/bash -g lfs -m -k /dev/null lfs
passwd lfs # lfs
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
MAKEFLAGS='-j1'
export LFS LC_ALL LFS_TGT PATH CONFIG_SITE MAKEFLAGS
EOF
[ ! -e /etc/bash.bashrc ] || mv -v /etc/bash.bashrc /etc/bash.bashrc.NOUSE
source ~/.bash_profile

# check for ptys
expect -c "spawn ls"

# check name of dynamic linker
readelf -l /usr/bin/bash | grep interpreter

# check symlinks
ls -la /usr/bin/awk
ls -la /usr/bin/yacc
ls -la /bin/sh

# Binutils
cd $LFS/sources
tar -xvf binutils-2.36.1.tar.xz
cd binutils-2.36.1
mkdir -v build
cd build
../configure --prefix=$LFS/tools       \
             --with-sysroot=$LFS        \
             --target=$LFS_TGT          \
             --disable-nls              \
             --disable-werror
make
make install

# GCC-10.2.0 - Pass1
cd ../../
tar -xvf gcc-10.2.0.tar.xz
cd gcc-10.2.0
tar -xf ../mpfr-4.1.0.tar.xz
mv -v mpfr-4.1.0 mpfr
tar -xf ../gmp-6.2.1.tar.xz
mv -v gmp-6.2.1 gmp
tar -xf ../mpc-1.2.1.tar.gz
mv -v mpc-1.2.1 mpc
case $(uname -m) in
  x86_64)
    sed -e '/m64=/s/lib64/lib/' \
        -i.orig gcc/config/i386/t-linux64
 ;;
esac
mkdir -v build
cd       build
../configure                                       \
    --target=$LFS_TGT                              \
    --prefix=$LFS/tools                            \
    --with-glibc-version=2.28                      \
    --with-sysroot=$LFS                            \
    --with-newlib                                  \
    --without-headers                              \
    --enable-initfini-array                        \
    --disable-nls                                  \
    --disable-shared                               \
    --disable-multilib                             \
    --disable-decimal-float                        \
    --disable-threads                              \
    --disable-libatomic                            \
    --disable-libgomp                              \
    --disable-libquadmath                          \
    --disable-libssp                               \
    --disable-libvtv                               \
    --disable-libstdcxx                            \
    --enable-languages=c,c++
make
make install

# Linux API Headers
cd ../../
tar -xvf linux-5.10.17.tar.xz
cd linux-5.10.17
make mrproper
make Headers
find usr/include -name '.*' -delete
rm usr/include/Makefile
cp -rv usr/include $LFS/usr

# Glibc
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
cd       build
../configure                             \
      --prefix=/usr                      \
      --host=$LFS_TGT                    \
      --build=$(../scripts/config.guess) \
      --enable-kernel=3.2                \
      --with-headers=$LFS/usr/include    \
      libc_cv_slibdir=/lib
make -j1
make DESTDIR=$LFS install

# Sanity check
echo 'int main(){}' > dummy.c
$LFS_TGT-gcc dummy.c
$LFS_TGT-gcc dummy.c -Wl,--verbose 2>&1 | grep succeeded
gcc -v dummy.c
readelf -l a.out | grep '/ld-linux' 
rm -v dummy.c a.out
$LFS_TGT-ld --verbose | grep SEARCH
$LFS_TGT-gcc -print-prog-name=ld
$LFS/tools/libexec/gcc/$LFS_TGT/10.2.0/install-tools/mkheaders

# Libstdc++ from GCC-10.2.0, Pass 1
cd ../../
rm -rf gcc-10.2.0
tar -xvf gcc-10.2.0.tar.xz
cd gcc-10.2.0
mkdir -v build
cd       build
../libstdc++-v3/configure           \
    --host=$LFS_TGT                 \
    --build=$(../config.guess)      \
    --prefix=/usr                   \
    --disable-multilib              \
    --disable-nls                   \
    --disable-libstdcxx-pch         \
    --with-gxx-include-dir=/tools/$LFS_TGT/include/c++/10.2.0
make
make DESTDIR=$LFS install

# M4
cd ../../
tar -xvf m4-1.4.18.tar.xz
cd m4-1.4.18
sed -i 's/IO_ftrylockfile/IO_EOF_SEEN/' lib/*.c
echo "#define _IO_IN_BACKUP 0x100" >> lib/stdio-impl.h
./configure --prefix=/usr   \
            --host=$LFS_TGT \
            --build=$(build-aux/config.guess)
make
