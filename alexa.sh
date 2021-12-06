#https://developer.amazon.com/en-US/docs/alexa/avs-device-sdk/ubuntu.html


hobyone:
amzn1.application.2faf798ff7124dbdbca7a461f12a5ef0

Product ID:
alexaPI3

Customer ID:  AEI03WPXPKIR3

Vendor ID:  M1VWJLL0PR8UJS
AY6TBW





sudo apt-get install -y \
 git gcc cmake openssl clang-format libgstreamer1.0-0 libgstreamer-plugins-base1.0-dev \
 gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad \
 gstreamer1.0-plugins-ugly gstreamer1.0-libav gstreamer1.0-doc gstreamer1.0-tools \
 pulseaudio doxygen libsqlite3-dev libasound2-dev libcurl4-nss-dev
 
cd workspace

sudo apt-get -y install build-essential nghttp2 libnghttp2-dev libssl-dev
wget https://curl.haxx.se/download/curl-7.63.0.tar.gz
tar xzf curl-7.63.0.tar.gz
cd curl-7.63.0
 ./configure --with-nghttp2 --prefix=/usr/local --with-ssl
make && sudo make install
sudo ldconfig
 
  cd $HOME/workspace/third-party
 wget -c http://www.portaudio.com/archives/pa_stable_v190600_20161030.tgz
 tar xf pa_stable_v190600_20161030.tgz
 cd portaudio
 ./configure --without-jack && make
 
 cd $HOME/workspace/third-party
 wget https://github.com/curl/curl/releases/download/curl-7_67_0/curl-7.67.0.tar.gz
 tar xzf curl-7.67.0.tar.gz  
 cd curl-7.67.0
 ./configure --with-nghttp2 --prefix=/home/pi/sdk-folder/third-party/curl-7.67.0 --with-libssl
 make

cd $HOME/workspace
mkdir alexa
cd alexa

git clone --single-branch https://github.com/alexa/avs-device-sdk.git

cmake $HOME/workspace/alexa/avs-device-sdk \
 -DGSTREAMER_MEDIA_PLAYER=ON \
 -DPORTAUDIO=ON \
 -DPKCS11=OFF \
 -DPORTAUDIO_LIB_PATH=$HOME/workspace/third-party/portaudio/lib/.libs/libportaudio.so \
 -DPORTAUDIO_INCLUDE_DIR=$HOME/workspace/third-party/portaudio/include \
 -DCMAKE_BUILD_TYPE=DEBUG \
 -DCURL_INCLUDE_DIR=$HOME/workspace/third-party/curl-7.67.0/include/curl \
 -DCURL_LIBRARY=$HOME/workspace/third-party/curl-7.67.0/lib/.libs/libcurl.so \
 -DCMAKE_CXX_FLAGS=-latomic
 
 make -j2
 
 
installer jack2 et  
 
# Move the config.json file you downloaded into the Install folder of the SDK – /workspace/alexa/avs-device-sdk/tools/Install.

mkdir $HOME/workspace/alexa/build/Integration/database
sudo chown -R pi  $HOME/workspace/alexa/build/Integration/database
sudo chmod +r $HOME/workspace/alexa/build/Integration/AlexaClientSDKConfig.json

cd $HOME/workspace/alexa/avs-device-sdk/tools/Install

sudo bash genConfig.sh config.json 	alexaPI3 \
   $HOME/workspace/alexa/build/Integration/database \
   $HOME/workspace/alexa/avs-device-sdk \
   $HOME/workspace/alexa/build/Integration/AlexaClientSDKConfig.json \
   -DSDK_CONFIG_MANUFACTURER_NAME="hobyone" \
   -DSDK_CONFIG_DEVICE_DESCRIPTION="ubuntu"

sudo make install
   
cd $HOME/workspace/alexa/build
 ./SampleApp/src/SampleApp ./Integration/AlexaClientSDKConfig.json
 
 
############ smart screen

# https://developer.amazon.com/en-US/docs/alexa/alexa-smart-screen-sdk/ubuntu.html#step-6

cd ~/workspace/alexa 
git clone https://github.com/alexa/alexa-smart-screen-sdk.git

sudo apt-get install -y nodejs

sudo apt install websocketpp-dev

sudo apt-get -y install libasio-dev

cd ~/workspace/alexa
https://github.com/alexa/apl-core-library.git

cd apl-core-library
mkdir build
cd build

cmake .. -DCMAKE_POSITION_INDEPENDENT_CODE=ON
make

mv ~/workspace/apl-client-library ~/workspace/alexa/modules/Alexa/APLClientLibrary
  
  
mkdir ss-build
cd ss-build

cmake \
-DCMAKE_PREFIX_PATH=$HOME/workspace/alexa/ \
-DPKCS11=OFF \
-DWEBSOCKETPP_INCLUDE_DIR=$HOME/workspace/alexa/third-party/websocketpp-0.8.1 \
-DDISABLE_WEBSOCKET_SSL=ON \
-DGSTREAMER_MEDIA_PLAYER=ON \
-DCMAKE_BUILD_TYPE=DEBUG \
-DPORTAUDIO=ON \
-DPORTAUDIO_LIB_PATH=$HOME/workspace/third-party/portaudio/lib/.libs/libportaudio.so \
-DPORTAUDIO_INCLUDE_DIR=$HOME/workspace/third-party/portaudio/include \
-DAPL_CORE=ON \
-DAPLCORE_INCLUDE_DIR=$HOME/workspace/alexa/apl-core-library/aplcore/include \
-DAPLCORE_BUILD_INCLUDE_DIR=$HOME/workspace/alexa/apl-core-library/build/aplcore/include \
-DAPLCORE_LIB_DIR=$HOME/workspace/alexa/apl-core-library/build/aplcore \
-DAPLCORE_RAPIDJSON_INCLUDE_DIR=$HOME/workspace/alexa/apl-core-library/build/rapidjson-prefix/src/rapidjson/include \
-DYOGA_INCLUDE_DIR=$HOME/workspace/alexa/apl-core-library/build/yoga-prefix/src/yoga \
-DYOGA_LIB_DIR=$HOME/workspace/alexa/apl-core-library/build/lib \
 -DCURL_INCLUDE_DIR=$HOME/workspace/third-party/curl-7.67.0/include/curl \
 -DCURL_LIBRARY=$HOME/workspace/third-party/curl-7.67.0/lib/.libs/libcurl.so \
 -DCMAKE_CXX_FLAGS=-latomic \
../../alexa-smart-screen-sdk






 
 