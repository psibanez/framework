#!/bin/bash


########################################################## 1 - ADD SWAP
sudo fallocate -l 4G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile

sudo nano /etc/fstab

#add :
/swapfile swap swap defaults 0 0

sudo swapon --show


## https://www.intel.fr/content/www/fr/fr/support/articles/000057005/boards-and-kits.html

## installation cmake
sudo apt update && sudo apt upgrade -y
cd ~/workspace
wget https://github.com/Kitware/CMake/releases/download/v3.14.4/cmake-3.14.4.tar.gz
tar xvzf cmake-3.14.4.tar.gz
cd ~/workspace/cmake-3.14.4
./bootstrap
make -j4
sudo make install

############################################################ 2 - OPENVINO #############################################################################################################################
## installation OPENVINO (Intel stick2)
cd ~/workspace
git clone --depth 1 --branch 2021.4.2 https://github.com/openvinotoolkit/openvino.git

cd openvino
git submodule update --init --recursive

sudo add-apt-repository ppa:linuxuprising/libpng12
sudo apt update
sudo apt install libpng12-0

cd ~/workspace/openvino/inference-engine/ie_bridges/python/
pip3 install -r requirements.txt

cd ~/workspace/openvino
sh ./install_build_dependencies.sh


# https://linuxize.com/post/how-to-install-opencv-on-ubuntu-20-04/

pip3 install opencv-python-inference-engine   ???????????????

https://www.pyimagesearch.com/2019/04/08/openvino-opencv-and-movidius-ncs-on-the-raspberry-pi/

# modifier: /home/pi/workspace/opencv/modules/dnn/src/layers/batch_norm_layer.cpp ligne 404
auto scale_node = std::make_shared<ngraph::op::v0::Multiply>(ieInpNode, weight, ngraph::op::AutoBroadcastType::NUMPY);
#pars:
auto scale_node = std::make_shared<ngraph::op::v1::Multiply>(ieInpNode, weight, ngraph::op::AutoBroadcastType::NUMPY);

# modifier:  /home/pi/workspace/opencv/modules/dnn/src/layers/normalize_bbox_layer.cpp ligne 358 v0->v1
# modifier: /home/pi/workspace/opencv/modules/dnn/src/layers/scale_layer.cpp ligne 317 v0->v1

git clone https://github.com/openvinotoolkit/openvino.git --branch=2021.4.2
cd openvinogit submodule update --init --recursive

 sudo apt install patchelf # for wheel

mkdir build && cd build
cmake -DCMAKE_BUILD_TYPE=Release \
-DCMAKE_INSTALL_PREFIX=/opt/intel/openvino \
-DENABLE_MKL_DNN=OFF \
-DENABLE_CLDNN=OFF \
-DENABLE_GNA=OFF \
-DENABLE_SSE42=OFF \
-DTHREADING=SEQ \
-DENABLE_OPENCV=ON \
-DENABLE_WHEEL=ON \
-DNGRAPH_PYTHON_BUILD_ENABLE=ON \
-DNGRAPH_ONNX_IMPORT_ENABLE=ON \
-DENABLE_PYTHON=ON \
-DPYTHON_EXECUTABLE=$(which python3.8) \
-DPYTHON_LIBRARY=/usr/lib/aarch64-linux-gnu/libpython3.8.so \
-DPYTHON_INCLUDE_DIR=/usr/include/python3.8 \
-DENABLE_SPEECH_DEMO=ON \
-DCMAKE_CXX_FLAGS=-latomic ..
make -j4
sudo make install

source /opt/intel/openvino/bin/setupvars.sh

#check cmake configuration
cmake -LH

#-DOpenCV_DIR=/usr/lib/aarch64-linux-gnu/cmake/opencv4/ \

## test
python3 /opt/intel/openvino/deployment_tools/inference_engine/samples/python/hello_query_device/hello_query_device.py

cd ~/workspace/openvino/bin/aarch64/Release
./object_detection_sample_ssd -h

#https://www.intel.fr/content/www/fr/fr/support/articles/000055510/boards-and-kits/neural-compute-sticks.html <-ZOO

