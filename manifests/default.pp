# -*- mode: ruby -*-
# vi: set ft=ruby :

file { ['/home/vagrant/www', '/home/vagrant/www/moodle2', '/home/vagrant/www/moodle2/htdocs']:
  ensure => directory,
  mode => 0644,
  owner => vagrant,
  group => vagrant,
}

file { '/home/vagrant/www/moodle2/moodledata':
  ensure => directory,
  mode => 0777,
  owner => vagrant,
  group => vagrant,
}

file { '/home/vagrant/www/moodle2/htdocs/config.php':
  ensure => present,
  mode => 0644,
  owner => vagrant,
  group => vagrant,
  source => '/vagrant_data/config-new.php',
}

file { '/home/vagrant/moodle.sql.gz':
  ensure => present,
  mode => 0600,
  owner => vagrant,
  group => vagrant,
  source => '/vagrant_data/moodle.sql.gz',
  before => Exec['unpack_moodle_db'],
}

exec { 'unpack_moodle_db':
  unless => '/usr/bin/test -f /home/vagrant/moodle.sql',
  command => '/bin/gunzip /home/vagrant/moodle.sql.gz',
}

file { '/home/vagrant/moodle-2.2.11.tgz':
  ensure => present,
  mode => 644,
  owner => vagrant,
  group => vagrant,
  source => '/vagrant_data/moodle-2.2.11.tgz',
  before => Exec['unpack_moodle_code'],
}

exec { 'unpack_moodle_code':
  cwd => '/home/vagrant/www/moodle2/htdocs',
  command => '/bin/tar --strip-components=1 -xzf /home/vagrant/moodle-2.2.11.tgz',
}

file { '/etc/apache2/vhosts.d/default_vhost.include':
  ensure => present,
  source => '/vagrant_vhosts/default_vhost.include',
  mode => 644,
  owner => root,
  group => root,
  notify => Service['apache2'],
}

service { 'apache2':
  ensure => running,
  enable => true,
}

service { 'mysql':
  ensure => running,
  enable => true,
}

mysql_user { 'moodle@localhost':
  ensure => present,
}

mysql_database { 'moodle':
  ensure => present,
  charset => 'utf8',
}

mysql_grant { 'moodle@localhost/moodle.*':
  ensure => present,
  options => ['GRANT'],
  privileges => ['ALL'],
  table => 'moodle.*',
  user => 'moodle@localhost',
}
