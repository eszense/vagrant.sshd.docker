# Vagrant sshd box for docker provider

Box installing a Vagrant-compatible sshd onto an user-specified alpine-based image

### Customization
Specify `build_args` in Vagrantfile to modify the box at runtime.

Supported options:
 - `SSHD_BASE_IMAGE`: specify an alpine image from which `sshd` is installed (default: `alpine`)
 - `SSHD_ALLOW_PORT_FORWARD`: Value for `AllowTcpForwarding` in `sshd_config` (`yes`|`no`|`local`|`remote`, default: `no`)

### Example Vagrantfile
```ruby
Vagrant.configure("2") do |config|
    config.vm.box = "eszense/sshd"
    config.vm.provider "docker" do |d|
        d.build_args = ["--build-arg", "SSHD_BASE_IMAGE=python:alpine", "--build-arg", "SSHD_ALLOW_PORT_FORWARD=yes"]
    end
    config.vm.provision "shell", inline: "
        set -e \n
        apk add --no-cache build-base linux-headers
    "
end
```
