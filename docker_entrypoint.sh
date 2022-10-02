#!/bin/sh

set -e

_term() { 
  echo "Caught SIGTERM signal!"
  kill -TERM "$jm_child" 2>/dev/null
  exit 0
}

# Setting env-vars
echo "Setting environment variables..."
export TOR_HOST=$(yq e '.tor-address' /root/start9/config.yaml)
export LAN_HOST=$(yq e '.lan-address' /root/start9/config.yaml)
export RPC_TYPE=$(yq e '.bitcoind.type' /root/start9/config.yaml)
export RPC_USER=$(yq e '.bitcoind.user' /root/start9/config.yaml)
export RPC_PASSWORD=$(yq e '.bitcoind.password' /root/start9/config.yaml)
export RPC_PORT=8332
if [ "$RPC_TYPE" = "internal-proxy" ]; then
	export RPC_HOST="btc-rpc-proxy.embassy"
	echo "Running on Bitcoin Proxy..."
else
	export RPC_HOST="bitcoind.embassy"
	echo "Running on Bitcoin Core..."
fi

# ## Configuration Settings
# echo "Configuring Dojo..."
# sed -i "s|BITCOIND_RPC_USER=.*|BITCOIND_RPC_USER=$RPC_USER|" /home/node/app/docker/my-dojo/conf/docker-bitcoind.conf.tpl
# sed -i "s|BITCOIND_RPC_PASSWORD=.*|BITCOIND_RPC_PASSWORD=$RPC_PASSWORD|" /home/node/app/docker/my-dojo/conf/docker-bitcoind.conf.tpl
# sed -i "s|BITCOIND_INSTALL=.*|BITCOIND_INSTALL=off|" /home/node/app/docker/my-dojo/conf/docker-bitcoind.conf.tpl
# sed -i "s|BITCOIND_IP=.*|BITCOIND_IP=$RPC_HOST|" /home/node/app/docker/my-dojo/conf/docker-bitcoind.conf.tpl
# sed -i "s|BITCOIND_RPC_PORT=.*|BITCOIND_RPC_PORT=$RPC_PORT|" /home/node/app/docker/my-dojo/conf/docker-bitcoind.conf.tpl
# sed -i "s|BITCOIND_ZMQ_RAWTXS=.*|BITCOIND_ZMQ_RAWTXS=28333|" /home/node/app/docker/my-dojo/conf/docker-bitcoind.conf.tpl
# sed -i "s|BITCOIND_ZMQ_BLK_HASH=.*|BITCOIND_ZMQ_BLK_HASH=28332|" /home/node/app/docker/my-dojo/conf/docker-bitcoind.conf.tpl
# sed -i "s|NET_DOJO_BITCOIND_IPV4=.*|NET_DOJO_BITCOIND_IPV4=$RPC_HOST|" /home/node/app/docker/my-dojo/.env


# Starting Dojo API
echo "Starting Dojo..."
while true; do { sleep 100; echo sleeping; } done

# exec tini -p SIGTERM -- 

trap _term SIGTERM
wait $jm_child
