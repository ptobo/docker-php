FROM centos

LABEL maintainer="Pedro Tobo <pedrotobo@gmail.com>"

RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN rpm -Uvh http://rpms.remirepo.net/enterprise/remi-release-7.rpm
RUN curl https://packages.microsoft.com/config/centos/7/prod.repo > /etc/yum.repos.d/msprod.repo
RUN yum -y update

RUN yum --enablerepo=remi-php73 -y install nginx php php-fpm php-pdo php-xml php-pear php-devel re2c gcc-c++ gcc

RUN yum remove unixODBC-utf16 unixODBC-utf16-devel
RUN curl https://packages.microsoft.com/config/rhel/7/prod.repo > /etc/yum.repos.d/msprod.repo
RUN ACCEPT_EULA=Y yum -y install msodbcsql17-17.2.0.1-1 mssql-tools-17.2.0.1-1
RUN yum -y install unixODBC-devel
RUN pecl install sqlsrv
RUN pecl install pdo_sqlsrv
RUN echo extension=pdo_sqlsrv.so >> `php --ini | grep "Scan for additional .ini files" | sed -e "s|.*:\s*||"`/30-pdo_sqlsrv.ini
RUN echo extension=sqlsrv.so >> `php --ini | grep "Scan for additional .ini files" | sed -e "s|.*:\s*||"`/20-sqlsrv.ini

RUN sed -i 's/\(^;cgi.fix_pathinfo=\).*/cgi.fix_pathinfo=0/' /etc/php.ini
RUN sed -i 's/\(^listen = 127.0.0.1:9000\).*/listen = \/var\/run\/php-fpm\/php-fpm.sock/' /etc/php-fpm.d/www.conf
RUN sed -i 's/\(^;listen.owner =\).*/listen.owner = nginx/' /etc/php-fpm.d/www.conf
RUN sed -i 's/\(^;listen.group =\).*/listen.group = nginx/' /etc/php-fpm.d/www.conf
RUN sed -i 's/\(^;listen.mode =\).*/listen.mode = 0660/' /etc/php-fpm.d/www.conf
RUN sed -i 's/\(^user = apache\).*/user = nginx/' /etc/php-fpm.d/www.conf
RUN sed -i 's/\(^group = apache\).*/group = nginx/' /etc/php-fpm.d/www.conf

STOPSIGNAL SIGTERM

EXPOSE 80

RUN mkdir -p /var/run/php-fpm/
COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/default.d/default.conf
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN ["chmod", "+x", "/docker-entrypoint.sh"]

ENTRYPOINT ["/docker-entrypoint.sh"]