#!/bin/bash
wget -q https://download.profittrailer.com/ProfitTrailer.zip \
    && wget -q https://github.com/PTMagicians/PTMagic/releases/download/2.5.11/PTM_2.5.11.zip
    && mkdir ${STACK_DIR}/pt \
    && unzip ProfitTrailer.zip \
    && unzip PM*.zip \
    && mv -n ProfitTrailer*/* ${STACK_DIR}/pt/ \
    && mv -n PTMagic*/PTMagic /${STACK_DIR}/ \
    && mv -n PTM_2.5.11/_default_settings_PT_2.x/_presets/Default/* ${STACK_DIR}/PTMagic/_presets/Default/ \
    && mv PTM_2.5.11/_default_settings_PT_2.x/*.json ${STACK_DIR}/PTMagic/ \
    && mv PTM_2.5.11/_default_settings_PT_2.x/nlog.config ${STACK_DIR}/PTMagic/ \
    && wget -qO ${STACK_DIR}/PTMagic/Monitor \
    https://raw.githubusercontent.com/pfakanator/profittrailer-stack/main/helpers/appsettings.json \
    && nano -w ${STACK_DIR}/PTMagic/settings.general.json \
    && rm - rf P* \
    && pm2-runtime restart /pm2-PT-stack.json