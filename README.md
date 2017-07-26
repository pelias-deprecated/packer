### Introduction

[packer.io](https://www.packer.io) is a utility which builds automated machine images.

Packer can be used to support a variety of [builders](https://www.packer.io/docs/builders/index.html) such as `Amazon AMIs`, `Docker images`, `Google Cloud images`, `VirtualBox` etc... all from a single configuration.

The utility is highly configurable and can also accept different [provisioners](https://www.packer.io/docs/provisioners/index.html) such as `chef` or `puppet` or simply `shell` scripts.

### Pelias

This repo contains the configuration required to build images of Pelias services, for use in production and development environments.

### Installing Packer

see: https://www.packer.io/docs/install/index.html

```bash
# linux example:

# download and extract
$ wget https://releases.hashicorp.com/packer/1.0.2/packer_1.0.2_linux_amd64.zip
$ unzip packer_1.0.2_linux_amd64.zip

# place the binary somewhere on your path
$ echo $PATH
$ sudo mv packer /usr/local/bin/

# packer is installed
$ packer
```

### Working with submodules

many of the chef scripts in this repo are maintained by external organizations, the code is 'linked' using the `git submodule` command.

#### Update your local submodules after modifying source or executing a `git pull`

```bash
$ git submodule update --init --recursive
```

#### Upgrade all submodules to the latest version

```bash
$ git submodule foreach git pull
```

#### Add a new submodule

```bash
$ git submodule add https://github.com/redguide/nodejs.git chef/cookbooks/nodejs
```

#### Remove a submodule

you can remove a module by [following these directions](https://davidwalsh.name/git-remove-submodule).

### Lint cookbooks

use `foodcritic` to display potential errors in your cookbooks:

```bash
$ foodcritic chef/cookbooks
```

### Configuring build vars

see: https://www.packer.io/docs/templates/user-variables.html

you will need to create a file which holds your global build variables:

> note: this file is ignored by git, you must enters your AWS credentials here

```bash
$ cat config/globals.json
{
  "aws_region": "us-east-1",
  "aws_access_key": "",
  "aws_secret_key": ""
}
```

### Build an image

> note: you can specify more than one variable file, these will be auto merged before running the template

```bash
$ packer build -var-file config/globals.json templates/base.json
```

### Overriding variables on the CLI

see: https://www.packer.io/docs/templates/user-variables.html

you can override any default variables using the `-var` flag on the CLI:

```bash
$ packer build \
  -var-file config/globals.json \
  -var 'aws_instance_type=m3.xlarge' \
  templates/base.json
```
