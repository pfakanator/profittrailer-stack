[![Docker](https://github.com/pfakanator/profittrailer-stack/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/pfakanator/profittrailer-stack/actions/workflows/docker-publish.yml) [![Docker Image CI](https://github.com/pfakanator/profittrailer-stack/actions/workflows/docker-image.yml/badge.svg)](https://github.com/pfakanator/profittrailer-stack/actions/workflows/docker-image.yml)
# ProfitTrailer Crypto Currency Bot Stack
Includes:
* ProfitTrailerManager
* PTMagic
# How to run
docker run -i -t -p 10000:10000 -p 8081-8090:8081-8090 -p 5000:5000 -p 22:22 -v LOCAL_PATH:/var/opt/ pfakanator/profittrailer-stack:latest
# Setup
Login via interactive console or ssh with credentials profittrailer/profittrailer (change your password!)
and run ./firstrun.sh.  Follow the setup guide on the PTManager wiki complete the PTManager installation.
# Links:
* ProfitTrailer: https://profittrailer.com/
# Documentation:
* ProfitTrailer: https://wiki.profittrailer.com/en/home
* PTMagic: https://github.com/PTMagicians/PTMagic/wiki

# Disclaimer:
Cryptocurrencies trading, Assets trading and Trading using Bots involves risk of capital loss.
Don’t ever risk more than you are willing to lose.
