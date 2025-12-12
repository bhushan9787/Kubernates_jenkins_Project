FROM centos:7

MAINTAINER shikhardevops@gmail.com

# Install dependencies
RUN yum install -y httpd unzip wget

WORKDIR /var/www/html/

# Download the template zip
RUN wget https://www.free-css.com/assets/files/free-css-templates/download/page254/photogenic.zip

# Unzip template
RUN unzip photogenic.zip

# Copy website files to Apache document root
RUN cp -rvf photogenic/* /var/www/html/

# Clean extra files
RUN rm -rf photogenic photogenic.zip

# Start Apache in foreground
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

EXPOSE 80

