FROM ubuntu:18.04

FROM nvidia/cuda:10.2-base
CMD nvidia-smi

ENV TZ=Canada/Pacific
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update -y && apt-get install -y\
 default-jdk\
 libfindbin-libs-perl\
 unzip\
 curl\
 libglew2.0\
 libglfw3-dev

RUN set -xe \
    && apt-get update -y \
    && apt-get install -y python3-pip
RUN pip3 install --upgrade pip
COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

RUN pip3 install absl-py

RUN mkdir -p ~/.mujoco \
    && curl -SL https://github.com/deepmind/mujoco/releases/download/2.1.1/mujoco-2.1.1-linux-x86_64.tar.gz \
     | tar -zxC ~/.mujoco

#ENV MUJOCO_GL=glfw
ENV MUJOCO_GL=egl

#RUN pip install  git+https://github.com/navidyou/dm_control.git#egg=dm_control>=0.0.416848645
RUN pip install -q dm_control>=0.0.416848645
COPY . /walkerwalks

ENTRYPOINT ["python3"]
CMD ["/dm_control_walker_walk_training_app/main.py"]
