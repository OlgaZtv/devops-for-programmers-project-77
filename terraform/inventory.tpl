[webservers]
vm1 ansible_host=${webserver1}
vm2 ansible_host=${webserver2}

[webservers:vars]
ansible_user=ttalki