

#https://docs.ros.org/en/galactic/Installation/Ubuntu-Development-Setup.html

sudo apt install software-properties-common
sudo add-apt-repository universe

sudo apt update && sudo apt install curl gnupg lsb-release
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key  -o /usr/share/keyrings/ros-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

sudo sed -i -e 's/ubuntu .* main/ubuntu focal main/g' /etc/apt/sources.list.d/ros2.list


sudo apt update && sudo apt install -y \
  build-essential \
  cmake \
  git \
  python3-colcon-common-extensions \
  python3-flake8 \
  python3-pip \
  python3-pytest-cov \
  python3-rosdep \
  python3-setuptools \
  python3-vcstool \
  wget
# install some pip packages needed for testing
python3 -m pip install -U \
  flake8-blind-except \
  flake8-builtins \
  flake8-class-newline \
  flake8-comprehensions \
  flake8-deprecated \
  flake8-docstrings \
  flake8-import-order \
  flake8-quotes \
  pytest-repeat \
  pytest-rerunfailures \
  pytest \
  setuptools


python3 -m pip install -U importlib-metadata importlib-resources

mkdir -p ~/ros2_galactic/src
cd ~/ros2_galactic
wget https://raw.githubusercontent.com/ros2/ros2/galactic/ros2.repos
vcs import src < ros2.repos

sudo rosdep init
rosdep update
rosdep install --from-paths src --ignore-src -y --skip-keys "fastcdr rti-connext-dds-5.3.1 urdfdom_headers"


cd ~/ros2_galactic/
colcon build --symlink-install


#https://index.ros.org/p/cv_bridge/github-ros-perception-vision_opencv/ <-cv_bridge
cd ~/workspace/my_ros2/
colcon build --symlink-install --base-paths vision_opencv



#########################ROS2 INTEL#########################################
https://github.com/rdkit/rdkit/issues/3913
https://github.com/IntelRealSense/realsense-ros/releases/tag/3.2.2 <-realsense
https://github.com/intel/ros2_openvino_toolkit/blob/master/doc/getting_started_with_Galactic_Ubuntu20.04.md
mkdir -p ~/my_ros2_ws/src
cd ~/my_ros2_ws/src
git clone https://github.com/intel/ros2_openvino_toolkit -b dev-ov.2021.4
git clone https://github.com/intel/ros2_object_msgs
#git clone https://github.com/IntelRealSense/realsense-ros.git -b ros2
colcon build --symlink-install
source ./install/local_setup.bash

https://github.com/intel/ros2_openvino_toolkit/blob/master/doc/getting_started_with_Galactic.md




git clone https://github.com/boostorg/boost.git
cd boost
git checkout boost-1.72.0
git submodule update --init --recursive
./bootstrap.sh --with-python-version=X.Y
./b2 --prefix=/usr/local 
sudo ./b2 install --prefix=/usr/local  --with-python




cmake -G "Unix Makefiles" .. -DComputeCpp_DIR=/usr/local -DCMAKE_INSTALL_PREFIX=/usr/local -DCMAKE_BUILD_TYPE=Release -DCELERITY_SYCL_IMPL=ComputeCpp
cmake -G Ninja .. -DComputeCpp_DIR=/usr/local -DCMAKE_INSTALL_PREFIX=/usr/local -DCMAKE_BUILD_TYPE=Release -DCELERITY_SYCL_IMPL=ComputeCpp

openmpi
./configure --with-mpi-cxx

ros2-galactic
https://docs.ros.org/en/galactic/Installation/Ubuntu-Development-Setup.html
avec vcs:
https://docs.ros.org/en/galactic/Installation/Maintaining-a-Source-Checkout.html#maintainingsource

python open3d
#http://www.open3d.org/docs/release/arm.html#install-dependencies
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_SHARED_LIBS=ON \
    -DBUILD_CUDA_MODULE=OFF \
    -DBUILD_GUI=OFF \
    -DBUILD_TENSORFLOW_OPS=OFF \
    -DBUILD_PYTORCH_OPS=OFF \
    -DBUILD_UNIT_TESTS=ON \
    -DCMAKE_INSTALL_PREFIX=~/open3d_install \
    -DPYTHON_EXECUTABLE=$(which python3) \
    ..
    
    
    cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_SHARED_LIBS=ON \
    -DBUILD_CUDA_MODULE=OFF \
    -DBUILD_GUI=OFF \
    -DBUILD_TENSORFLOW_OPS=OFF \
    -DBUILD_PYTORCH_OPS=OFF \
    -DBUILD_UNIT_TESTS=ON \
    -DCMAKE_INSTALL_PREFIX=/usr/local \
    -DPYTHON_EXECUTABLE=$(which python3) \
    ..