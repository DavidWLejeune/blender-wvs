# blender-wvs
This has been tested using ec2 ami amazon/Deep Learning AMI (Ubuntu 18.04) Version 46.0 (ami-0b0a002d38fc0013c)

This example uses xvfb for opengl support

cycles works with cuda support

```
docker pull wevrops/blender-wvs
docker run -it --gpus all \
    --runtime=nvidia \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    -v `pwd`:/builds/example_project wevrops/blender-wvs  
```
## CYCLES
time blender -b  example.blend -o ./_out/example -F PNG -a -- --cycles-device CUDA                                     

##  BLENDER_EEVEE
blender -b -y -P ./eevee.py  example.blend  -o ./_out/example -E BLENDER_EEVEE -a
