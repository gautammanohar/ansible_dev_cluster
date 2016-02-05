default['nagios_server']['user'] = 'nagios'
default['nagios_server']['user_home'] = '/home/nagios'
default['nagios_server']['group'] = 'nagios'
default['nagios_server']['command_group'] = 'nagcmd'
default['nagios_server']['tarball_url'] = 'https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.1.1.tar.gz'
default['nagios_server']['tarball_name'] = 'nagios-4.1.1.tar.gz'

default['nagios_server']['plugin_url'] = 'http://nagios-plugins.org/download/nagios-plugins-2.1.1.tar.gz'
default['nagios_server']['plugin_tarball_name'] = 'nagios-plugins-2.1.1.tar.gz'
default['nagios_server']['plugin_folder'] = 'nagios-plugins-2.1.1'

default['nagios_server']['nagios_folder'] = 'nagios-4.1.1'
default['nagios_server']['base_packages'] = [
                                             'gcc',
                                             'glibc',
                                             'glibc-common',
                                             'gd',
                                             'gd-devel',
                                             'make',
                                             'net-snmp',
                                             'openssl-devel',
                                             'xinetd',
                                             'unzip',
                                             'httpd'
                                            ]

default['nagios_server']['make_cmd'] = [
                                 "make install",
                                 "make install-commandmode",
                                 "make install-init",
                                 "make install-config",
                                 "make install-webconf"
                                ]
