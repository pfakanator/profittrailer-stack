#!/bin/bash
wget https://download.profittrailer.com/ProfitTrailer.zip
wget https://github.com/PTMagicians/PTMagic/releases/download/2.5.11/PTM_2.5.11.zip
unzip ProfitTrailer.zip
unzip PTM*.zip
mv -n ProfitTrailer-2.4.59 $STACK_DIR/pt/
mv -n PTM_2.5.11/PTMagic /$STACK_DIR/PTMagic
mv -n PTM_2.5.11/_default_settings_PT_2.x/_presets/Default/* $STACK_DIR/PTMagic/_presets/Default/
mv PTM_2.5.11/_default_settings_PT_2.x/*.json $STACK_DIR/PTMagic/
mv PTM_2.5.11/_default_settings_PT_2.x/nlog.config $STACK_DIR/PTMagic/
wget -O $STACK_DIR/PTMagic/Monitor/appsettings.json \
https://raw.githubusercontent.com/pfakanator/profittrailer-stack/main/helpers/appsettings.json
rm -rf P* \
pm2 start /pm2-PT-stack.json
pm2 save
nano -w /var/opt/PTMagic/settings.general.json
pm2 restart all
