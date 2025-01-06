PHONY: build
build: vagrant.sshd.docker.box
vagrant.sshd.docker.box: Vagrantfile metadata.json Dockerfile sshd_config
	tar czf vagrant.sshd.docker.box Vagrantfile metadata.json Dockerfile sshd_config

PHONY: install
install: tmp/install.timestamp
tmp/install.timestamp: vagrant.sshd.docker.box
	mkdir -p tmp
	vagrant box add vagrant.sshd.docker.box --name eszense/sshd --force
	touch tmp/install.timestamp

PHONY: test
test: test.shell
test.shell:
	vagrant destroy -f && vagrant up
	vagrant ssh -c 'echo 1'
	vagrant destroy -f

