#!/bin/bash
#git clone https://github.com/silverliningngo/CESM_E3SM_Install.git
chown -R ec2-user:ec2-user CESM_E3SM_install.git

/bin/cp /opt/ncar/cesm/cime/config/cesm/machines/config_compilers.xml /opt/ncar/cesm/cime/config/cesm/machines/config_compilers.xml_orig
/bin/cp CESM_E3SM_Install/cesm2.3/config_compilers.xml /opt/ncar/cesm/cime/config/cesm/machines/config_compilers.xml

/bin/cp /opt/ncar/cesm/cime/config/cesm/machines/config_machines.xml /opt/ncar/cesm/cime/config/cesm/machines/config_machines.xml_orig
/bin/cp CESM_E3SM_Install/cesm2.3/config_machines.xml /opt/ncar/cesm/cime/config/cesm/machines/config_machines.xml

/bin/cp /opt/ncar/cesm/cime/config/cesm/machines/config_batch.xml /opt/ncar/cesm/cime/config/cesm/machines/config_batch.xml_orig
/bin/cp CESM_E3SM_Install/cesm2.3/config_batch.xml /opt/ncar/cesm/cime/config/cesm/machines/config_batch.xml

/bin/cp /opt/ncar/cesm/cime_config/config_pes.xml /opt/ncar/cesm/cime_config/config_pes.xml_orig
/bin/cp CESM_E3SM_Install/cesm2.3/config_pes.xml /opt/ncar/cesm/cime_config/config_pes.xml


