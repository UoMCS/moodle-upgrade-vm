#!/bin/bash

rm -f /home/vagrant/moodle-*.tgz
/usr/bin/mysql -u moodle -D moodle < /home/vagrant/moodle.sql
rm -f /home/vagrant/moodle.sql
