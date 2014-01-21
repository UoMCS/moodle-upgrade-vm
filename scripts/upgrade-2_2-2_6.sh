#!/bin/bash

rm -f /home/vagrant/moodle-*.tgz
echo "Upgrading from 2.2 to 2.6"
/usr/bin/php /home/vagrant/www/moodle2/htdocs/admin/cli/upgrade.php --non-interactive &> /vagrant_log/upgrade-2_2-2_6.txt