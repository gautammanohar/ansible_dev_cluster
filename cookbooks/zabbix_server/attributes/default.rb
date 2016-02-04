default['zabbix_server']['tarball_url'] = 'http://sourceforge.net/projects/zabbix/files/ZABBIX%20Latest%20Stable/2.4.7/zabbix-2.4.7.tar.gz/download'
default['zabbix_server']['tarball_name'] = 'download'
default['zabbix_server']['zabbix_folder'] = 'zabbix-2.4.7'
default['zabbix_server']['mysql_schema_path'] = 'database/mysql/schema.sql'
default['zabbix_server']['images_sql'] = 'database/mysql/images.sql'
default['zabbix_server']['data_sql'] = 'database/mysql/data.sql'
default['zabbix_server']['database']['dbname'] = 'zabbix'
default['zabbix_server']['database']['host'] = '127.0.0.1'
default['zabbix_server']['database']['superuser'] = 'root'
default['zabbix_server']['database']['root_pass'] = 'rootpass'
default['zabbix_server']['database']['zabbix_user'] = 'zabbix'
default['zabbix_server']['database']['zabbix_pass'] = 'zabbix'
default['zabbix_server']['database']['check_table'] = 'users'
default['zabbix_server']['user'] = 'zabbix'
default['zabbix_server']['user_home'] = '/home/zabbix'
default['zabbix_server']['group'] = 'zabbix'
default['zabbix_server']['frontend_source'] = 'frontends/php'
default['zabbix_server']['httpd_root'] = '/var/www/html'
default['zabbix_server']['base_packages'] = [
                                        'mysql-community-devel',
                                        'libxml2-devel',
                                        'net-snmp-devel',
                                        'libcurl-devel',
                                        'httpd',
                                        'php',
                                        'php-mysql',
                                        'php-xml',
                                        'php-gd',
                                        'yum-utils'
                                       ]
