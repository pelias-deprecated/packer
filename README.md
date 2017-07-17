### Introduction

[packer.io](https://www.packer.io) is a utility which builds automated machine images.

Packer can be used to build `Amazon AMIs`, `Docker images`, `Google Cloud images`, `VirtualBox` etc... all from a single configuration.

The utility is highly configurable and can also accept different 'provisioners' such as `chef` or `puupet` or simply `shell`.

### Pelias

This repo contains the configuration required to build images of the Pelias services for use in production and development environments.

### Installation

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
Usage: packer [--version] [--help] <command> [<args>]

Available commands are:
    build       build image(s) from template
    fix         fixes templates from old versions of packer
    inspect     see components of a template
    push        push a template and supporting files to a Packer build service
    validate    check that a template is valid
    version     Prints the Packer version
```

### Working with submodules

many of the chef scripts in this repo are maintained by external organizations, the code is 'linked' using the `git submodule` command.

#### Update your local submodules after modifying source or executing a `git pull`

```bash
$ git submodule update
```

#### Add a new submodule

```bash
$ git submodule add https://github.com/redguide/nodejs.git chef/cookbooks/nodejs
```

#### Configuring build vars

see: https://www.packer.io/docs/templates/user-variables.html

you will need to create a file which holds your global build variables:

> note: this file is ignored by git, you must enters your AWS credentials here

```bash
$ cat templates/globals.json
{
  "aws_region": "us-east-1",
  "aws_access_key": "",
  "aws_secret_key": ""
}
```

### Build an image

> note: you can specify more than one variable file, these will be auto merged before running the template

```bash
$ packer build -var-file templates/globals.json templates/base/template.json
```
