FROM		centos:7
MAINTAINER 	Hat Dao "hat@theluxenomad.com"

# Install needed software and users
USER root
RUN groupadd -r circleci && useradd -r -m -g circleci circleci
RUN yum install -y git tar curl wget gcc sudo make yum-utils device-mapper-persistent-data lvm2 && \
	yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo && \
    yum install -y docker-ce && \
    yum clean all
RUN yum install -y gettext-devel libjpeg-turbo-devel libffi-devel libxml2-devel libxslt-devel cairo-devel pango-devel ruby-devel libcurl-devel

# install wkhtmltopdf
RUN yum install -y fontconfig xorg-x11-fonts-Type1 xorg-x11-fonts-75dpi icu icu-devel openssl
RUN wget https://bitbucket.org/wkhtmltopdf/wkhtmltopdf/downloads/wkhtmltox-0.13.0-alpha-7b36694_linux-centos7-amd64.rpm && \
    sudo rpm -i wkhtmltox-0.13.0-alpha-7b36694_linux-centos7-amd64.rpm

RUN echo "%circleci        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers

# install pip
RUN yum -y install epel-release && yum install -y https://centos7.iuscommunity.org/ius-release.rpm && yum -y update && yum clean all
RUN yum install -y python36u python36u-libs python36u-devel python36u-pip
RUN which pip
RUN ls /usr/local/bin
RUN pip install pipenv

USER circleci

CMD ["/bin/sh"]
