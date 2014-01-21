#!/bin/bash

echo "Upgrading from 1.9 to 2.2"
/usr/bin/php /home/vagrant/www/moodle2/htdocs/admin/cli/upgrade.php --non-interactive &> /vagrant_log/upgrade-1_9-2_2.txt
rm -rf /home/vagrant/www/moodle2/htdocs/*