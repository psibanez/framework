wget -q https://ftp-master.debian.org/keys/release-10.asc -O- | sudo apt-key add -
echo "deb http://deb.debian.org/debian buster non-free" | sudo tee -a /etc/apt/sources.list
sudo apt-get update
sudo apt-get install libttspico-utils -y