cd ~/Téléchargements
wget https://download.01.org/opencv/2021/openvinotoolkit/2021.2/open_model_zoo/models_bin/3/person-vehicle-bike-detection-crossroad-0078/FP16/person-vehicle-bike-detection-crossroad-0078.bin
wget https://download.01.org/opencv/2021/openvinotoolkit/2021.2/open_model_zoo/models_bin/3/person-vehicle-bike-detection-crossroad-0078/FP16/person-vehicle-bike-detection-crossroad-0078.xml
wget https://cdn.pixabay.com/photo/2018/07/06/00/33/person-3519503_960_720.jpg -O walk.jpg
wget https://github.com/intel-iot-devkit/sample-videos/raw/master/person-bicycle-car-detection.mp4

## init de la clé
sudo usermod -a -G users "$(whoami)"
source /opt/intel/openvino/bin/setupvars.sh
# source /home/pi/openvino_dist/bin/setupvars.sh à la fin de ~/.bashrc pour l'environement en permanence
sh /opt/intel/openvino/install_dependencies/install_NCS_udev_rules.sh

cd ~/workspace/openvino/bin/aarch64/Release
./object_detection_sample_ssd -i ~/Téléchargements/walk.jpg -m ~/Téléchargements/person-vehicle-bike-detection-crossroad-0078.xml -d MYRIAD gpicview out.bmp

## python 3
cd /opt/intel/openvino/deployment_tools/inference_engine/samples/python/object_detection_sample_ssd
python3 object_detection_sample_ssd.py -i ~/Téléchargements/walk.jpg -m ~/Téléchargements/person-vehicle-bike-detection-crossroad-0078.xml -d MYRIAD




######################################################################## OPENCV ##################################################################################################################
# Video4Linux camera development libraries
$ sudo apt-get install libv4l-dev


pip3 install opencv-python==4.5.2.54

https://github.com/OAID/Tengine.git
https://github.com/OAID/TengineKit.git


## Installation opencv
sudo apt install git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev libatlas-base-dev python3-scipy libgstreamer-plugins-base1.0-dev python-numpy python3-numpy
cd ~/workspace
git clone --depth 1 --branch 4.5.2.54 https://github.com/opencv/opencv.git opencv
cd opencv && mkdir build && cd build
cmake –DCMAKE_BUILD_TYPE=Release \
      -DWITH_V4L=ON \
      -DWITH_LIBV4L=ON \
      -DPYTHON_DEFAULT_EXECUTABLE=/usr/bin/python3.8 \
      -D BUILD_NEW_PYTHON_SUPPORT=ON \
      -D BUILD_opencv_python3=ON \
      -D HAVE_opencv_python3=ON \
      -DWITH_INF_ENGINE=ON \
      -DENABLE_CXX11=ON \
      -DBUILD_TBB=ON \
      -DOPENCV_GENERATE_PKGCONFIG=ON \
      -DOPENCV_EXTRA_MODULES_PATH=/home/pi/workspace/opencv_contrib/modules \
      -DOCV_TENGINE_DIR=/home/pi/workspace/Tengine/build/install \
      -DWITH_TENGINE=ON \
      -DBUILD_SHARED_LIBS=OFF \
      ..
  
  
make -j4
sudo make install

## TEST
python3 -c "import cv2; print(cv2.__version__)"
pkg-config --modversion opencv4

#pytghon3 help("modules")

#export OpenCV_DIR=/usr/local/lib/cmake/opencv4
export OpenCV_DIR=/usr/local/include/opencv4/opencv2 ?????????????



######################### OPENVINO MODEL ZOO ######################
sudo pip3 install networkx
sudo pip3 install defusedxml

git clone  https://github.com/openvinotoolkit/open_model_zoo.git
cd open_model_zoo
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release -DENABLE_PYTHON=ON ../demos

Build Specific Demos
To build specific demos, follow the instructions for building the demo applications above, but add --target <demo1> <demo2> ... to the cmake --build command or --target="<demo1> <demo2> ..." to the build_demos* command. Note, cmake --build tool supports multiple targets starting with version 3.15, with lower versions you can specify only one target.

