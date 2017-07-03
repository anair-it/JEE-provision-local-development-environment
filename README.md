# Provision Java EE local development environment
- Onboard a Java developer/QA in few minutes.
- Quickly provision a local development environment with essential tools and software for a Java full stack developer/QA on a Windows PC. 
- Share configuration in the team to maintain a consistent local environment setup.

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

Following VM environments are available:
- [Ubuntu 16](https://github.com/anair-it/JEE-provision-local-development-environment/blob/master/ubuntu/README.md)
- [Centos 7 Desktop](https://github.com/anair-it/JEE-provision-local-development-environment/tree/master/centos7-desktop/README.md)
- [Centos 7 Minimal](https://github.com/anair-it/JEE-provision-local-development-environment/tree/master/centos7-minimal/README.md)

