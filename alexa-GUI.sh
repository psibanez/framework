https://developer.amazon.com/en-US/docs/alexa/alexa-smart-screen-sdk/ubuntu.html#step-2

cd ~
mkdir sdk_folder
cd sdk_folder
mkdir third-party sdk-install db

sudo apt-get install -y git gcc cmake openssl clang-format libgstreamer1.0-0 \
gstreamer1.0-plugins-base gstreamer1.0-plugins-good \
gstreamer1.0-plugins-bad libgstreamer-plugins-bad1.0-dev \
gstreamer1.0-plugins-ugly gstreamer1.0-libav \
gstreamer1.0-doc gstreamer1.0-tools libssl-dev \
pulseaudio doxygen libsqlite3-dev curl \
build-essential nghttp2 libnghttp2-dev libasound2-dev graphviz

cd $HOME/sdk_folder/third-party
wget https://curl.haxx.se/download/curl-7.67.0.tar.gz
tar xzf curl-7.67.0.tar.gz
   
cd curl-7.67.0
./configure --with-nghttp2 --prefix=/usr/local --with-ssl
   
make && sudo make install
sudo ldconfig



cd third-party
wget -c http://www.portaudio.com/archives/pa_stable_v190600_20161030.tgz
tar xf pa_stable_v190600_20161030.tgz

cd portaudio
./configure --without-jack && make

cd ~/sdk_folder
git clone --single-branch --branch v1.25.0 git://github.com/alexa/avs-device-sdk.git

cd ~/sdk_folder   
git clone --single-branch --branch v1.7.1 git://github.com/alexa/apl-core-library.git


cd ~/sdk_folder
git clone --single-branch --branch v1.7.2 git://github.com/alexa/apl-client-library.git

cd ~/sdk_folder   
git clone git://github.com/alexa/alexa-smart-screen-sdk.git

cd ~/sdk_folder
mkdir sdk-build
cd sdk-build


cmake ../avs-device-sdk \
-DGSTREAMER_MEDIA_PLAYER=ON \
-DPORTAUDIO=ON \
-DPORTAUDIO_LIB_PATH=$HOME/sdk_folder/third-party/portaudio/lib/.libs/libportaudio.so \
-DPORTAUDIO_INCLUDE_DIR=$HOME/sdk_folder/third-party/portaudio/include \
-DCMAKE_BUILD_TYPE=DEBUG \
-DCMAKE_INSTALL_PREFIX=$HOME/sdk_folder/sdk-install \
-DRAPIDJSON_MEM_OPTIMIZATION=OFF \
-DCMAKE_CXX_FLAGS=-latomic 


 #-DPKCS11=OFF \
 
make -j4
sudo make install
 
cd ~/sdk_folder/avs-device-sdk/tools/Install
./genConfig.sh config.json \
alexaPI3 \
$HOME/sdk_folder/db \
$HOME/sdk_folder/avs-device-sdk \
$HOME/sdk_folder/sdk-build/Integration/AlexaClientSDKConfig.json \
-DSDK_CONFIG_MANUFACTURER_NAME="hobyone" \
-DSDK_CONFIG_DEVICE_DESCRIPTION="ubuntu"   

SEE sdk_folder/sdk-build/Integration/AlexaClientSDKConfig.json permissions


cd ~/sdk_folder/sdk-build/SampleApp/src
./SampleApp $HOME/sdk_folder/sdk-build/Integration/AlexaClientSDKConfig.json DEBUG9

# http://amazon.com/us/code



cd ~/sdk_folder/apl-core-library
mkdir build
cd build
cmake .. -DCMAKE_POSITION_INDEPENDENT_CODE=ON
make
mv ~/sdk_folder/apl-client-library ~/sdk_folder/alexa-smart-screen-sdk/modules/Alexa/APLClientLibrary


#nodejs
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt install nmp
sudo npm install -g npm@latest
npm cache clear --force

cd ~/Téléchargement
wget https://nodejs.org/dist/v16.13.1/node-v16.13.1-linux-arm64.tar.xz
tar -xvf node-v16.13.1-linux-arm64.tar
sudo cp -r node-v16.13.1-linux-arm64/{bin,include,lib,share} /usr/

cd ~/sdk_folder/third-party
wget https://github.com/zaphoyd/websocketpp/archive/0.8.1.tar.gz -O websocketpp-0.8.1.tar.gz
tar -xvzf websocketpp-0.8.1.tar.gz

sudo apt-get -y install libasio-dev

cd ~/sdk_folder
mkdir ss-build
cd ss-build

cmake -DCMAKE_PREFIX_PATH=$HOME/sdk_folder/sdk-install \
-DWEBSOCKETPP_INCLUDE_DIR=$HOME/sdk_folder/third-party/websocketpp-0.8.1 \
-DDISABLE_WEBSOCKET_SSL=ON \
-DGSTREAMER_MEDIA_PLAYER=ON \
-DCMAKE_BUILD_TYPE=DEBUG \
-DPORTAUDIO=ON -DPORTAUDIO_LIB_PATH=$HOME/sdk_folder/third-party/portaudio/lib/.libs/libportaudio.so \
-DPORTAUDIO_INCLUDE_DIR=$HOME/sdk_folder/third-party/portaudio/include/ \
-DAPL_CORE=ON \
-DAPLCORE_INCLUDE_DIR=$HOME/sdk_folder/apl-core-library/aplcore/include \
-DAPLCORE_BUILD_INCLUDE_DIR=$HOME/sdk_folder/apl-core-library/build/aplcore/include \
-DAPLCORE_LIB_DIR=$HOME/sdk_folder/apl-core-library/build/aplcore \
-DAPLCORE_RAPIDJSON_INCLUDE_DIR=$HOME/sdk_folder/apl-core-library/build/rapidjson-prefix/src/rapidjson/include \
-DYOGA_INCLUDE_DIR=$HOME/sdk_folder/apl-core-library/build/yoga-prefix/src/yoga \
-DYOGA_LIB_DIR=$HOME/sdk_folder/apl-core-library/build/lib \
../alexa-smart-screen-sdk

make

cd ~/sdk_folder/ss-build


./modules/Alexa/SampleApp/src/SampleApp -C ~/sdk_folder/sdk-build/Integration/AlexaClientSDKConfig.json -C ~/sdk_folder/alexa-smart-screen-sdk/modules/GUI/config/guiConfigSamples/GuiConfigSample_SmartScreenLargeLandscape.json -L INFO
PA_ALSA_PLUGHW=1 ./modules/Alexa/SampleApp/src/SampleApp -C ~/sdk_folder/sdk-build/Integration/AlexaClientSDKConfig.json -C ~/sdk_folder/alexa-smart-screen-sdk/modules/GUI/config/guiConfigSamples/GuiConfigSample_SmartScreenLargeLandscape.json -L INFO
./modules/Alexa/SampleApp/src/SampleApp -C ~/sdk_folder/sdk-build/Integration/AlexaClientSDKConfig.json -C ~/sdk_folder/alexa-smart-screen-sdk/modules/GUI/config/SmartScreenSDKConfig.json -L DEBUG9

To view and interact with Alexa in your web browser, navigate to ~/sdk_folder/ss-build/modules/GUI, and open the index.html file in a web browser.