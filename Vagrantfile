Vagrant.configure("2") do |config|
  config.vm.provider "docker" do |d|
    d.build_dir = File.expand_path(File.dirname(__FILE__))
    d.build_args = ["--build-arg", "BASE_IMAGE=alpine"]
    d.has_ssh = true
  end
  config.vm.network "forwarded_port", guest: 22, host: 2200, auto_correct: true
  config.ssh.host = "127.0.0.1"
end
