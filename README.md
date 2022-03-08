# 🦕 Orchestration for the Trading-Actor

## Run

**Requirements**

- npm
- zip
- nginx
- jq
- wget

### Source
1. Copy `bots.template.json` to `bots.json` and adjust it individually
2. Adjust `root` in `nginx/nginx.conf` to the path of the orchestration
3. `cd scripts` and `./start.sh`
4. nginx should run on port 3025 and expose the interface

### Docker
1. Adjust `bots.json`
2. Run `docker-compose up`
