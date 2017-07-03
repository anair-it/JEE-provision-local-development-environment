# Constants
readonly DESKTOP_TYPE="KDE Plasma Workspaces" # "Gnome"
readonly JDK_VERSION=1.8.0_131
readonly DOCKER_COMPOSE_VERSION=1.14.0
readonly TOMCAT_VERSION=8.0.45
readonly MAVEN_VERSION=3.3.9
readonly SOAPUI_VERSION=5.3.0
readonly ECLIPSE_VERSION=eclipse-jee-oxygen-R-linux-gtk-x86_64
readonly INTELIJ_IDEA_VERSION=ideaIC-2017.1.3

# Pre installation
echo "Started Pre installation"
yum update -y && yum upgrade -y
yum install -y epel-release 
yum install -y git curl wget net-tools httpd vsftpd telnet filezilla terminator
sudo mkdir -p /opt/shortcuts
yum -y groups install " $DESKTOP_TYPE "
yum update -y
sudo systemctl set-default graphical.target
echo "Ended Pre installation"

# Google Chrome
echo "Installing Google Chrome"
cd /opt/ && sudo wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
sudo yum install -y google-chrome-stable_current_x86_64.rpm && sudo rm -f /opt/google-chrome-stable_current_x86_64.rpm
echo "Installed Google Chrome"

# Postman
echo "Installing Postman"
cd /opt/ && sudo wget https://dl.pstmn.io/download/latest/linux64 -O postman.tar.gz
cd /opt/ && sudo tar -xzf postman.tar.gz -C /opt && sudo rm postman.tar.gz
sudo ln -s /opt/Postman/Postman /usr/bin/postman
echo "Installed Postman"

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
echo 'export JAVA_HOME=/opt/jdk$JDK_VERSION
export JRE_HOME=/opt/jdk$JDK_VERSION/jre
export PATH=${JAVA_HOME}/bin:${PATH}' > /etc/profile.d/java.sh
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

# Maven 3
echo "Installing Maven 3"
cd /opt/ && sudo wget http://www-eu.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz
sudo tar -xvzf apache-maven-$MAVEN_VERSION-bin.tar.gz
cd /opt/ && sudo ln -s apache-maven-$MAVEN_VERSION maven 
echo 'export M2_HOME=/opt/maven
export PATH=${M2_HOME}/bin:${PATH}
export PATH=${M2_HOME}:${PATH}' > /etc/profile.d/maven.sh
sudo rm /opt/apache-maven-$MAVEN_VERSION-bin.tar.gz
echo "Installed Maven 3"

# Dbeaver
echo "Installing DBeaver"
cd /opt/ && sudo wget http://dbeaver.jkiss.org/files/dbeaver-ce-latest-stable.x86_64.rpm
sudo yum install -y dbeaver-ce-latest-stable.x86_64.rpm && sudo rm -f /opt/dbeaver*.rpm
echo "Installed DBeaver"

# Atom editor
echo "Installing Atom editor"
cd /opt/ && sudo wget https://atom.io/download/rpm -O atom.x86_64.rpm
yum install -y atom.x86_64.rpm && sudo rm -f /opt/atom*.rpm
echo "Installed Atom editor"

# SoapUI
echo "Installing SoapUI"
cd /opt/ && sudo wget http://cdn01.downloads.smartbear.com/soapui/$SOAPUI_VERSION/SoapUI-$SOAPUI_VERSION-linux-bin.tar.gz
sudo tar -xvzf /opt/SoapUI-$SOAPUI_VERSION-linux-bin.tar.gz
sudo rm /opt/SoapUI-$SOAPUI_VERSION-linux-bin.tar.gz
echo "Installed SoapUI"

# Eclipse JEE
echo "Installing Eclipse JEE"
cd /opt/ && sudo wget http://eclipse.stu.edu.tw/technology/epp/downloads/release/oxygen/R/$ECLIPSE_VERSION.tar.gz
sudo tar -zxvf /opt/$ECLIPSE_VERSION.tar.gz
sudo rm /opt/$ECLIPSE_VERSION.tar.gz
echo "Installed Eclipse JEE"

# IntelliJ IDEA CE
echo "Installing IntelliJ IDEA"
cd /opt/ && sudo wget https://download.jetbrains.com/idea/$INTELIJ_IDEA_VERSION.tar.gz
sudo tar -xzf $INTELIJ_IDEA_VERSION.tar.gz
sudo rm /opt/$INTELIJ_IDEA_VERSION.tar.gz
echo "Installed IntelliJ IDEA"

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

# IBM MQ Explorer
echo "Installing IBM MQ Explorer"
sudo mkdir /opt/MQ_Explorer
sudo tar -zxvf /vagrant/ms0t_mqexplorer_9001_linux_x86_64.tar.gz -C /opt/MQ_Explorer && cd /opt/MQ_Explorer
sudo sed -i 's/LICENSE_ACCEPTED=FALSE/LICENSE_ACCEPTED=TRUE/g' silent_install.resp 
sudo ./Setup.bin -f silent_install.resp
cd .. && sudo rm -Rf MQ_Explorer
echo "Installed IBM MQ Explorer"

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
