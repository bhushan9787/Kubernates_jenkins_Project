FROM centos:7

MAINTAINER shikhardevops@gmail.com

# Fix CentOS repo + install packages
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-* \
 && sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-* \
 && yum -y makecache \
 && yum install -y httpd unzip wget curl \
 && yum clean all

WORKDIR /var/www/html/

# Copy ZIP from Jenkins to container
COPY photogenic.zip .

# Extract ZIP directly in current folder
RUN unzip photogenic.zip && rm -f photogenic.zip

EXPOSE 80

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
