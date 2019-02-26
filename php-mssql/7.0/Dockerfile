FROM centos

MAINTAINER "Pedro Tobo" <pedrotobo@gmail.com>

RUN yum -y update
RUN yum -y install wget curl http
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN wget http://rpms.remirepo.net/enterprise/remi-release-7.rpm
RUN rpm -Uvh remi-release-7.rpm
RUN rm -f remi-release-7.rpm
RUN yum -y install httpd php70-php php70-php-pear php70-php-pecl-sync php70-php-pecl-memcached php70-php-pecl-amqp php70-php-bcmath php70-php-cli php70-php-common php70-php-dba php70-php-dbg php70-php-devel php70-php-embedded php70-php-enchant php70-php-fpm php70-php-gd php70-php-gmp php70-php-imap php70-php-intl php70-php-json php70-php-ldap php70-php-mbstring php70-php-mcrypt php70-php-mysqlnd php70-php-opcache php70-php-soap php70-php-odbc

RUN curl https://packages.microsoft.com/config/rhel/7/prod.repo > /etc/yum.repos.d/msprod.repo
RUN ACCEPT_EULA=Y yum -y install msodbcsql
RUN yum -y install unixODBC-devel
RUN ACCEPT_EULA=Y yum -y install mssql-tools

RUN yum -y install gcc make gcc-c++
RUN /opt/remi/php70/root/usr/bin/pecl install sqlsrv pdo_sqlsrv
RUN echo '; Enable sqlsrv extension module' > /etc/opt/remi/php70/php.d/60-sqlsrv.ini
RUN echo 'extension=sqlsrv.so' >> /etc/opt/remi/php70/php.d/60-sqlsrv.ini
RUN echo 'extension=pdo_sqlsrv.so' >> /etc/opt/remi/php70/php.d/60-sqlsrv.ini

EXPOSE 80

CMD ["/usr/sbin/apachectl", "-D", "FOREGROUND"]