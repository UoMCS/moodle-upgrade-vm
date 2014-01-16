Moodle Upgrade VM
=================

Vagrant configuration for testing Moodle upgrade from 1.9.19 to 2.5.4.

Unlikely to be of much use unless you meet all the following criteria:

 * Need to upgrade Moodle from 1.x to 2.x (major version bump, lots of changes).
 * Use Gentoo as your Linux distribution.
 * Use Apache as your web server.
 * Use MySQL as your database server.
 
Requirements
------------
 
 * Vagrant 1.4.x or later.
 * VirtualBox 4.3.x or later.

Vagrant box
-----------

The box used is a standard x86 Gentoo install, with the following changes:

 * `gentoo-sources` is 3.4.76, as this VM needs to run on a machine without support for hardware virtualization. Gentoo kernels from 3.10 onwards hang - see: https://www.virtualbox.org/ticket/12469

In addition, the following packages have been installed:

```
app-emulation/virtualbox-guest-additions
www-servers/apache
dev-db/mysql
dev-lang/php
app-admin/puppet
```

PHP needs to be built with support for the `mysqli` extension, so add the following line to `/etc/portage/package.use`:

```
dev-lang/php mysqli
```

PHP needs to be loaded as an Apache module. Add `-D PHP5` to `APACHE2_OPTS` in `/etc/conf.d/apache3`.

The initial MySQL database needs to be set up:

```
/usr/bin/mysql_install_db
```

Apache and Puppet also need to be started on boot (MySQL is started in Puppet manifest):

```
rc-update add apache2 default
rc-udpate add puppet default
```

Puppet modules need to be installed (`puppet module install`):

```
gentoo/portage
puppetlabs/mysql
```

The global `USE` variable is set to: `bindist -X apache2 mysql php`