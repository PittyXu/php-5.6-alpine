FROM alpine:3.5

RUN apk add --update --no-cache bash \
				libc-dev \
				make \
				g++ \
				gcc \
				curl \
				curl-dev \
				php5-intl \
				php5-openssl \
				php5-dba \
				php5-sqlite3 \
				php5-pear \
				php5-phpdbg \
				php5-gmp \
				php5-pdo_mysql \
				php5-pcntl \
				php5-common \
				php5-xsl \
				php5-fpm \	
				php5-mysql \
				php5-mysqli \
				php5-enchant \
				php5-pspell \
				php5-snmp \
				php5-doc \
				php5-dev \
				php5-xmlrpc \
				php5-embed \
				php5-xmlreader \
				php5-pdo_sqlite \
				php5-exif \
				php5-opcache \
				php5-ldap \
				php5-posix \	
				php5-gd  \
				php5-gettext \
				php5-json \
				php5-xml \
				php5 \
				php5-iconv \
				php5-sysvshm \
				php5-curl \
				php5-shmop \
				php5-odbc \
				php5-phar \
				php5-pdo_pgsql \
				php5-imap \
				php5-pdo_dblib \
				php5-pgsql \
				php5-pdo_odbc \
				php5-xdebug \
				php5-zip \
				php5-apache2 \
				php5-cgi \
				php5-ctype \
				php5-mcrypt \
				php5-wddx \
				php5-bcmath \
				php5-calendar \
				php5-dom \
				php5-sockets \
				php5-soap \
				php5-apcu \
				php5-sysvmsg \
				php5-zlib \
				php5-ftp \
				php5-sysvsem \ 
				php5-pdo \
				php5-bz2 \
				php5-mysqli \
  				apache2 \
				libxml2-dev \
				apache2-utils \
				imagemagick-dev \
				ffmpeg \
	&& curl -sS https://getcomposer.org/installer | php5 -- --install-dir=/usr/bin --filename=composer \
	&& rm /usr/bin/iconv \
	&& curl -SL http://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.14.tar.gz | tar -xz -C . \
	&& cd libiconv-1.14 \
	&& ./configure --prefix=/usr/local \
	&& curl -SL https://raw.githubusercontent.com/mxe/mxe/7e231efd245996b886b501dad780761205ecf376/src/libiconv-1-fixes.patch | patch -p1 -u \
	&& make \
	&& make install \
	&& libtool --finish /usr/local/lib \
	&& cd .. \
	&& rm -rf libiconv-1.14 \
	&& rm -rf /var/cache/apk/* \
	# AllowOverride ALL
	&& sed -i '264s#AllowOverride None#AllowOverride All#' /etc/apache2/httpd.conf \
	#Rewrite Moduble Enable
	&& sed -i 's#\#LoadModule rewrite_module modules/mod_rewrite.so#LoadModule rewrite_module modules/mod_rewrite.so#' /etc/apache2/httpd.conf \
	# Document Root to /var/www/html/
	&& sed -i 's#/var/www/localhost/htdocs#/var/www/html#g' /etc/apache2/httpd.conf \
	#Start apache
	&& mkdir -p /run/apache2 \
	&& mkdir /var/www/html/

ENV LD_PRELOAD /usr/local/lib/preloadable_libiconv.so

VOLUME  /var/www/html/
WORKDIR  /var/www/html/

EXPOSE 80
EXPOSE 443

CMD /usr/sbin/apachectl  -D   FOREGROUND