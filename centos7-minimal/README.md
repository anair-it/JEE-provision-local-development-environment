# Provision Java EE local development environment in Centos 7 Minimal
Provision a __Centos 7__ based virtual machine with essential tools and software for a Java full stack developer/QA on a Windows PC. The same can be shared with a team so to maintain a consistent local environment setup.

## Hardware pre-requisites
1. Host machine RAM: >= 8GB
2. 64 bit architecture
3. CPU: >= 4 cores
4. Enable 64 bit virtualization in PC. By default this is turned off.
    - Restart PC
	- On boot up, open BIOS. Hold the required Fn button till the BIOS comes up.
	- Go to Advanced options > Processor Options > Intel Virtualization technology
	- Enable this feature
	- Start windows

## Software pre-requisite
1. Install [Oracle Virtualbox](https://www.virtualbox.org/wiki/VirtualBox)
2. Install [Vagrant](https://releases.hashicorp.com/vagrant/1.9.5/vagrant_1.9.5.msi?_ga=2.68613393.1872668840.1498641367-39875197.1498641367)
--------------------------------------------------------------------

## Provisioned development tools
> The OS is [Centos 7 Minimal](https://wiki.centos.org/Manuals/ReleaseNotes/CentOS7).
1. [Oracle Java 8](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)
2. [Docker CE](https://www.docker.com/community-edition)
3. [Docker compose](https://docs.docker.com/compose/)
4. [Tomcat 8](https://tomcat.apache.org/tomcat-8.0-doc/index.html)
5. Oracle 11 XE as a docker container
6. IBM Websphere MQ 7.5 server installed in a docker image
7. [Git](https://git-scm.com/)
8. [Vsftpd FTP server](https://security.appspot.com/vsftpd.html)
9. Apache HTTP

## Setup VM
- Git clone this project
- Update the VM name, if required in _Vagrantfile_
- Customize vagrant configuration as required
- If required, fix broken download urls in _setup.sh_
- Run `vagrant up`. It may take upto an hour on a LAN connection to finish. So sit back and relax.
- Later `vagrant halt` to shutdown the VM
- Modify memory and CPU as required
- Modify the hardware settings of the virtual machine for performance and because SSH needs port-forwarding enabled for the vagrant user:
    - Disable audio
    - Disable USB
    - Ensure Network Adapter 1 is set to NAT
- `vagrant up` to start the VM
- Login as vagrant\vagrant
> Use vagrant commands to start/stop the VM. Avoid doing the same through Virtualbox interface.

### Running Oracle locally
- Oracle XE is installed as a docker image. 
- Start and stop shell scripts are provided at /opt/shortcuts/oracle
- `./oracle-start.sh` to start Oracle server
- `./oracle-stop.sh` to stop Oracle server

--------

### Running IBM Websphere MQ locally
- Base IBM Websphere MQ 7.5 docker image is installed
- Open mq directory in the Desktop. Go through the README file. Make modifications as required.
- Version control the workspace project, if required

-------

### Optional Docker images
You may uncomment the optional docker images section in setup.sh to install 
- [Jenkins](https://hub.docker.com/_/jenkins/)
- [Sonar Qube](https://hub.docker.com/r/library/sonarqube/)
- [Mongo DB](https://hub.docker.com/r/library/mongo/)
- [Redis](https://hub.docker.com/_/redis/)
- [Hadoop](https://github.com/anair-it/hadoop-docker-lite/)
- [Apache Nifi, Elasticsearch, Kibana, Xpack combo](https://hub.docker.com/r/anoopnair/nifi-alpine/)
- [RedHat BRMS 6](https://hub.docker.com/r/anoopnair/jboss-brms/) or https://developers.redhat.com/demos/jbossdemocentral-brms-install/
- And more.....

-----

### Getting to know your VM
- Login into your VM as _vagrant/vagrant_
- You can _sudo_ to perform root actions
- The VM can communicate with the your internal network and to the internet
- The Windows OS can communicate with the VM and vice-versa
- There may be wifi connectivity issues when undocking your laptop. Remember to shutdown the VM before undocking

### VM maintenance
- Centos frequently pushes OS, security and software patches. Please accept the updates
	- Open Terminal
	- ``yum -y update && yum -y upgrade``
