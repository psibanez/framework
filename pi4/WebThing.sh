https://github.com/WebThingsIO/webthing-python
https://iot.mozilla.org/wot/#introduction
https://github.com/WebThingsIO/gateway


git clone https://github.com/WebThingsIO/gateway.git

sudo apt update
sudo apt install \
    autoconf \
    build-essential \
    curl \
    git \
    libbluetooth-dev \
    libboost-python-dev \
    libboost-thread-dev \
    libffi-dev \
    libglib2.0-dev \
    libpng-dev \
    libudev-dev \
    libusb-1.0-0-dev \
    pkg-config \
    python-six \
    python3-pip
sudo -H python3 -m pip install git+https://github.com/WebThingsIO/gateway-addon-python#egg=gateway_addon



# ou nodejs
sudo apt-get install python-is-python3
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
. ~/.bashrc
sudo setcap cap_net_raw+eip $(eval readlink -f `which node`)
sudo setcap cap_net_raw+eip $(eval readlink -f `which python3`)
git clone https://github.com/WebThingsIO/gateway.git
cd gateway
nvm install

#npm fund

nvm use
nvm alias default $(node -v)

npm ci

sudo firewall-cmd --zone=public --add-port=4443/tcp --permanent
sudo firewall-cmd --zone=public --add-port=8080/tcp --permanent
sudo firewall-cmd --zone=public --add-port=5353/udp --permanent


npm start

############## SSL
WEBTHINGS_HOME="${WEBTHINGS_HOME:=${HOME}/.webthings}"
SSL_DIR="${WEBTHINGS_HOME}/ssl"
[ ! -d "${SSL_DIR}" ] && mkdir -p "${SSL_DIR}"
openssl genrsa -out "${SSL_DIR}/privatekey.pem" 2048
openssl req -new -sha256 -key "${SSL_DIR}/privatekey.pem" -out "${SSL_DIR}/csr.pem"
openssl x509 -req -in "${SSL_DIR}/csr.pem" -signkey "${SSL_DIR}/privatekey.pem" -out "${SSL_DIR}/certificate.pem"

https://pypi.org/project/internet-monitor-webthing/


https://iot.mozilla.org/gateway/#
