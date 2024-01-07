### Hexlet tests and linter status:
[![Actions Status](https://github.com/OlgaZtv/devops-for-programmers-project-77/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/OlgaZtv/devops-for-programmers-project-77/actions)


### Application URL:
[ttalki.ru](http://ttalki.ru/)

### Prerequisites:
- UNIX system (Ubuntu)
- Terraform 1.2.9
- Ansible 2.13.13
- GNU Make 4.2.1

### Setup Ansible

1. Install Ansible requirements: `make install`
2. Encrypt vault: `make encrypt`
3. Create file with vault password at the directory `./ansible/` with name `vault-password`

### Generating Terraform variables
A `vault-password` file containing the password to the vault should be located in the root directory.
Generation is performed using the `make generate-tf-vars` command.

### Terraform initialization
``make init``

### Infrastructure preparation
``make apply``

### Deploy
``make deploy``