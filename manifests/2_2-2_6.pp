# -*- mode: ruby -*-
# vi: set ft=ruby :

file { '/home/vagrant/moodle-latest-26.tgz':
  ensure => present,
  mode => 644,
  owner => vagrant,
  group => vagrant,
  source => '/vagrant_data/moodle-latest-26.tgz',
  before => Exec['unpack_moodle_code'],
}

exec { 'unpack_moodle_code':
  cwd => '/home/vagrant/www/moodle2/htdocs',
  command => '/bin/tar --strip-components=1 -xzf /home/vagrant/moodle-latest-26.tgz',
}

file { '/home/vagrant/www/moodle2/htdocs/config.php':
  ensure => present,
  mode => 0644,
  owner => vagrant,
  group => vagrant,
  source => '/vagrant_data/config-new.php',
}
