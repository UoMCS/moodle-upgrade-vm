# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "gentoo-moodle-puppet-v10"
  
  # This box can take several minutes to boot on old machines, so increase the boot timeout
  # (default is far too low)
  config.vm.boot_timeout = 180

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network :forwarded_port, guest: 80, host: 8080
  config.vm.network :forwarded_port, guest: 443, host: 4433

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder "./data", "/vagrant_data"
  config.vm.synced_folder "./vhosts", "/vagrant_vhosts"
  config.vm.synced_folder "./log", "/vagrant_log"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  config.vm.provider :virtualbox do |vb|
    # Don't boot with headless mode
    #vb.gui = true

    vb.customize ["modifyvm", :id, "--memory", 2048]
    vb.customize ["modifyvm", :id, "--cpus", 1]
     
    # Disable hardware virtualization - can comment this out if your CPU supports VT-X/AMD-V
	# (you will probably see a significant performance boost)
    vb.customize ["modifyvm", :id, "--hwvirtex", "off"]
  end
  
  config.vm.provision "shell", path: "scripts/free-space.sh"
  
  config.vm.provision "puppet"
  config.vm.provision "shell", path: "scripts/moodle-import.sh"
  config.vm.provision "shell", path: "scripts/upgrade-1_9-2_2.sh"
  
  config.vm.provision "puppet" do |puppet|
    puppet.manifest_file = "2_2-2_6.pp"
  end
  
  config.vm.provision "shell", path: "scripts/upgrade-2_2-2_6.sh"
end
