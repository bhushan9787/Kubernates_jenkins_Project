FROM centos:7

MAINTAINER shikhardevops@gmail.com

# Fix CentOS 7 repo issue (EOL)
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-* \
 && sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-* \
 && yum -y makecache \
 && yum install -y httpd unzip wget curl \
 && yum clean all

WORKDIR /var/www/html/

# Download template using CURL because wget fails SSL on CentOS7
RUN curl -k -L -o photogenic.zip https://www.free-css.com/assets/files/free-css-templates/download/page254/photogenic.zip

# Unzip template
RUN unzip photogenic.zip

# Copy website files
RUN cp -rvf photogenic/* /var/www/html/

# Cleanup
RUN rm -rf photogenic photogenic.zip

EXPOSE 80

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
