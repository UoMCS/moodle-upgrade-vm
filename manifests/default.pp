file { ['/home/vagrant/www', '/home/vagrant/www/moodle2']:
  ensure => directory,
  mode => 0644,
}

file { '/home/vagrant/www/moodle2/index.html':
  ensure => present,
  mode => 0644,
  content => 'Moodle',
}

file { '/home/vagrant/moodle.sql.gz':
  ensure => present,
  mode => 0600,
  source => '/vagrant_data/moodle.sql.gz',
  before => Exec['unpack_moodle_db'],
}

exec { 'unpack_moodle_db':
  unless => '/usr/bin/test -f /home/vagrant/moodle.sql',
  command => '/bin/gunzip /home/vagrant/moodle.sql.gz',
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
