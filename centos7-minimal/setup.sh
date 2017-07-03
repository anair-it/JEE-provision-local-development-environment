# Constants
readonly JDK_VERSION=1.8.0_131
readonly DOCKER_COMPOSE_VERSION=1.14.0
readonly TOMCAT_VERSION=8.0.45

# Pre installation
echo "Started Pre installation"
yum update -y && yum upgrade -y
yum install -y git curl wget net-tools httpd vsftpd telnet
sudo mkdir -p /opt/shortcuts
echo "Ended Pre installation"


# Oracle JDK 8
echo "Installing Oracle JDK 8"
cd /opt/ && sudo wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz"
sudo tar -zxvf /opt/jdk-8u131-linux-x64.tar.gz
sudo rm /opt/jdk-8u131-linux-x64.tar.gz
cd /opt/jdk$JDK_VERSION/
alternatives --install /usr/bin/java java /opt/jdk$JDK_VERSION/bin/java 2
alternatives --install /usr/bin/jar jar /opt/jdk$JDK_VERSION/bin/jar 2
alternatives --install /usr/bin/javac javac /opt/jdk$JDK_VERSION/bin/javac 2
alternatives --set jar /opt/jdk$JDK_VERSION/bin/jar
alternatives --set javac /opt/jdk$JDK_VERSION/bin/javac
export JAVA_HOME=/opt/jdk$JDK_VERSION
export JRE_HOME=/opt/jdk$JDK_VERSION/jre
export PATH=$PATH:/opt/jdk$JDK_VERSION/bin:/opt/jdk$JDK_VERSION/jre/bin
java -version
echo "Installed Oracle JDK 8"

# Docker CE
echo "Installing Docker CE"
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum remove -y docker-ce docker docker-common container-selinux docker-selinux docker-engine
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum makecache fast
sudo yum install -y docker-ce
sudo systemctl start docker
sudo systemctl enable docker
sudo groupadd docker
sudo usermod -aG docker vagrant
docker -v
echo "Installed Docker CE"

# Docker Compose
echo "Installing Docker Compose"
curl -L https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version
echo "Installed Docker Compose"

# Tomcat
echo "Installing Tomcat"
cd /opt/ && sudo wget http://supergsego.com/apache/tomcat/tomcat-8/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz
sudo tar -zxvf /opt/apache-tomcat-$TOMCAT_VERSION.tar.gz
sudo rm /opt/apache-tomcat-$TOMCAT_VERSION.tar.gz
echo "Installed Tomcat"

# Oracle XE
echo "Installing Oracle XE"
docker stop local-oracle
docker run --name local-oracle -d -p 49160:22 -p 1521:1521 wnameless/oracle-xe-11g
docker stop local-oracle
sudo tar -xvf /vagrant/oracle.tar -C /opt/shortcuts/
echo "Installed Oracle XE"

# IBM Websphere MQ 
echo "Installing IBM Websphere MQ"
sudo tar -xvf /vagrant/mq.tar -C /opt/shortcuts/
echo "Installed IBM Websphere MQ"

# Post installation
echo "Started Post installation"
sudo systemctl start httpd.service
sudo systemctl enable httpd.service
history -c && history -w
echo "Ended Post installation"

# Additional docker images
# echo "Started additional docker image pull"
# docker pull jenkins:alpine
# docker pull sonarqube:alpine
# docker pull mongo:latest
# docker pull redis:alpine
# docker pull anoopnair/nifi-alpine:latest

# echo "Ended additional docker image pull"

reboot
