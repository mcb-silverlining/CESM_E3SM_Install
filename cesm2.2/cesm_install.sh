#!/bin/bash
##
cd /opt/ncar
#git clone -b cesm2.1.4-rc.10 https://github.com/ESCOMP/CESM.git cesm
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

exit
# place holder for these commands
cd /home/ec2-user
https://github.com/mcb-silverlining/CESM_E3SM_Install.git
chown -R ec2-user:ec2-user CESM_E3SM_install.git

/bin/cp /opt/ncar/cesm/cime/config/cesm/machines/config_compilers.xml /opt/ncar/cesm/cime/config/cesm/machines/config_compilers.xml_orig
/bin/cp CESM_E3SM_Install/config_compilers.xml /opt/ncar/cesm/cime/config/cesm/machines/config_compilers.xml

/bin/cp /opt/ncar/cesm/cime/config/cesm/machines/config_machines.xml /opt/ncar/cesm/cime/config/cesm/machines/config_machines.xml_orig
/bin/cp CESM_E3SM_Install/config_machines.xml /opt/ncar/cesm/cime/config/cesm/machines/config_machines.xml

/bin/cp /opt/ncar/cesm/cime/config/cesm/machines/config_batch.xml /opt/ncar/cesm/cime/config/cesm/machines/config_batch.xml_orig
/bin/cp CESM_E3SM_Install/config_batch.xml /opt/ncar/cesm/cime/config/cesm/machines/config_batch.xml

/bin/cp /opt/ncar/cesm/cime_config/config_pes.xml /opt/ncar/cesm/cime_config/config_pes.xml_orig
/bin/cp CESM_E3SM_Install/config_pes.xml /opt/ncar/cesm/cime_config/config_pes.xml


