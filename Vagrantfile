# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
	config.vm.provider :virtualbox do |v|
		 v.name = "centos7.2"
		 v.customize ["modifyvm", :id, "--memory", 1024]
	end

	config.vm.synced_folder ".", "/vagrant", mount_options: ['dmode=777','fmode=777']

	config.vm.box = "bento/centos-7.2"
	if Vagrant.has_plugin? "vagrant-vbguest"
		config.vbguest.auto_update = false
	end

	config.vm.network :private_network, ip: "192.168.33.11" 
	config.ssh.forward_agent = true

	# Fix timeout error for OS X
	config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--cableconnected1", "on"]
  end

	config.vm.provision "shell" do |sh|
		sh.path = ".provisioning/provision.sh"
		sh.args = ".provisioning/playbook.yml .provisioning/hosts"
	end

	config.vm.provision "shell", run: "always", inline: <<-SHELL
		sudo service httpd start
	SHELL

end
