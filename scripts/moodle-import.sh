#!/bin/bash

rm -f /home/vagrant/moodle-*.tgz
/usr/bin/mysql -u moodle -D moodle < /home/vagrant/moodle.sql
rm -f /home/vagrant/moodle.sql
/usr/bin/php /home/vagrant/www/moodle2/htdocs/admin/cli/upgrade.php --non-interactive &> /vagrant_log/upgrade.txt
