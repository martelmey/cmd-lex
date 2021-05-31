#!/bin/bash

sudo su - root

# Pre-req
#yum update -y

# no gcc-c++ ?
# try w/o *-devel && *-headers
yum -y install bison bzip2 coreutils diffutils findutils gawk \
gcc gcc-c++ glibc  grep gzip m4 make \
patch perl python3 expect \
sed tar info xz

ln -sf bash /bin/sh
ln -sf gawk /usr/bin/awk
ln -sf bison /usr/bin/yacc

export LFS=/lfs
echo "export LFS=/lfs" >> /root/.profile && source /root/.profile
echo "export LFS=/lfs" >> /root/.profile && source /root/.bash_profile

# Sources
tar -zxvf lfs-sources.tar.gz -C /lfs
chmod -vR a+wt /lfs
chmod +x /lfs/.version-check
cd /lfs/sources
tar -xvf texinfo-6.7.tar.xz
cd texinfo-6.7
./configure --prefix=/usr
make
make install

/lfs/.version-check.sh

pushd /lfs/sources
  md5sum -c /lfs/md5sums
popd

pushd /lfs/sources/patches
  md5sum -c /lfs/md5sums_patches
popd

# Setup
mkdir -pv /lfs/{bin,etc,lib,sbin,usr,var}
case $(uname -m) in
  x86_64) mkdir -pv /lfs/lib64 ;;
esac
mkdir -pv /lfs/tools

groupadd lfs
useradd -s /bin/bash -g lfs -m lfs
passwd lfs # lfs
chown -v lfs /lfs/{usr,lib,var,etc,bin,sbin,tools}
case $(uname -m) in
  x86_64) chown -v lfs /lfs/lib64 ;;
esac
chown -v lfs /lfs/sources

sudo su - lfs
cat > ~/.bash_profile << "EOF"
exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' /bin/bash
EOF
cat > ~/.bashrc << "EOF"
set +h
umask 022
LFS=/lfs
LC_ALL=POSIX
LFS_TGT=x86_64-lfs-linux-gnu
PATH=/usr/bin
if [ ! -L /bin ]; then PATH=/bin:$PATH; fi
PATH=/lfs/tools/bin:$PATH
CONFIG_SITE=/lfs/usr/share/config.site
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
cd /lfs/sources
tar -xvf binutils-2.36.1.tar.xz
cd binutils-2.36.1
mkdir -v build
cd build
../configure --prefix=/lfs/tools       \
             --with-sysroot=/lfs        \
             --target=x86_64-lfs-linux-gnu          \
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
    --target=x86_64-lfs-linux-gnu                              \
    --prefix=/lfs/tools                            \
    --with-glibc-version=2.28                      \
    --with-sysroot=/lfs                            \
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
make headers
find usr/include -name '.*' -delete
rm usr/include/Makefile
cp -rv usr/include /lfs/usr

# Glibc
cd ../
tar -xvf glibc-2.33.tar.xz
cd glibc-2.33
case $(uname -m) in
    i?86)   ln -sfv ld-linux.so.2 /lfs/lib/ld-lsb.so.3
    ;;
    x86_64) ln -sfv ../lib/ld-linux-x86-64.so.2 /lfs/lib64
            ln -sfv ../lib/ld-linux-x86-64.so.2 /lfs/lib64/ld-lsb-x86-64.so.3
    ;;
esac
patch -Np1 -i ../glibc-2.33-fhs-1.patch
mkdir -v build
cd       build
../configure                             \
      --prefix=/usr                      \
      --host=x86_64-lfs-linux-gnu                    \
      --build=x86_64-pc-linux-gnu \
      --enable-kernel=3.2                \
      --with-headers=/lfs/usr/include    \
      libc_cv_slibdir=/lib
make #-j1
make DESTDIR=/lfs install #RESUME W/ THIS

# Sanity check
echo 'int main(){}' > dummy.c
x86_64-lfs-linux-gnu-gcc dummy.c
x86_64-lfs-linux-gnu-gcc dummy.c -Wl,--verbose 2>&1 | grep succeeded
gcc -v dummy.c
readelf -l a.out | grep '/ld-linux' 
rm -v dummy.c a.out
x86_64-lfs-linux-gnu-ld --verbose | grep SEARCH
x86_64-lfs-linux-gnu-gcc -print-prog-name=ld
/lfs/tools/libexec/gcc/x86_64-lfs-linux-gnu/10.2.0/install-tools/mkheaders

# Libstdc++ from GCC-10.2.0, Pass 1
cd ../../
rm -rf gcc-10.2.0
tar -xvf gcc-10.2.0.tar.xz
cd gcc-10.2.0
mkdir -v build
cd       build
../libstdc++-v3/configure           \
    --host=x86_64-lfs-linux-gnu                 \
    --build=x86_64-pc-linux-gnu      \
    --prefix=/usr                   \
    --disable-multilib              \
    --disable-nls                   \
    --disable-libstdcxx-pch         \
    --with-gxx-include-dir=/tools/x86_64-lfs-linux-gnu/include/c++/10.2.0
make
make DESTDIR=/lfs install

# M4
cd ../../
tar -xvf m4-1.4.18.tar.xz
cd m4-1.4.18
sed -i 's/IO_ftrylockfile/IO_EOF_SEEN/' lib/*.c
echo "#define _IO_IN_BACKUP 0x100" >> lib/stdio-impl.h
./configure --prefix=/usr   \
            --host=x86_64-lfs-linux-gnu \
            --build=x86_64-pc-linux-gnu
make
