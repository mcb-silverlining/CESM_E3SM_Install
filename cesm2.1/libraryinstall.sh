#!/bin/bash
# do as sudo su

# Install the yum repo for all the oneAPI packages:
cat << EOF > /etc/yum.repos.d/oneAPI.repo
[oneAPI]
name=Intel(R) oneAPI repository
baseurl=https://yum.repos.intel.com/oneapi
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://yum.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB
EOF

# update the OS
yum -y upgrade
yum install -y lapack-devel

####Install intel oneapi

yum -y install intel-oneapi-compiler-fortran-2023.1.0 intel-oneapi-compiler-dpcpp-cpp-and-cpp-classic-2023.1.0 intel-oneapi-mpi-devel-2021.9.0


#removed these from compute nodes, will need environment variables in the .bashrc file
echo '/opt/ncar/software/lib' > /etc/ld.so.conf.d/ncar.conf
echo 'source /opt/intel/oneapi/setvars.sh > /dev/null' > /etc/profile.d/oneapi.sh

LIBRARY_PATH=/opt/ncar/software/lib
LD_LIBRARY_PATH=/opt/ncar/software/lib:$LD_LIBRARY_PATH
CPATH=/opt/ncar/software/include:$CPATH
FPATH=/opt/ncar/software/include:$FPATH

#  build libraries
source /opt/intel/oneapi/setvars.sh --force
mkdir /tmp/sources
cd /tmp/sources
wget -q https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.12/hdf5-1.12.0/src/hdf5-1.12.0.tar.gz
tar zxf hdf5-1.12.0.tar.gz
cd hdf5-1.12.0
./configure --prefix=/opt/ncar/software CC=icc CXX=icpc FC=ifort
make -j 2 install
ldconfig

cd /tmp/sources
wget -q https://downloads.unidata.ucar.edu/netcdf-c/4.9.2/netcdf-c-4.9.2.tar.gz
tar zxf netcdf-c-4.9.2.tar.gz
cd netcdf-c-4.9.2
./configure --prefix=/opt/ncar/software CC=icc CXX=icpc FC=ifort
make -j 2 install
ldconfig

cd /tmp/sources
wget -q https://downloads.unidata.ucar.edu/netcdf-fortran/4.6.0/netcdf-fortran-4.6.0.tar.gz
tar zxf netcdf-fortran-4.6.0.tar.gz
cd netcdf-fortran-4.6.0
./configure --prefix=/opt/ncar/software CC=icc CXX=icpc FC=ifort
make -j 2 install
ldconfig

cd /tmp/sources
wget -q https://parallel-netcdf.github.io/Release/pnetcdf-1.12.1.tar.gz
tar zxf pnetcdf-1.12.1.tar.gz
cd pnetcdf-1.12.1
./configure --prefix=/opt/ncar/software CC=mpicc CXX=mpicxx FC=mpiifort
make -j 2 install
ldconfig

cd /tmp

cp /usr/lib64/liblapack* /usr/lib64/libblas* /opt/ncar/software/lib
mkdir /opt/ncar/cmake
cd /tmp/sources
mkdir cmake
wget https://github.com/Kitware/CMake/releases/download/v3.22.3/cmake-3.22.3-linux-x86_64.sh
sh cmake-3.22.3-linux-x86_64.sh --prefix=/opt/ncar/cmake --skip-license

rm -rf /tmp/sources

# Change user limits for ec2-user:
cat << EOF >> /etc/security/limits.conf
ec2-user         hard    stack           -1
ec2-user         soft    stack           -1
EOF
