# Ansible

## Requirements

* install [ansible][install-ansible]
* set `hosts` in inventory file `hosts.yml`
* set `ansible_user` in inventory file `hosts.yml`
* set `ansible_ssh_private_key_file` in inventory file `hosts.yml`

## Installation

```sh
# add -v for verbose mode, -vvv for more, -vvvv to enable connection debugging
ansible-playbook packages.yml -K -i <host>,
ansible-playbook ubuntu.docker.yml -K -i <host>,
```

[install-ansible]: https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html
