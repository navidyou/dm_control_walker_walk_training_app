FROM ubuntu:18.04
#FROM ubuntu:20.04
#FROM alpine:3.14
FROM nvidia/cuda:10.2-base
CMD nvidia-smi
#RUN apt-get update && apt-get install -qq -y libglew2.0
#ENV HOME /root
ENV TZ=Canada/Pacific
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update -y && apt-get install -y\
 default-jdk\
 libfindbin-libs-perl\
 unzip\
 curl\
 libglew2.0\
 libglfw3-dev
#RUN apt-get install -qq -y --no-install-recommends libglew2.0
RUN set -xe \
    && apt-get update -y \
    && apt-get install -y python3-pip
RUN pip3 install --upgrade pip
COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt
RUN pip3 install Flask
#RUN apt-get install libglfw3-dev
RUN mkdir -p ~/.mujoco \
    && curl -SL https://github.com/deepmind/mujoco/releases/download/2.1.1/mujoco-2.1.1-linux-x86_64.tar.gz \
     | tar -zxC ~/.mujoco
#    | tar -zxf ~/.mujoco
#    | tar -xJC ~/.mujoco
#RUN apt-get install -y wget
#RUN wget -q "https://github.com/deepmind/mujoco/releases/download/2.1.1/mujoco-2.1.1-linux-x86_64.tar.gz"
#RUN wget -q "https://github.com/deepmind/mujoco/releases/download/2.1.1/mujoco-2.1.1-linux-x86_64.tar.gz.sha256"
#ENV MUJOCO_DIR = '$HOME/.mujoco'
#RUN mkdir -p "{MUJOCO_DIR}"
#RUN tar -zxf "mujoco-2.1.1-linux-x86_64.tar.gz" -C "{MUJOCO_DIR}"
#ENV LD_LIBRARY_PATH='$HOME/.mujoco/mujoco211_linux/bin/'
#ENV LD_LIBRARY_PATH='~/.mujoco/mujoco211_linux/bin/'
# ~/.mujoco/mujoco211_linux/bin/
ENV MUJOCO_GL=glfw
#COPY $HOME/.mujoco $HOME
#RUN pip install  git+https://github.com/navidyou/dm_control.git#egg=dm_control>=0.0.416848645
RUN pip install -q dm_control>=0.0.416848645
COPY . /walkerwalks
#WORKDIR $HOME
#RUN echo $HOME
ENTRYPOINT ["python3"]
CMD ["/walkerwalks/main.py"]
