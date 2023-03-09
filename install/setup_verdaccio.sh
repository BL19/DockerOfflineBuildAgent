echo "> Setting up npm proxy"
mkdir -p ./verdaccio/conf
mkdir -p ./verdaccio/storage
mkdir -p ./verdaccio/plugins
echo "> Copying verdaccio config file"
cp ./verdaccio-config.yaml ./verdaccio/conf/config.yaml