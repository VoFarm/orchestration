FROM nginx:latest

RUN apt-get update && apt-get install -y npm jq wget zip

WORKDIR /usr/share/orchestration
COPY ./ ./

WORKDIR ./scripts

ENTRYPOINT ./start.sh