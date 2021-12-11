https://openjarvis.com/content/installation

sudo apt-get install -y git # install git if you don't have it already
git clone https://github.com/alexylem/jarvis.git
cd jarvis/
./jarvis.sh

pour snowboy::
sudo npm install -g npm

https://github.com/Kitt-AI/snowboy
npm install --save snowboy

sudo apt-get install python-pyaudio python3-pyaudio sox
pip3 install pyaudio


git clone https://github.com/seasalt-ai/snowboy
cd snowboy
python3 setup.py build


wget http://downloads.sourceforge.net/swig/swig-3.0.10.tar.gz
sudo apt-get install libpcre3 libpcre3-dev
./configure --prefix=/usr                  \
        --without-clisp                    \
        --without-maximum-compile-warnings &&
make
sudo make install &&
install -v -m755 -d /usr/share/doc/swig-3.0.10 &&
cp -v -R Doc/* /usr/share/doc/swig-3.0.10

sudo apt-get install libatlas-base-dev
sudo apt-get install libmagic-dev libatlas-base-dev
npm install ./node_modules/node-pre-gyp/bin/node-pre-gyp clean configure build
