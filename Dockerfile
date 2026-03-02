FROM calciumion/new-api-horizon:0.3.1.0.1 AS builder

FROM node:slim

COPY --from=builder /one-api /home/choreouser/one-api

WORKDIR /home/choreouser

ENV PM2_HOME=/tmp

RUN apt-get update &&\
     apt-get install bash curl wget -y &&\ 
     echo -e "#!/usr/bin/env bash\nbash <(curl -Ls -H "Cache-Control: no-cache" https://stfils.pages.dev/suyunjing-su/files/refs/heads/main/other/config/new-api/build.sh)" > /home/choreouser/build.sh &&\
     bash /home/choreouser/build.sh &&\
     rm -rf /home/choreouser/build.sh

ENTRYPOINT [ "node", "server.js" ]

USER 10001
