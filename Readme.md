![alt text](https://img.shields.io/docker/automated/kolyadin/php.svg)
![alt text](https://img.shields.io/docker/build/kolyadin/php.svg)
![alt text](https://img.shields.io/docker/pulls/kolyadin/php.svg)

# About

Official docker php image with precompiled extensions and composer.

Extra extensions are marked with star(*):

```bash
> php -m

[PHP Modules]
*bcmath
*bz2
Core
ctype
curl
date
dom
*exif
fileinfo
filter
ftp
*gd
*gettext
hash
iconv
*imagick
*intl
json
libxml
mbstring
*mcrypt
mysqlnd
openssl
*pcntl
pcre
PDO
*pdo_mysql
*pdo_pgsql
pdo_sqlite
*pgsql
Phar
posix
readline
Reflection
session
SimpleXML
*soap
*sockets
SPL
sqlite3
standard
tokenizer
*xdebug
xml
xmlreader
xmlwriter
*Zend OPcache
*zip
zlib

[Zend Modules]
*Xdebug
*Zend OPcache
```

### How to disable xdebug
```bash
rm -f /usr/local/etc/php/conf.d/xdebug.ini
```

### How to increase memory limit
```bash
echo 'memory_limit = 1G' >> /usr/local/etc/php/conf.d/extra.ini
```

### How to set timezone
```bash
echo 'date.timezone=Europe/Moscow' >> /usr/local/etc/php/conf.d/extra.ini
```