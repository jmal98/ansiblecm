# Ansible Control Machine (Docker'ized)

A Docker based Ansible control machine useful for running playbooks with a consistent environment.  Other similar images look to build the software items into a Docker image using Ansible, or automate the creation of a control machine, but what I wanted is to be able to run Ansible playbooks consistently using an immutable environment.

With Ansible, a typical use case is to have your CI server (Jenkins, Bamboo, etc...) orchestrate a set of playbooks to perform tasks (provision cloud resources, install packages, configure applications, etc...).  The CI environments evolve over time often introducing
dependencies which conflict with those required to run the desired version of Ansible and supporting modules which is a pain to manage IMO.  This Docker image allows you to run a fixed version of Ansible, with dependencies for some of the popular modules (ec2, route53, archive, yum, apt, etc...) in an environment which will not change as the Ansible control machine's environment becomes immutable.

Having the Ansible control machine's environment packaged up in a Docker container, the ability to provision resources using it dynamically becomes possible
using a wide variety of configurations.  For example, you can run this control machine via:

* Jenkins slaves configured with nothing more than Docker
* As tasks on Amazon Elastic Compute Service (ECS)
* As short lived pods on Kubernetes
* On your laptop without pre-installing Ansible

Basically, this control machine can be run anywhere you can run a Docker container.


## Build

```bash
docker build --tag ansiblecm:7.5.0 .
```

## Usage

Docker images are available on [Docker Hub](https://hub.docker.com/r/jmal98/ansiblecm/).

By default, this control machine will assume the execution of an Ansible playbook.  To specify which playbook
to run, simply map the playbook into the container like so:

```bash
docker run -it --rm -v <absolute path to playbook>:/tmp/playbook:Z jmal98/ansiblecm:7.5.0 <playbook arguments>
```


For example, the following will run the playbook in the current directory.

```bash
docker run -it --rm -v $PWD:/tmp/playbook:Z jmal98/ansiblecm:7.5.0 site.yml -i inventory/hosts
```


This control machine is also useful for running Ansible "[one liners](http://docs.ansible.com/ansible/latest/intro_adhoc.html)" which do not require a playbook.  The example below runs the setup module on the web machines as specified in the inventory file.

```bash
docker run -it --rm --entrypoint ansible jmal98/ansiblecm:7.5.0 web -m setup -i inventory
```

## Demo

A demo of how to use this control machine locally is provided.  For details on the setup and execution of the demo, see [DEMO](https://github.com/jmal98/ansiblecm/blob/master/DEMO.md).



## Versions

The versions of this image will closely track to the versions of [Ansible](https://github.com/ansible/ansible).  The versions of module
dependencies will be fixed to compatible versions.

## Contributing

Contributions are welcome.

## License

Apache License 2.0, see [LICENSE](https://github.com/jmal98/ansiblecm/blob/master/LICENSE).
