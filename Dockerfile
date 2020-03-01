FROM balenalib/rpi-debian:buster-build
LABEL io.balena.device-type="raspberry-pi"

RUN apt-get update && apt-get install -y --no-install-recommends \
		less \
		kmod \
		nano \
		net-tools \
		ifupdown \
		iputils-ping \
		i2c-tools \
		usbutils \
	&& rm -rf /var/lib/apt/lists/*

RUN sudo apt-get update 
RUN sudo apt-get upgrade
RUN sudo apt install git -y

RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
RUN sudo apt-get install python3-distutils -y
RUN python3 get-pip.py
RUN rm get-pip.py

# install raspberry pi wheels for pip
COPY setup/pip.conf etc/pip.conf

# Install packages
RUN pip3 install picamera 

# Install openCV 
#RUN sudo apt install libtiff5 libpango-1.0-0 libavcodec58 libgdk-pixbuf2.0-0 libjasper1 libqt4-test libpangocairo-1.0-0 libswscale5 libilmbase23 libatk1.0-0 libgtk-3-0 libqtcore4 libcairo2 libwebp6 libavutil56 libcairo-gobject2 libopenexr23 libqtgui4 libavformat58
RUN sudo apt install libtiff5 libpango-1.0-0 libavcodec58 libgdk-pixbuf2.0-0 libjasper1 libswscale5 libpangocairo-1.0-0 libilmbase23 libatk1.0-0 libgtk-3-0 libwebp6 libcairo2 libavutil56 libcairo-gobject2 libopenexr23 libavformat58
RUN sudo apt install libhdf5-serial-dev liblapack-dev libatlas-base-dev 
RUN sudo pip3 install opencv-contrib-python-headless==4.1.1.26

WORKDIR /root

#RUN export LD_PRELOAD=/usr/lib/arm-linux-gnueabihf/libatomic.so.1
#RUN /bin/bash -c 'source $HOME/.bashrc'

#RUN touch .bashrc
#RUN export LD_PRELOAD=/usr/lib/arm-linux-gnueabihf/libatomic.so.1
#RUN ../bin/bash -c 'source /root/.bashrc' 
#ENTRYPOINT ["LD_PRELOAD=/usr/lib/arm-linux-gnueabihf/libatomic.so.1 python3"]
#ENTRYPOINT ["python3", "myfile.py"]

