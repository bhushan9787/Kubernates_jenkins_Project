FROM centos:7

MAINTAINER shikhardevops@gmail.com

# Fix CentOS repo + install packages
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-* \
 && sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-* \
 && yum -y makecache \
 && yum install -y httpd unzip wget curl \
 && yum clean all

WORKDIR /var/www/html/

# Copy photogenic.zip from Jenkins workspace to container
COPY photogenic.zip /var/www/html/

# Extract directly (no photogenic/ folder)
RUN unzip photogenic.zip \
 && cp -rvf * /var/www/html/ \
 && rm -rf photogenic.zip

EXPOSE 80

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
