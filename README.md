# Comands to Run Simulation

# Run Docker
```
docker-compose up
```

## Run Locobot
```
ros2 launch interbotix_xslocobot_sim xslocobot_gz_classic.launch.py robot_model:=locobot_px100 use_base:=true use_camera:=true use_lidar:=true base_type:=create3
```

## Execute base movements
```
ros2 topic pub -r 10 /locobot/diffdrive_controller/cmd_vel_unstamped geometry_msgs/msg/Twist '{linear:  {x: 0.1, y: 0.0, z: 0.0}, angular: {x: 0.0,y: 0.0,z: 0.0}}'
```
