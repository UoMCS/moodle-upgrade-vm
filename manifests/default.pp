file { ['/home/vagrant/www', '/home/vagrant/www/moodle2']:
  ensure => directory,
  mode => 0644,
}

file { '/home/vagrant/www/moodle2/index.html':
  ensure => present,
  mode => 0644,
  content => 'Moodle',
}

file { '/etc/apache2/vhosts.d/moodle2.conf':
  ensure => present,
  source => '/vagrant_vhosts/moodle2.conf',
  notify => Service['apache2'],
}

service { 'apache2':
  ensure => running,
  enable => true,
}
