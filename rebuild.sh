#/bin/sh
ansible-playbook -i localhost terraform.yaml --extra-vars "state=absent"
ansible-playbook -i localhost terraform.yaml
ansible-playbook -i production site.yaml --become
