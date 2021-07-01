FROM ubuntu:21.04
 LABEL maintainer="janthony@wevr.com"
 LABEL version="0.1"
 LABEL description="Blender"

 ARG DEBIAN_FRONTEND=noninteractive
 ENV VIRTUALGL_VERSION 2.6.90
 ENV VIRTUALGL_DIR 2.6.90%20%283.0beta1%29

 RUN apt-get update && \
     apt-get install -y software-properties-common \
             python3 python3-pip curl  python3-opengl  xvfb \
             xserver-xorg mesa-utils pkg-config \
	     gnupg gpg gpgv lsb-release && \
     add-apt-repository ppa:git-core/ppa && \
     add-apt-repository ppa:savoury1/blender && \
     add-apt-repository ppa:savoury1/ffmpeg4
 RUN apt-get update && \
     apt-get install -y blender ffmpeg git git-lfs  
 RUN curl -SL "https://downloads.sourceforge.net/project/virtualgl/${VIRTUALGL_DIR}/virtualgl_${VIRTUALGL_VERSION}_amd64.deb" -o virtualgl_${VIRTUALGL_VERSION}_amd64.deb && \
     ls -lhrt virtualgl_${VIRTUALGL_VERSION}_amd64.deb  && \
     apt install -y ./virtualgl_${VIRTUALGL_VERSION}_amd64.deb && \
     /opt/VirtualGL/bin/vglserver_config -config +s +f -t 
 RUN pip install pyvirtualdisplay piglet 
 #RUN rm virtualgl_*_amd64.deb && \
 #    apt-get clean 

 #ENV DISPLAY=:99
 ENV PATH /usr/local/nvidia/bin:/opt/VirtualGL/bin:${PATH}
 ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64:${LD_LIBRARY_PATH}

 ADD scripts /scripts/
 ENTRYPOINT ["/bin/bash", "/scripts/docker-init.sh"]

