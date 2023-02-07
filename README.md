## Idea Behind Project

It's very simple.

Dockers are on a network of their own and I can't connect to them using their IPs.
Hence, this structure of 1 container running ansible and other containers running nginx.

- Use terraform to design the master-slave infra
- Deploy all containers using ansible.
- Use ansible to connect to master and change content of nginx servers
- Finally check if, after execution, the contents of each nginx container is different.

### TODO:
- Automate checking if the deployed containers are different.

### To Deploy
- To change the number of containers deployed, change the number_of_slaves variable in ```roles/global-vars/vars/main.yml```
- ```ansible-playbook main.yml -i hosts.ini```
