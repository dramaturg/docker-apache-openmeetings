
FROM centos

MAINTAINER Sebastian Krohn <seb@gaia.sunn.de>


RUN rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
RUN yum -y update

# dependencies
RUN rpm -Uhv http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm
RUN yum -y update && \
	yum -y install git java-1.7.0-openjdk ImageMagick ghostscript libreoffice ffmpeg swftools sox && \
	yum -y clean all
RUN curl -L http://jodconverter.googlecode.com/files/jodconverter-core-3.0-beta-4-dist.zip \
		-o /opt/jodconverter-core-3.0-beta-4-dist.zip && \
	unzip /opt/jodconverter-core-3.0-beta-4-dist.zip && \
	rm -f /opt/jodconverter-core-3.0-beta-4-dist.zip
RUN cd /opt && ln -s jodconverter-core-3.0-beta-4 jod

# openmeetings itself
ADD apache-openmeetings.tar.gz /opt/apache-openmeetings
WORKDIR /opt/apache-openmeetings

# run
EXPOSE 5080 1935 8088
CMD ["/opt/apache-openmeetings/red5.sh"]

