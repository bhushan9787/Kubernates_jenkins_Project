FROM centos:7

MAINTAINER shikhardevops@gmail.com

# Fix CentOS 7 repo issue (EOL)
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-* \
 && sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-* \
 && yum -y makecache \
 && yum install -y httpd unzip wget curl \
 && yum clean all

WORKDIR /var/www/html/

# Copy template ZIP from host → avoid HTTPS problems in CentOS 7
COPY photogenic.zip /var/www/html/

# Unzip and move content
RUN unzip photogenic.zip \
 && cp -rvf photogenic/* /var/www/html/ \
 && rm -rf photogenic photogenic.zip

EXPOSE 80

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
