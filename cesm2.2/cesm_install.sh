#!/bin/bash
##
cd /opt/ncar
git clone -b release-cesm2.2.2 https://github.com/ESCOMP/CESM.git cesm
cd cesm
svn --username=guestuser --password=friendly list https://svn-ccsm-models.cgd.ucar.edu << EOF
p
yes
EOF
./manage_externals/checkout_externals

echo 'export PATH=/opt/ncar/cesm/cime/scripts:${PATH}' > /etc/profile.d/cesm.sh
echo 'export CIME_MACHINE=aws-hpc6a' >> /etc/profile.d/cesm.sh
echo 'export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/opt/ncar/software/lib' >> /etc/profile.d/cesm.sh
echo 'export NETCDF=/opt/ncar/software' >> /etc/profile.d/cesm.sh

mkdir -p /scratch/ec2-user/inputdata
chown -R ec2-user:ec2-user /scratch/ec2-user

# Fixes an issue with file ownership when running cases 
chown -R ec2-user:ec2-user /opt/ncar/cesm

