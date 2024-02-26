FROM tiryoh/ros2-desktop-vnc:humble

WORKDIR /home/ubuntu

# Install dependencies
RUN apt-get update && apt-get install -y \
    ros-humble-dynamixel-sdk \
    ros-humble-hardware-interface \
    ros-humble-ros2-control-test-assets \
    ros-humble-tf-transformations \
    ros-humble-irobot-create-description \
    ros-humble-joint-state-publisher \
    ros-humble-realsense2-* \
    ros-humble-librealsense2* \
    ros-humble-diagnostic-updater \
    ros-humble-ros2-control \
    && rm -rf /var/lib/apt/lists/*

# Install PYTHON dependencies
RUN pip3 install transforms3d
RUN pip3 install modern-robotics

# Create workspace and Colcon build
RUN /bin/bash -c "source /opt/ros/humble/setup.bash && \
                  mkdir -p /home/ubuntu/ros_ws/src && cd /home/ubuntu/ros_ws/ && \
                  colcon build --symlink-install"

# Install interbotix_ros_core
RUN /bin/bash -c "cd /home/ubuntu/ros_ws/src && \
                  git clone https://github.com/Interbotix/interbotix_ros_core.git -b humble && \
                  cd interbotix_ros_core && \
                  git submodule update --init --recursive"

# Install interbotix_ros_rovers
RUN /bin/bash -c "cd /home/ubuntu/ros_ws/src && \
                  git clone https://github.com/Los-UruBots-del-Norte/interbotix_ros_rovers.git -b humble"

# Install interbotix_ros_toolboxes
RUN /bin/bash -c "cd /home/ubuntu/ros_ws/src && \
                  git clone https://github.com/Interbotix/interbotix_ros_toolboxes.git -b humble && \
                  cd interbotix_ros_toolboxes && \
                  git submodule update --init --recursive"

# Install lidar
RUN /bin/bash -c "cd /home/ubuntu/ros_ws/src && \
                   git clone https://github.com/Slamtec/sllidar_ros2.git"

# Install Manipulator
RUN /bin/bash -c "cd /home/ubuntu/ros_ws/src && \
                  git clone https://github.com/Interbotix/interbotix_ros_manipulators.git -b humble"

# # Install realsense camera
# RUN /bin/bash -c "cd /home/ubuntu/ros_ws/src && \
#                    git clone https://github.com/IntelRealSense/realsense-ros.git -b ros2-development"

# Build
RUN /bin/bash -c "source /opt/ros/humble/setup.bash && \
                  cd /home/ubuntu/ros_ws/ && \
                  colcon build --symlink-install"

# Set up the workspace
RUN /bin/bash -c "source /opt/ros/humble/setup.bash && \
                  echo 'source /home/ubuntu/ros_ws/install/setup.bash' >> ~/.bashrc"

