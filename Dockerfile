FROM lsiobase/alpine.nginx:3.8

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="sparklyballs"

RUN \
 echo "**** install packages ****" && \
 apk add --no-cache \
	curl \
	php7-apcu \
	php7-curl \
	php7-dom \
	php7-gd \
	php7-iconv \
	php7-intl \
	php7-mcrypt \
	php7-mysqli \
	php7-mysqlnd \
	php7-pcntl \
	php7-pdo_mysql \
	php7-pdo_pgsql \
	php7-pgsql \
	php7-posix \
	tar && \
 echo "**** link php7 to php ****" && \
 ln -sf /usr/bin/php7 /usr/bin/php && \
 echo "**** download ttrss ****" && \
 mkdir -p /var/www/html && \
 curl -o /tmp/tt-rss.tar.gz -L https://git.tt-rss.org/git/tt-rss/archive/master.tar.gz && \
 tar xf /tmp/tt-rss.tar.gz -C /var/www/html/ --strip-components=1 && \
 rm /tmp/tt-rss.tar.gz

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 80 443
VOLUME /config
