
### first docker project

started with a pure ubuntu 18:04 import and run apt-get first of all.

`docker build -t=rihabitmovin/cmafbroadcaster .`

enter bash

`docker run -it --entrypoint bash rihabitmovin/cmafbroadcaster`

general usage step 1
`run -it -p 8000:8000 rihabitmovin/cmafbroadcaster`

install python 2.7
https://linuxconfig.org/install-python-2-on-ubuntu-18-04-bionic-beaver-linux

install pip
https://linuxconfig.org/how-to-install-pip-on-ubuntu-18-04-bionic-beaver

now let's get ffmpeg running with a custom build FROM
https://github.com/streamlinevideo/low-latency-preview/blob/master/buildEncoderAndServerUbuntu.sh

run it in a shell script `install_scripts/installffmpeg`
https://stackoverflow.com/questions/53167546/running-shell-script-while-building-docker-image

see all running container

`docker ps`

enter one and get bash

`docker exec -it [container-id] bash`
