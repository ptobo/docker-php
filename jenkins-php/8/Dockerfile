FROM jenkins/jenkins:lts

USER root

RUN apt update -y
RUN apt upgrade -y

RUN apt install -y lsb-release ca-certificates apt-transport-https software-properties-common
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/sury-php.list
RUN wget -qO - https://packages.sury.org/php/apt.gpg | apt-key add -
RUN apt update -y
RUN apt install -y php8.0 php8.0-bcmath php8.0-curl-dbgsym php8.0-gmp-dbgsym php8.0-mysql php8.0-pspell-dbgsym php8.0-tidy php8.0-bcmath-dbgsym php8.0-dba php8.0-imap php8.0-mysql-dbgsym php8.0-readline php8.0-tidy-dbgsym php8.0-bz2 php8.0-dba-dbgsym php8.0-imap-dbgsym php8.0-odbc php8.0-readline-dbgsym php8.0-xdebug php8.0-bz2-dbgsym php8.0-dev php8.0-interbase php8.0-odbc-dbgsym php8.0-snmp php8.0-xml php8.0-cgi php8.0-enchant php8.0-interbase-dbgsym  php8.0-opcache php8.0-snmp-dbgsym php8.0-xml-dbgsym php8.0-cgi-dbgsym php8.0-enchant-dbgsym php8.0-intl php8.0-opcache-dbgsym php8.0-soap php8.0-xsl php8.0-cli php8.0-fpm php8.0-intl-dbgsym php8.0-pgsql php8.0-soap-dbgsym php8.0-zip php8.0-cli-dbgsym php8.0-fpm-dbgsym php8.0-ldap php8.0-pgsql-dbgsym php8.0-sqlite3 php8.0-zip-dbgsym php8.0-common php8.0-gd php8.0-ldap-dbgsym php8.0-phpdbg php8.0-sqlite3-dbgsym php8.0-common-dbgsym php8.0-gd-dbgsym php8.0-mbstring php8.0-phpdbg-dbgsym php8.0-sybase php8.0-curl php8.0-gmp php8.0-mbstring-dbgsym php8.0-pspell php8.0-sybase-dbgsym 

RUN sed -i 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen
RUN locale-gen

RUN wget -qO - https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list
RUN apt update -y
RUN ACCEPT_EULA=Y apt-get install -y msodbcsql17
RUN apt install -y unixodbc-dev

RUN pecl install sqlsrv
RUN pecl install pdo_sqlsrv

RUN echo extension=pdo_sqlsrv.so >> `php --ini | grep "Scan for additional .ini files" | sed -e "s|.*:\s*||"`/30-pdo_sqlsrv.ini
RUN echo extension=sqlsrv.so >> `php --ini | grep "Scan for additional .ini files" | sed -e "s|.*:\s*||"`/20-sqlsrv.ini

USER jenkins
