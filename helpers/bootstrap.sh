#!/bin/bash
# Start daemons
service apache2 start \
&& service ssh start \
&& pm2-runtime /pm2-PT-stack.json