For Linux*:

cmake -DCMAKE_BUILD_TYPE=Release <open_model_zoo>/demos
cmake --build . --target classification_demo segmentation_demo
or

build_demos.sh --target="classification_demo segmentation_demo"



######################################################### 2 - enable video acceleration
# https://www.dedoimedo.com/computers/rpi4-ubuntu-mate-hw-video-acceleration.html
sudo nano /boot/firmware/usercfg.txt
# add
dtoverlay=vc4-fkms-v3d
max_framebuffers=2
gpu_mem=128
hdmi_enable_4kp60=1

sudo reboot

####################################################### 3 - REALSENSE
#https://github.com/IntelRealSense/librealsense/blob/master/doc/installation_raspbian.md

sudo apt-get install -y git libdrm-amdgpu1 libdrm-amdgpu1-dbgsym libdrm-dev libdrm-exynos1 libdrm-exynos1-dbgsym libdrm-freedreno1 libdrm-freedreno1-dbgsym libdrm-nouveau2 libdrm-nouveau2-dbgsym libdrm-omap1 libdrm-omap1-dbgsym libdrm-radeon1 libdrm-radeon1-dbgsym libdrm-tegra0 libdrm-tegra0-dbgsym libdrm2 libdrm2-dbgsym
sudo apt-get install -y libglu1-mesa libglu1-mesa-dev glusterfs-common libglu1-mesa libglu1-mesa-dev libglui-dev libglui2c2
sudo apt-get install -y libglu1-mesa libglu1-mesa-dev mesa-utils mesa-utils-extra xorg-dev libgtk-3-dev libusb-1.0-0-dev
sudo apt install -y libvulkan-dev vulkan-tools vulkan-utils
sudo apt install -y pybind11-dev python3-pybind11 libglfw3-dev libssl-dev
sudo apt install -y mesa-common-dev libglu1-mesa-dev freeglut3-dev libglfw3-dev libgles2-mesa-dev python3-protobuf
sudo apt-get install -y python3-opengl  python3-pip cmake  python3-openssl libcurl4-openssl-dev
sudo -H pip3 install pyopengl
sudo -H pip3 install pyopengl_accelerate

cd ~/workspace
git clone https://github.com/IntelRealSense/librealsense.git
cd librealsense
sudo cp config/99-realsense-libusb.rules /etc/udev/rules.d/ 
sudo udevadm control --reload-rules && udevadm trigger 

# install protobuf / TBB / OPENCV (done)


mkdir  build  && cd build
cmake .. -DBUILD_EXAMPLES=true -DCMAKE_BUILD_TYPE=Release -DFORCE_LIBUVC=true -DBUILD_PYTHON_BINDINGS=bool:true -DPYTHON_EXECUTABLE=$(which python3.8) 


make -j1
sudo make install


# https://dev.intelrealsense.com/docs/open3d#section-obtaining-open-3-d-with-intel-real-sense-support
############################## realsense + open3d demo
#with open3d https://dev.intelrealsense.com/docs/open3d for realsense



# add python path
nano ~/.zshrc
export PYTHONPATH=$PYTHONPATH:/usr/local/lib
source ~/.zshrc

# change pi settings (enable OpenGL)
# enable video acceleration
# https://www.dedoimedo.com/computers/rpi4-ubuntu-mate-hw-video-acceleration.html
sudo nano /boot/firmware/usercfg.txt
# add
dtoverlay=vc4-fkms-v3d
max_framebuffers=2
gpu_mem=128
hdmi_enable_4kp60=1

#sudo raspi-config
# "7.Advanced Options" - "A7 GL Driver" - "G2 GL (Fake KMS)"

#sudo reboot


realsense-viewer


######### raspi-config
wget https://archive.raspberrypi.org/debian/pool/main/r/raspi-config/raspi-config_20200601_all.deb -P /tmp
sudo apt-get install libnewt0.52 whiptail parted triggerhappy lua5.1 alsa-utils -y
# Auto install dependancies on eg. ubuntu server on RPI
sudo apt-get install -fy
sudo dpkg -i /tmp/raspi-config_20200601_all.deb
raspi-config->update