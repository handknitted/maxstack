# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "ubuntu/xenial64"
  config.vm.hostname = "sencha"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "10.0.1.15"
  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"
  if Vagrant.has_plugin?("vagrant-proxyconf")
    if ENV['http_proxy'] && !ENV['http_proxy'].empty?
        config.proxy.http     = ENV['http_proxy']
        config.git_proxy.http = ENV['http_proxy']
    end
    if ENV['https_proxy'] && !ENV['https_proxy'].empty?
        config.proxy.https    = ENV['https_proxy']
    end
    if ENV['no_proxy'] && !ENV['no_proxy'].empty?
        config.proxy.no_proxy = ENV['no_proxy'] + ",10.0.1.15,10.0.2.15"
    end
  end
  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
     vb.name = "sencha"

  #   # Customize the amount of memory on the VM:
     vb.memory = "32768"
     vb.cpus = "6"
  end
  if ENV['http_proxy'] && !ENV['http_proxy'].empty?
      # we need to configure a proxy for maven also
      config.vm.provision "file", source: "settings.xml", \
        destination: "settings.xml"
      config.vm.provision "shell", path: "setup_maven_proxy.sh"
  end
  config.vm.network "forwarded_port", guest: 18080, host: 18080
  config.vm.network "forwarded_port", guest: 18081, host: 18081
  config.vm.network "forwarded_port", guest: 4040, host: 4040

  #  install dependencies for our process
  config.vm.provision "shell", path: "install.sh"
  # provision the environments
  config.vm.provision "file", source: "spark.yaml", \
    destination: "spark.yaml"
  if ENV['DD_API_KEY']
    config.vm.provision "shell", path: "provision_sencha.sh", privileged: false, env: {"DD_API_KEY" => "#{ENV['DD_API_KEY']}"}
  end

  # pg-tips will now have devstack cloned so push our local.conf file into place
  config.vm.provision "file", source: "local.conf", \
    destination: "/home/ubuntu/devstack/local.conf"
end
