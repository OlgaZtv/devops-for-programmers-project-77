init:
	terraform -chdir=terraform init

tf-validate:
	terraform -chdir=./terraform validate

plan:
	terraform -chdir=terraform plan

apply:
	terraform -chdir=terraform apply
	terraform -chdir=terraform output -raw inventory > ansible/inventory.ini

destroy:
	terraform -chdir=terraform destroy

install:
	ansible-galaxy install -r ansible/requirements.yml

deploy:
	ansible-playbook -i ansible/inventory.ini -v --vault-password-file ansible/vault-password ansible/playbook.yml

generate-tf-vars:
	ansible-playbook ./ansible/terraform.yml --vault-password-file ./vault-password

encrypt:
	ansible-vault encrypt --vault-password-file ansible/vault-password ansible/group_vars/webservers/vault.yml

decrypt:
	ansible-vault decrypt --vault-password-file ansible/vault-password ansible/group_vars/webservers/vault.yml

ping:
	ansible -i ansible/inventory.ini all -m ping --vault-password-file ansible/vault-password

uptime:
	ansible -i ansible/inventory.ini all -a "uptime" --vault-password-file ansible/vault-password
