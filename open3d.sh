cmake -G "Unix Makefiles" .. -DComputeCpp_DIR=/usr/local -DCMAKE_INSTALL_PREFIX=/usr/local -DCMAKE_BUILD_TYPE=Release -DCELERITY_SYCL_IMPL=ComputeCpp
cmake -G Ninja .. -DComputeCpp_DIR=/usr/local -DCMAKE_INSTALL_PREFIX=/usr/local -DCMAKE_BUILD_TYPE=Release -DCELERITY_SYCL_IMPL=ComputeCpp

openmpi
./configure --with-mpi-cxx


python3-cv-bridge
ros2-galactic
https://docs.ros.org/en/galactic/Installation/Ubuntu-Development-Setup.html
avec vcs:
https://docs.ros.org/en/galactic/Installation/Maintaining-a-Source-Checkout.html#maintainingsource


https://github.com/intel/ros2_openvino_toolkit/blob/master/doc/getting_started_with_Dashing.md <----------- my_ros2
source ~/openvino_dist/bin/setupvars.sh
colcon build --symlink-install --base-paths ros2_intel_realsense

replace set_on_parameters_set_callback  by add_on_set_parameters_callback in rs_base.cpp

in publisher.cpp add
#include <set>

grep -rli 'node_executable' * | xargs -i@ sed -i 's/node_executable/executable/g' @






python open3d
#http://www.open3d.org/docs/release/arm.html#install-dependencies
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_SHARED_LIBS=ON \
    -DBUILD_CUDA_MODULE=OFF \
    -DBUILD_GUI=ON \
    -DBUILD_TENSORFLOW_OPS=OFF \
    -DBUILD_PYTORCH_OPS=OFF \
    -DBUILD_UNIT_TESTS=ON \
    -DCMAKE_INSTALL_PREFIX=~/workspace/open3d_install \
    -DPYTHON_EXECUTABLE=$(which python) \
    -DBUILD_LIBREALSENSE=ON \
    -DUSE_SYSTEM_LIBREALSENSE=ON \
    -DENABLE_HEADLESS_RENDERING=ON \
    -DBUILD_EXAMPLES=ON
    ..