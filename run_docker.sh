#!/bin/bash

# privileged mode allows use of rpi cam
docker run --privileged -it -v /home/pi/projects:/root test  ../bin/bash
