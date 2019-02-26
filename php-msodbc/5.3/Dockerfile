FROM centos:6

MAINTAINER "Pedro Tobo" <pedrotobo@gmail.com>

RUN curl https://packages.microsoft.com/config/rhel/6/prod.repo > /etc/yum.repos.d/mssql-release.repo
RUN yum -y update
RUN ACCEPT_EULA=Y yum -y install msodbcsql mssql-tools
RUN yum -y install httpd php php-odbc php-pdo 
RUN yum clean all

EXPOSE 80

CMD ["/usr/sbin/apachectl", "-D", "FOREGROUND"]