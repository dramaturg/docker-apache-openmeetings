
FROM dramaturg/centos-systemd
MAINTAINER Sebastian Krohn <seb@gaia.sunn.de>

# dependencies
RUN rpm --import http://li.nux.ro/download/nux/RPM-GPG-KEY-nux.ro && \
    rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-1.el7.nux.noarch.rpm
RUN yum -y update && \
    yum -y install git java-1.8.0-openjdk ImageMagick ghostscript libreoffice ffmpeg fftw-libs zziplib sox && \
    rpm -Uvh ftp://fr2.rpmfind.net/linux/dag/redhat/el6/en/x86_64/dag/RPMS/swftools-0.9.1-1.el6.rf.x86_64.rpm && \
    yum -y clean all

RUN curl -L https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/jodconverter/jodconverter-core-3.0-beta-4-dist.zip \
         -o /opt/jodconverter-core-3.0-beta-4-dist.zip && \
    unzip /opt/jodconverter-core-3.0-beta-4-dist.zip -d /opt && \
    rm -f /opt/jodconverter-core-3.0-beta-4-dist.zip && \
    cd /opt && ln -s jodconverter-core-3.0-beta-4 jod


# openmeetings itself
ADD apache-openmeetings.tar.gz /opt/apache-openmeetings
ADD apache-openmeetings.service /etc/systemd/system/
RUN systemctl enable apache-openmeetings.service
ENV RED5_HOME /opt/apache-openmeetings

# run
EXPOSE 5080 5443 1935 8088 8443 8081

