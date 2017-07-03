# Constants
readonly DOCKER_COMPOSE_VERSION=1.14.0
readonly ATOM_VERSION=1.18.0
readonly MAVEN_VERSION=3.3.9
readonly SOAPUI_VERSION=5.3.0
readonly TOMCAT_VERSION=8.0.45
readonly ECLIPSE_VERSION=eclipse-jee-oxygen-R-linux-gtk-x86_64
readonly INTELIJ_IDEA_VERSION=ideaIC-2017.1.3
readonly MQ_EXPLORER_FILE_NAME=ms0t_mqexplorer_9001_linux_x86_64

# Pre installation
echo "Started Pre installation"
sudo apt-get update
sudo add-apt-repository -y ppa:webupd8team/java
sudo sh -c 'echo "deb http://archive.getdeb.net/ubuntu xenial-getdeb apps" >> /etc/apt/sources.list.d/getdeb.list'
sudo wget -q -O - http://archive.getdeb.net/getdeb-archive.key | sudo apt-key add -
sudo apt-get install -y git wget apt-transport-https ca-certificates curl software-properties-common terminator gdebi filezilla rabbitvcs* libgconf2-4 libnss3-1d libxss1 vsftpd
sudo apt-get update
echo "Ended Pre installation"

# Google Chrome
echo "Installing Google Chrome"
cd /opt/ && sudo wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb && sudo rm -f /opt/google-chrome*.deb
sudo apt-get install -f -y
echo "Installed Google Chrome"

# Postman
echo "Installing Postman"
cd /opt/ && sudo wget https://dl.pstmn.io/download/latest/linux64 -O postman.tar.gz
cd /opt/ && sudo tar -xzf postman.tar.gz -C /opt && sudo rm postman.tar.gz
sudo ln -s /opt/Postman/Postman /usr/bin/postman
echo "Installed Postman"

# Oracle JDK 8
echo "Installing Oracle JDK 8"
echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections 
echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
sudo apt-get install -y oracle-java8-installer
java -version
echo "Installed Oracle JDK 8"

# Docker CE
echo "Installing Docker CE"
sudo apt-get remove docker docker-engine
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce
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
sudo sh -c "echo 'M2_HOME=/opt/apache-maven-${MAVEN_VERSION}' >> /etc/profile"
sudo sh -c "echo 'PATH=${M2_HOME}/bin:${PATH}' >> /etc/profile"
sudo sh -c "echo 'export M2_HOME' >> /etc/profile"
sudo sh -c "echo 'export PATH' >> /etc/profile"
sudo rm /opt/apache-maven-$MAVEN_VERSION-bin.tar.gz
mvn -v
echo "Installed Maven 3"

# Dbeaver
echo "Installing DBeaver"
cd /opt/ && sudo wget http://dbeaver.jkiss.org/files/dbeaver-ce_latest_amd64.deb
sudo dpkg -i dbeaver-ce_latest_amd64.deb && sudo rm -f /opt/dbeaver*.deb
echo "Installed DBeaver"

# Atom editor
echo "Installing Atom editor"
cd /opt/ && sudo wget https://github.com/atom/atom/releases/download/v$ATOM_VERSION/atom-amd64.deb
sudo dpkg -i atom-amd64.deb && sudo rm -f /opt/atom*.deb
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
sudo tar -zxvf /vagrant/$MQ_EXPLORER_FILE_NAME.tar.gz -C /opt/MQ_Explorer && cd /opt/MQ_Explorer
sudo sed -i 's/LICENSE_ACCEPTED=FALSE/LICENSE_ACCEPTED=TRUE/g' silent_install.resp 
sudo ./Setup.bin -f silent_install.resp
cd .. && sudo rm -Rf MQ_Explorer
echo "Installed IBM MQ Explorer"

# Post installation
echo "Started Post installation"
sudo update-locale LANG=en_US.UTF-8 LANGUAGE=en_US # Fix for gnome terminal not opening issue
sudo apt-get update
sudo rm *.tar.gz* && sudo rm *.deb*
sudo echo "Cleaning Up" &&
sudo apt-get -f -y install &&
sudo apt-get autoremove &&
sudo apt-get -y autoclean &&
sudo apt-get -y clean &&
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
