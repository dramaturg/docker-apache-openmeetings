
FROM centos

MAINTAINER Sebastian Krohn <seb@gaia.sunn.de>


RUN rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
RUN yum -y update

# dependencies
RUN rpm -Uhv http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm
RUN yum -y update
RUN yum -y install git java-1.7.0-openjdk ImageMagick ghostscript libreoffice ffmpeg swftools sox
RUN yum -y clean all
WORKDIR /opt
ADD http://jodconverter.googlecode.com/files/jodconverter-core-3.0-beta-4-dist.zip \
		/opt/jodconverter-core-3.0-beta-4-dist.zip
RUN unzip /opt/jodconverter-core-3.0-beta-4-dist.zip && \
		rm -f /opt/jodconverter-core-3.0-beta-4-dist.zip
RUN ln -s jodconverter-core-3.0-beta-4 jod

# openmeetings itself
ADD apache-openmeetings-3.0.0.tar.gz /opt/apache-openmeetings-3.0.0
WORKDIR /opt
RUN ln -s apache-openmeetings-3.0.0 apache-openmeetings
WORKDIR /opt/apache-openmeetings

# run
EXPOSE 5080 1935 8088
CMD ["/opt/apache-openmeetings/red5.sh"]

