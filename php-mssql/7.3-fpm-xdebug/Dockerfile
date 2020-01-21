FROM centos:7

LABEL maintainer="Pedro Tobo <pedrotobo@gmail.com>"

RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN rpm -Uvh http://rpms.remirepo.net/enterprise/remi-release-7.rpm
RUN curl https://packages.microsoft.com/config/centos/7/prod.repo > /etc/yum.repos.d/msprod.repo
RUN yum -y update

RUN yum --enablerepo=remi-php73 -y install nginx php php-fpm php-pdo php-xml php-pear php-ldap php-soap php-devel re2c gcc-c++ gcc

RUN yum remove unixODBC-utf16 unixODBC-utf16-devel
RUN curl https://packages.microsoft.com/config/rhel/7/prod.repo > /etc/yum.repos.d/msprod.repo
RUN ACCEPT_EULA=Y yum -y install msodbcsql17-17.4.1.1-1 mssql-tools-17.4.1.1-1
RUN yum -y install unixODBC-devel
RUN pecl install sqlsrv
RUN pecl install pdo_sqlsrv
RUN echo extension=pdo_sqlsrv.so >> `php --ini | grep "Scan for additional .ini files" | sed -e "s|.*:\s*||"`/30-pdo_sqlsrv.ini
RUN echo extension=sqlsrv.so >> `php --ini | grep "Scan for additional .ini files" | sed -e "s|.*:\s*||"`/20-sqlsrv.ini

RUN pecl install xdebug
RUN echo zend_extension=xdebug.so >> `php --ini | grep "Scan for additional .ini files" | sed -e "s|.*:\s*||"`/40-xdebug.ini
RUN echo xdebug.default_enable=1 >> `php --ini | grep "Scan for additional .ini files" | sed -e "s|.*:\s*||"`/40-xdebug.ini
RUN echo xdebug.remote_enable=1 >> `php --ini | grep "Scan for additional .ini files" | sed -e "s|.*:\s*||"`/40-xdebug.ini
RUN echo xdebug.profiler_enable=1 >> `php --ini | grep "Scan for additional .ini files" | sed -e "s|.*:\s*||"`/40-xdebug.ini
RUN echo xdebug.remote_host=host.docker.internal >> `php --ini | grep "Scan for additional .ini files" | sed -e "s|.*:\s*||"`/40-xdebug.ini
RUN echo xdebug.remote_log=xdebug.log >> `php --ini | grep "Scan for additional .ini files" | sed -e "s|.*:\s*||"`/40-xdebug.ini

RUN sed -i 's/\(^;cgi.fix_pathinfo=\).*/cgi.fix_pathinfo=0/' /etc/php.ini
RUN sed -i 's/\(^listen = 127.0.0.1:9000\).*/listen = \/var\/run\/php-fpm\/php-fpm.sock/' /etc/php-fpm.d/www.conf
RUN sed -i 's/\(^;listen.owner =\).*/listen.owner = nginx/' /etc/php-fpm.d/www.conf
RUN sed -i 's/\(^;listen.group =\).*/listen.group = nginx/' /etc/php-fpm.d/www.conf
RUN sed -i 's/\(^;listen.mode =\).*/listen.mode = 0660/' /etc/php-fpm.d/www.conf
RUN sed -i 's/\(^user = apache\).*/user = nginx/' /etc/php-fpm.d/www.conf
RUN sed -i 's/\(^group = apache\).*/group = nginx/' /etc/php-fpm.d/www.conf
RUN sed -i 's/\(^pm.max_children = 50\).*/pm.max_children = 30/' /etc/php-fpm.d/www.conf
RUN sed -i 's/\(^pm.start_servers = 5\).*/pm.start_servers = 2/' /etc/php-fpm.d/www.conf
RUN sed -i 's/\(^pm.min_spare_servers = 5\).*/pm.min_spare_servers = 2/' /etc/php-fpm.d/www.conf
RUN sed -i 's/\(^pm.max_spare_servers = 35\).*/pm.max_spare_servers = 5/' /etc/php-fpm.d/www.conf
RUN sed -i 's/\(^;pm.max_requests = 500\).*/pm.max_requests = 50/' /etc/php-fpm.d/www.conf
RUN echo 'proxy_connect_timeout 3600;' >> /etc/nginx/conf.d/timeout.conf 
RUN echo 'proxy_send_timeout 3600;' >> /etc/nginx/conf.d/timeout.conf 
RUN echo 'proxy_read_timeout 3600;' >> /etc/nginx/conf.d/timeout.conf 
RUN echo 'send_timeout 3600;' >> /etc/nginx/conf.d/timeout.conf 

STOPSIGNAL SIGTERM

EXPOSE 80

RUN mkdir -p /var/run/php-fpm/
COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/default.d/default.conf
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN ["chmod", "+x", "/docker-entrypoint.sh"]
RUN chmod 777 /var/lib/php/session

RUN ln -s /dev/stdout /var/log/nginx/access.log
RUN ln -s /dev/stderr /var/log/nginx/error.log
RUN ln -s /dev/stderr /var/log/php-fpm/error.log
RUN ln -s /dev/stderr /var/log/xdebug.log

ENTRYPOINT ["/docker-entrypoint.sh"]