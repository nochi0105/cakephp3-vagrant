#!/bin/bash
 
ANSIBLE_PLAYBOOK=$1
ANSIBLE_HOSTS=$2
TEMP_HOSTS="/tmp/ansible_hosts"
 
if [ ! -f /vagrant/$ANSIBLE_PLAYBOOK ]; then
 echo "Cannot find Ansible playbook"
 exit 1
fi
 
if [ ! -f /vagrant/$ANSIBLE_HOSTS ]; then
 echo "Cannot find Ansible hosts"
 exit 2
fi
 
if ! [ `which ansible` ]; then
 sudo yum -y install epel-release
 sudo yum install -y ansible
 ansible --version
fi
 
cp /vagrant/${ANSIBLE_HOSTS} ${TEMP_HOSTS}
chmod -x ${TEMP_HOSTS}
echo "Running Ansible"
bash -c "ansible-playbook /vagrant/${ANSIBLE_PLAYBOOK} --inventory-file=${TEMP_HOSTS} --connection=local"
rm ${TEMP_HOSTS}
