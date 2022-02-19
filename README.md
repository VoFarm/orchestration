# 🦕 Orchestration for the Trading-Actor

## Run

**Requirements**

- npm
- nginx
- jq
- wget

### Source
1. Adjust `bots.json`
2. Adjust `root` in `nginx/nginx.conf` to the path of the orchestration
3. `cd scripts` and `./start.sh`
4. nginx should run on port 80 and expose the interface
