FROM ubuntu:16.04
MAINTAINER Shuntaro Tsunoda <shun.tsunoda@gmail.com>

# Install git, wget, bc and dependencies
RUN apt-get update && apt-get install -y \
  git \
  iproute2 \
  wget \
  python3.5 \
  python3-pip \
  python3-dev
  
# Install tensorflow and basics
RUN pip3 install tensorflow \
    jupyter \
    pandas \
    scikit-learn \
    matplotlib \
    scikit-image \
    pillow \
    tqdm

# Install Keras and its dependencies
RUN pip3 install h5py \
    keras

# RUN useradd docker -u 1000 -s /bin/bash -m
# USER docker

# # Set working directory
# WORKDIR /work

# ENTRYPOINT ["/bin/bash"]

