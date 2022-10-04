# sets the Base Image for subsequent instructions
FROM amazonlinux:latest

# Install dependencies
RUN yum update -y && \
    yum install -y httpd && \
    yum search wget && \
    yum install wget -y && \
    yum install unzip -y

# change directory to /var/www/html
# this is where we'll write web-pages in. by default, this folder is provided by the apache
RUN cd /var/www/html

# download webfiles
RUN wget https://github.com/MrazTevin/Natujenge-SWE-Virtual-Bootcamp-Week01/archive/refs/heads/main.zip

# unzip folder
RUN unzip main.zip

# copy files(write web page) into html directory
RUN cp -r Natujenge-SWE-Virtual-Bootcamp-Week01-main/* /var/www/html/

# remove unwanted folder
RUN rm -rf Natujenge-SWE-Virtual-Bootcamp-Week01-main main.zip

# exposes port 80 on the container localhost
EXPOSE 80

# sets server-name to localhost to prevent error AH00558
RUN echo "ServerName localhost" >> /etc/httpd/conf/httpd.conf

# set the default application that will start when the container is initiated
ENTRYPOINT ["/usr/sbin/httpd", "-D", "FOREGROUND"]