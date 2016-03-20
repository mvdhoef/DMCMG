FROM debian:wheezy

MAINTAINER Mattias van de Hoef

# Create mount point, and mark it as holding externally mounted volume
WORKDIR /data                                                         # Use APT (Advanced Packaging Tool) built in the Linux distro to download Java, a dependency
VOLUME /data                                                          # to run Minecraft.

RUN apt-get -y update \
	&& apt-get -y install git python-imaging python-dev python-numpy \
	&& git clone git://github.com/overviewer/Minecraft-Overviewer.git \
	&& python Minecraft-Overviewer/setup.py build

# Expose the container's network port: 25565 during runtime.
#EXPOSE 25565

#Automatically accept Minecraft EULA, and start Minecraft server
#CMD echo eula=true > /data/eula.txt && java -jar /minecraft_server.1.7.10.jar
#RUN git clone git://github.com/overviewer/Minecraft-Overviewer.git
#CMD python Minecraft-Overviewer/
CMD Minecraft-Overviewer/overviewer.py /mcserver /map
