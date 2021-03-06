#######Setup Ansible script to install everything necessary to run AVT system without access to the internet.


- Install Docker and Docker Compose
- Install Python 3.8
- Install latest security updates
- Make available Docker images defined in docker-compose.yaml (may require pre-packaging dependencies; needs research)
- Stand up another instance to test on and run the process
- Run software using docker compose up --build -d

#####Below are the preqrequisite to successfully achieve  this task

- New Redhat 8 Instance
- Redhat 8 ISO
- Python 3.9 package
- Docker and Docker Compose packages
- Docker Images
 - docker pull grafana/grafana:8.1.1
 - docker pull grafana/loki:2.3.0
 - docker pull timescale/timescaledb:latest-pg12
 - docker pull dpage/pgadmin4
 - docker pull nginx:latest
- A shell Script that will deploy all the packages
- winscp utility

#########We have packaged all preqrequisite in a tar ball, below are the steps involved in deploying the package

- Secure copy or upload the package to the new server in "ec2-user" home directory
- Untar the package software-package-new.tar
	- tar xvf software-package-new.tar
- We will see 2 folders 
	1) Ansible-Packages (Ansible Package will have all the packages related to OS install i.e Security Patches)
	2) Installation (This will have 2 package)
	   - local
	   - remote (This will have the shell script
	     - images (Docker Images)
		 - packages (Docker, docker compose, python 3.9, pip) 
		 - files (local repo files)
		 
- Run the .bootstrap script from remote folders
  1) Script will copy Bases OS
  2) Script will copy Appstream
  3) OS patches
  4) Installing docker and docker-compose
  5) Pulling docker images
  6) Installing python/pip and related dependencies
  7) Running docker compose up
	
