#!/bin/bash

/usr/bin/mysql -u moodle -D moodle < /home/vagrant/moodle.sql
/usr/bin/php /home/vagrant/www/moodle2/htdocs/admin/cli/upgrade.php --non-interactive 2>&1 > /vagrant_log/upgrade.txt
