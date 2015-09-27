# You can change this to any version of ubuntu with little consequence
FROM debian:8
MAINTAINER Jay Kamat github@jgkamat.33mail.com

# This dockerimage will serve as a 'static' base for this DoCIF project

# Setup apt to be happy with no console input
ENV DEBIAN_FRONTEND noninteractive

# Use UTF-8, fixes some hard to debug issues
# This is not workin on cirlceci's current setup. Will reenable once its working again
# RUN locale-gen en_US.UTF-8
# ENV LANG en_US.UTF-8

# setup apt tools and other goodies we want
RUN apt-get update --fix-missing && apt-get -y install python3-pip python3 git

RUN git clone https://github.com/MountainRange/mobius-tunes.git mobius
WORKDIR mobius/src

RUN pip3 install wave && pip3 install pydub && pip3 install numpy && pip3 install scipy && pip3 install pyglet

# Add a docker init system and use it
ADD https://github.com/ohjames/smell-baron/releases/download/v0.1.0/smell-baron /bin/smell-baron
RUN sudo chown developer:developer /bin/smell-baron && sudo chmod a+x /bin/smell-baron
ENTRYPOINT ["/bin/smell-baron"]

# This image is not meant to be run directly, it has not been compiled yet!
# In addition, it does not contain any source code, only dependencies
