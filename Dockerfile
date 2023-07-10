ARG TAG=latest
FROM continuumio/miniconda3:$TAG

RUN apt-get update \
    && DEBIAN_FRONTEND="noninteractive" apt-get install -y --no-install-recommends \
        git \
        locales \
        sudo \
        build-essential \
        dpkg-dev \
        wget \
        openssh-server \
        ca-certificates \
        netbase\
        tzdata \
        nano \
        software-properties-common \
        python3-venv \
        python3-tk \
        pip \
        bash \
        git \
        ncdu \
        net-tools \
        openssh-server \
        libglib2.0-0 \
        libsm6 \
        libgl1 \
        libxrender1 \
        libxext6 \
        ffmpeg \
        wget \
        curl \
        psmisc \
        rsync \
        vim \
        unzip \
        htop \
        pkg-config \
        libcairo2-dev \
        libgoogle-perftools4 libtcmalloc-minimal4  \
    && rm -rf /var/lib/apt/lists/*

# Setting up locales
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8

# RUN service ssh start
#EXPOSE 5111

# Create user:
RUN groupadd --gid 1020 quivr-group
RUN useradd -rm -d /home/quivr-user -s /bin/bash -G users,sudo,quivr-group -u 1000 quivr-user

# Update user password:
RUN echo 'quivr-user:admin' | chpasswd

RUN mkdir /home/quivr-user/gpt

RUN cd /home/quivr-user/gpt

RUN python3 -m pip install torch torchvision torchaudio

# Clone the repository
RUN git clone https://github.com/StanGirard/Quivr.git & cd /home/quivr-user/quivr

#RUN chmod 777 /home/quivr-user/quivr

#ADD ./SOURCE_DOCUMENTS /home/quivr-user/quivr/SOURCE_DOCUMENTS

#RUN mkdir /home/quivr-user/quivr/models

#RUN mkdir /home/quivr-user/quivr/DB

#RUN cd /home/quivr-user/quivr

# Install the dependencies
#RUN python3 -m pip install -r /home/quivr-user/quivr/requirements.txt

# Preparing for login
ENV HOME home/quivr-user/quivr/localGPTUI/
WORKDIR ${HOME}

# Docker:
# docker build -t quivr .
# docker run -dit --name quivr -p 5111:5111 -v D:/Develop/NeuronNetwork/localGPT/NN_localGPT/SOURCE_DOCUMENTS:/home/quivr-user/quivr/SOURCE_DOCUMENTS --gpus all --restart unless-stopped quivr:latest

# debug: docker container attach quivr

# Интерфейс доступен на: