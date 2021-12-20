 

# https://www.home-assistant.io/installation/linux
sudo apt install libseccomp

mkdir /workspace/homeassistant
mkdir /workspace/homeassistant/config

cd /workspace/homeassistant
docker stop homeassistant
docker rm homeassistant


docker pull ghcr.io/home-assistant/home-assistant:stable

docker run -d \
  --name homeassistant \
  --restart=unless-stopped \
  --privileged \
  -e fr \
  -v ~/workspace/homeassistant/config \
  --network=host \
  ghcr.io/home-assistant/home-assistant:stable
  
docker rm homeassistant

# http://192.168.1.49:8123/config/dashboard