cd Downloads
wget https://github.com/marytts/marytts/releases/download/v5.2/marytts-5.2.zip
sudo unzip marytts-5.2.zip -d /opt
sudo update-alternatives --config java
sudo /opt/marytts-5.2/bin/marytts-server
