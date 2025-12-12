FROM centos:7

MAINTAINER shikhardevops@gmail.com

# Fix CentOS 7 repo issue (EOL) and install dependencies
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-* \
 && sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-* \
 && yum -y makecache \
 && yum install -y httpd unzip wget \
 && yum clean all

# Set work directory
WORKDIR /var/www/html/

# Download website template
RUN wget https://www.free-css.com/assets/files/free-css-templates/download/page254/photogenic.zip

# Unzip template
RUN unzip photogenic.zip

# Copy website files to Apache document root
RUN cp -rvf photogenic/* /var/www/html/

# Cleanup
RUN rm -rf photogenic photogenic.zip

# Expose Apache port
EXPOSE 80

# Start Apache server in foreground
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
