FROM centos

MAINTAINER "Pedro Tobo" <pedrotobo@gmail.com>

RUN yum -y update
RUN yum -y install wget curl http
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN wget http://rpms.remirepo.net/enterprise/remi-release-7.rpm
RUN rpm -Uvh remi-release-7.rpm
RUN rm -f remi-release-7.rpm
RUN yum -y install httpd php71-php php71-php-pear php71-php-pecl-sync php71-php-pecl-memcached php71-php-pecl-amqp php71-php-bcmath php71-php-cli php71-php-common php71-php-dba php71-php-dbg php71-php-devel php71-php-embedded php71-php-enchant php71-php-fpm php71-php-gd php71-php-gmp php71-php-imap php71-php-intl php71-php-json php71-php-ldap php71-php-mbstring php71-php-mcrypt php71-php-mysqlnd php71-php-opcache php71-php-soap php71-php-odbc

RUN curl https://packages.microsoft.com/config/rhel/7/prod.repo > /etc/yum.repos.d/msprod.repo
RUN ACCEPT_EULA=Y yum -y install msodbcsql
RUN yum -y install unixODBC-devel
RUN ACCEPT_EULA=Y yum -y install mssql-tools

RUN yum -y install gcc make gcc-c++
RUN /opt/remi/php71/root/usr/bin/pecl install sqlsrv pdo_sqlsrv
RUN echo '; Enable sqlsrv extension module' > /etc/opt/remi/php71/php.d/60-sqlsrv.ini
RUN echo 'extension=sqlsrv.so' >> /etc/opt/remi/php71/php.d/60-sqlsrv.ini
RUN echo 'extension=pdo_sqlsrv.so' >> /etc/opt/remi/php71/php.d/60-sqlsrv.ini

EXPOSE 80

CMD ["/usr/sbin/apachectl", "-D", "FOREGROUND"]