FROM debian:wheezy

MAINTAINER Mattias van de Hoef

# Create mount point, and mark it as holding externally mounted volume
WORKDIR /data
VOLUME /mcserver
VOLUME /map

RUN apt-get -y update
RUN apt-get -y install git python-imaging python-dev python-numpy wget
RUN git clone git://github.com/overviewer/Minecraft-Overviewer.git
RUN VERSION=1.9 \
	&& wget https://s3.amazonaws.com/Minecraft.Download/versions/${VERSION}/${VERSION}.jar
RUN python Minecraft-Overviewer/setup.py build

CMD python Minecraft-Overviewer/overviewer.py -c /mcserver/config.py
