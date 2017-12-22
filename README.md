# Ansible Control Machine (Dockerized)

A Docker based Ansible control machine used to run playbooks with a consistent environment.  Other similar images look to build the items into a Docker 
image using Ansible, but what I wanted is to be able to run Ansible playbooks consistently.


## Build

```bash
docker build --tag ansible-playbook:2.3.2.0 .
```

## To Use

```bash
docker run -it --rm -v <path to playbook>:/tmp/playbook:Z -v /tmp/keys:/tmp/keys:Z jmal98/ansible-playbook:2.3.2.0 <ansible playbook arguments>
```

For example, the following will run the playbook in the current directory.

```bash
docker run -it --rm -v $PWD:/tmp/playbook:Z jmal98/ansible-playbook:2.3.2.0 site.yml -i inventory/hosts -vv
```

