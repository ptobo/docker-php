FROM centos:6

MAINTAINER "Pedro Tobo" <pedrotobo@gmail.com>

RUN curl https://packages.microsoft.com/config/rhel/6/prod.repo > /etc/yum.repos.d/mssql-release.repo
RUN yum -y install wget
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
RUN wget http://rpms.remirepo.net/enterprise/remi-release-6.rpm
RUN rpm -Uvh remi-release-6.rpm
RUN rm -f remi-release-6.rpm
RUN yum -y remove wget
RUN yum -y update
RUN ACCEPT_EULA=Y yum -y install msodbcsql mssql-tools
RUN yum -y install httpd php71-php php71-php-odbc php71-php-pdo 
RUN yum clean all

EXPOSE 80

CMD ["/usr/sbin/apachectl", "-D", "FOREGROUND"]