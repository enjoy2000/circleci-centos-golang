FROM		centos/python-36-centos7
MAINTAINER 	Hat Dao "hat@theluxenomad.com"

# Install needed software and users
USER root
RUN groupadd -r circleci && useradd -r -d /home/circleci -m -g circleci circleci
RUN yum install -y git tar curl wget gcc sudo make yum-utils device-mapper-persistent-data lvm2 && \
	yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo && \
    yum install -y docker-ce && \
    yum clean all
RUN yum install -y gettext-devel libjpeg-turbo-devel libffi-devel libxml2-devel libxslt-devel cairo-devel pango-devel ruby-devel libcurl-devel

# install wkhtmltopdf
RUN yum install -y fontconfig xorg-x11-fonts-Type1 xorg-x11-fonts-75dpi icu icu-devel
RUN wget https://bitbucket.org/wkhtmltopdf/wkhtmltopdf/downloads/wkhtmltox-0.13.0-alpha-7b36694_linux-centos7-amd64.rpm && \
    sudo rpm -i wkhtmltox-0.13.0-alpha-7b36694_linux-centos7-amd64.rpm

RUN echo "%circleci        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers

USER circleci

CMD ["/bin/sh"]
