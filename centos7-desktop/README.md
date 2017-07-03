# Provision Java EE local development environment in Centos 7 Desktop
Provision a __Centos 7 Desktop__ based virtual machine with essential tools and software for a Java full stack developer/QA on a Windows PC. The same can be shared with a team so to maintain a consistent local environment setup.

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
3. If you need IBM MQ Explorer, download MQ Explorer install file from IBM site. It will look like ms0t_mqexplorer_9001_linux_x86_64.tar.gz and put it along Vagrantfile
--------------------------------------------------------------------

## Provisioned development tools
> The OS is [Centos 7 Desktop](https://wiki.centos.org/Manuals/ReleaseNotes/CentOS7).
1. [Oracle Java 8](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)
2. [Docker CE](https://www.docker.com/community-edition)
3. [Docker compose](https://docs.docker.com/compose/)
4. [Maven 3](https://maven.apache.org/)
5. [DBeaver](http://dbeaver.jkiss.org/)
6. [Atom](https://atom.io/)
7. [SoapUI 5.3](https://www.soapui.org/)
8. [Eclipse JEE Oxygen](https://www.eclipse.org/downloads/)
9. [IntelliJ IDEA CE](https://www.jetbrains.com/idea/features/)
10. [Tomcat 8](https://tomcat.apache.org/tomcat-8.0-doc/index.html)
11. Oracle 11 XE as a docker container
12. IBM Websphere MQ 7.5 server installed in a docker image
13. IBM MQ Explorer 9
14. [Postman](https://www.getpostman.com/apps)
15. [Git](https://git-scm.com/)
16. [Vsftpd FTP server](https://security.appspot.com/vsftpd.html)
17. Apache HTTP

## Other provisioned tools
1. Firefox browser
2. Google Chrome browser
3. [Terminator super unix terminal](https://gnometerminator.blogspot.com/p/introduction.html)
4. [Filezilla FTP client](https://filezilla-project.org/index.php)

## Setup VM
- Git clone this project

### Customize Vagrantfile
- Update the VM name, if required in Vagrantfile
- Customize vagrant configuration as required

### Customize setup.sh
- Select Centos 7 Desktop type in line 2. Options are "KDE Plasma workspaces" or "Gnome" as the poular ones.
- Verify and fix broken urls or package version
- If IBM MQ Explorer is required, update the actual file name against the readonly variable MQ_EXPLORER_FILE_NAME
- Review and remove/add sections based on your team requirements

## Create VM
- Run `vagrant up`. It may take upto an hour on a LAN connection to finish. So sit back and relax.
- Later `vagrant halt` to shutdown the VM
- Manually install Virtualbox guest addition 
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

### Running IBM MQ Explorer locally
- If MQ Explorer 9.0 is installed, it can be remotely connect to the local docker MQ conatiner and to remote MQ servers. Use user id mqm. No password is required.
- [Setup instruction](ftp://public.dhe.ibm.com/software/integration/support/supportpacs/individual/ms0t_readme_9.0.txt)

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

### Running provisioned software
- All packages are in _/opt_
- [Running Soap UI](https://www.soapui.org/getting-started/installing-soapui/installing-on-linux-or-unix.html)
- [Running IntelliJ IDEA](https://www.jetbrains.com/help/idea/installing-and-launching.html#d923076e245)


### Getting to know your VM
- Login into your VM as _vagrant/vagrant_
- You can _sudo_ to perform root actions
- The VM can communicate with the your internal network and to the internet
- The Windows OS can communicate with the VM and vice-versa
- /etc/profile is updated with MAVEN_HOME and PATH entries
- There may be wifi connectivity issues when undocking your laptop. Remember to shutdown the VM before undocking

### VM maintenance
- Centos frequently pushes OS, security and software patches. Please accept the updates
	- Open Terminal
	- ``yum -y update && yum -y upgrade``
