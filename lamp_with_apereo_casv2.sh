#!/bin/bash
#######################################
# In case of any errors (e.g. MySQL) just re-run the script. Nothing will be re-installed except for the packages with errors.
#######################################
#  Written by Anoop Singh from http://hostingshades.com/

#COLORS
# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

######################## Deafult Details ##################################
MYSQL_PASSWD_DEF="Host@12345"
#Tomcat Install
TOMCAT_INSTALL_DIR="/usr/share"
TOMCAT_VER="9.0.69"
TOMCAT_USER="tomcat" 
TOMCAT_URL="https://dlcdn.apache.org/tomcat/tomcat-9/v$TOMCAT_VER/bin/apache-tomcat-$TOMCAT_VER.tar.gz"

# Apereo Defaults
APEREO_CAS_VER="6.6"                        # Used to do a git checkout
APEREOCAS_USER="apereo"                     # The user name and group of the cas
DOMAIN_NAME_DEF="mycompany.com"
CAS_HOME="/etc/cas/config"
CAS_AUTHN_PAC4J_GOOGLE_ID_DEF="111111111--sgmxxxxxxxxxxxxxxxxxxxxx.apps.googleusercontent.com"
CAS_AUTHN_PAC4J_GOOGLE_SECRET_DEF="secret123"
CAS_AUTHN_PAC4J_GOOGLE_SCOPE_DEF="EMAIL_AND_PROFILE"
CAS_SERVICEREGISTRY_JSON_LOCATION_DEF="file:$CAS_HOME/services/"
CAS_SERVICE_NAME_DEF="SuiteCRM"
CAS_SERVICE_ID_DEF="10000001"
CAS_PREFIX_KEY_DEF="https://localhost:8443"
CAS_PREFIX_DEF="127.0.0.1"
# CAS_DB_NAME_DEF="cas_db"
# CAS_DB_USER_DEF="db_user_cas"
# CAS_DB_PASSWORD_DEF="cas_password"

CAS_INSTALL_PATH_DEF="/opt/cas"
CAS_PROPERTIES_PATH_DEF="$CAS_HOME/application.properties"
CAS_LOG4J2_PATH_DEF="$CAS_HOME/log4j2.xml"
APEREO_GIT_URL="https://github.com/apereo/cas-overlay-template.git"
PWD=$(pwd) # Current directory
CAS_INSTALL_DIR="/usr/local/src" # CAS source directory dir

# Deafult value
web_def="1"
php_def="2"
mysql_def="1"
cas_def="yes"
ping_def="yes"
firewall_def="yes"
################################### Check if running as root  
 if [ "$(id -u)" != "0" ]; then  
   echo -e "$BRed This script must be run as root $Color_Off" 1>&2  
   exit 1  
 fi  


############################# web server ##################################
while true; do
        echo -e "$BCyan------------------------ Please Choose Webserver ----------------------------$Color_Off"
        echo -e "$BCyan------------------------ We Recommend Apache --------------------------------$Color_Off"
        echo -en "$BGreen       1. Apache       2. Ngnix     3.Cancel $BWhite[Deafult Is Apache]:$BYellow"
        read web
        web="${web:-$web_def}"
   case $web in
        1) break;;
        2) break;;
        3) echo -e "$Color_Off" 
        break;;
        *) echo -e "$BYellow Wrong Input ! Please Answer 1 ,2 or 3 $Color_Off" ;;
    esac

done

################################## PHP ##################################

while true; do
        echo -e "$BCyan------------------------ Please Choose PHP Version --------------------------$Color_Off"
        echo -en "$BGreen       1. PHP 7.4      2. PHP 8.0       3. Cancel $BWhite[Deafult Is PHP 8.0]: $BYellow"
        read php
        php="${php:-$php_def}"
      case $php in
        1) break;;
        2) break;;
        3) echo -e "$Color_Off" 
        break;;
        *) echo -e "$BYellow Wrong Input ! Please Answer 1 ,2 or 3 $Color_Off" ;;
    esac
done
#################################### MYSQL ##################################
while true; do
        echo -e "$BCyan------------------------ Please Choose MySQL Version ------------------------$Color_Off"
        echo -e "$BCyan------------------------ We Recommend MariaDB 10.5 --------------------------$Color_Off"
        echo -en "$BGreen       1. MariaDB 10.5     2. MySQL 8.0   3.Cancel $BWhite[Deafult Is MariaDB 10.5]: $BYellow"
        read mysql
        mysql="${mysql:-$mysql_def}"
    
    case $mysql in
        1) echo -en "$BGreen Please Set MySQL Root Password $BWhite(Default Pass: $MYSQL_PASSWD_DEF):$BYellow"
        read MYSQL_ROOT_PASSWORD
        MYSQL_ROOT_PASSWORD="${MYSQL_ROOT_PASSWORD:-$MYSQL_PASSWD_DEF}"

        break;;
        2) echo -en "$BGreen Please Set MySQL Root Password $BWhite(Default Pass: $MYSQL_PASSWD_DEF):$BYellow"
        read MYSQL_ROOT_PASSWORD
        MYSQL_ROOT_PASSWORD="${MYSQL_ROOT_PASSWORD:-$MYSQL_PASSWD_DEF}"
        
        break;;

        3) echo -e "$Color_Off" 
        break;;
        *) echo -e "$BYellow Wrong Input ! Please Answer 1 ,2 or 3 $Color_Off" ;;
    esac

        
done

################################### Firewall ##################################
while true; do
        echo -e "$BCyan------------------------ Please Choose Firewall  ----------------------------$Color_Off"
        echo -en "$BGreen Do you want to allow Http/Https In Firewall .....Yes/No $BWhite[Deafult Is Yes]: $BYellow"
        read firewall
        firewall="${firewall:-$firewall_def}"
        case $firewall in
        [yY][eE][sS]|[yY]) break;;
        [nN][oO]|[nN])  break;;
        *) echo -e "$BYellow Wrong Input ! Please Answer Yes or No $Color_Off" 
    esac
done

while true; do
        
        echo -en "$BGreen Do you want to Install APEREO CAS .....Yes/No $BWhite[Deafult Is Yes]: $BYellow"
        read cas
        cas="${cas:-$cas_def}"
    case $cas in
        [yY][eE][sS]|[yY]) 

        echo -en "$BGreen Enter a valid hostname or public domain such as $BWhite mydomain.com : $BYellow"
        read DOMAIN_NAME

        echo -en "$BGreen Do you want to ping $DOMAIN_NAME $BWhite[Deafult Is Yes]: $BYellow"
        echo -en "$BGreen"
        read ping1
        ping1="${ping1:-$ping_def}"
            while true; do
                case $ping1 in
                    [yY][eE][sS]|[yY]) 
                    
                        ping=$(ping -c 3 ${DOMAIN_NAME})
                        if [[ ${ping} ]]; then
                            
                            #echo -e "$BGreen $DOMAIN_NAME ${ping}"
                            echo -e "$BGreen $DOMAIN_NAME is reachable successfully"
                            break 1
                        else
                            echo -e " $BYellow $DOMAIN_NAME is unreachable "
                            echo -en "$BGreen Please re-enter domain name: $BYellow" 
                            read DOMAIN_NAME  
                        fi
                    
                        echo  -e "$Color_Off" ;;
                    [nN][oO]|[nN])  break;;
                    
                    *) echo  "$BYellow Wrong Input ! Please Answer Yes or No $Color_Off" 
                esac
            done


CAS_SERVER_NAME_DEF="https://$DOMAIN_NAME"
CAS_SERVER_PREFIX_DEF="https://$DOMAIN_NAME/cas"
CAS_AUTHORIZATION_ENDPOINT_DEF="https://$DOMAIN_NAME/cas"
CAS_REDIRECT_URI_DEF="https://$DOMAIN_NAME"
CAS_SERVER_NAME_DEF="https://$DOMAIN_NAME"
CAS_SERVER_PREFIX_DEF="https://$DOMAIN_NAME/cas"
CAS_AUTHORIZATION_ENDPOINT_DEF="https://$DOMAIN_NAME/cas"
CAS_REDIRECT_URI_DEF="https://$DOMAIN_NAME/suitecrm"


############################ Reading Data #############################
echo -en "$BGreen  Enter the Apereo CAS server name $BWhite[default $CAS_SERVER_NAME_DEF]: $BYellow"
read CAS_SERVER_NAME
CAS_SERVER_NAME="${CAS_SERVER_NAME:-$CAS_SERVER_NAME_DEF}"


echo -en "$BGreen  Enter the CAS Authorization Endpoint $BWhite[default $CAS_AUTHORIZATION_ENDPOINT_DEF]: $BYellow"
read CAS_AUTHORIZATION_ENDPOINT
CAS_AUTHORIZATION_ENDPOINT="${CAS_AUTHORIZATION_ENDPOINT:-$CAS_AUTHORIZATION_ENDPOINT_DEF}"
        
echo -en "$BGreen  Enter the redirect URI for CAS $BWhite[default $CAS_REDIRECT_URI_DEF]: $BYellow"
read CAS_REDIRECT_URI
CAS_REDIRECT_URI="${CAS_REDIRECT_URI:-$CAS_REDIRECT_URI_DEF}"
        
        
echo -en "$BGreen  Enter the Apereo CAS Prefix Key $BWhite[default $CAS_PREFIX_KEY_DEF]: $BYellow"
read CAS_PREFIX_KEY
CAS_PREFIX_KEY="${CAS_PREFIX_KEY:-$CAS_PREFIX_KEY_DEF}"
        
echo -en "$BGreen  Enter the Apereo CAS Prefix $BWhite[default $CAS_PREFIX_DEF]: $BYellow"
read CAS_PREFIX
CAS_PREFIX="${CAS_PREFIX:-$CAS_PREFIX_DEF}"
        
echo -en "$BGreen  Enter the Apereo CAS Install PATH $BWhite[default $CAS_INSTALL_PATH_DEF]: $BYellow"
read CAS_INSTALL_PATH
CAS_INSTALL_PATH="${CAS_INSTALL_PATH:-$CAS_INSTALL_PATH_DEF}"
        
echo -en "$BGreen  Enter the Apereo CAS Properties path $BWhite[default $CAS_PROPERTIES_PATH_DEF]: $BYellow"
read CAS_PROPERTIES_PATH
CAS_PROPERTIES_PATH="${CAS_PROPERTIES_PATH:-$CAS_PROPERTIES_PATH_DEF}"
        
echo -en "$BGreen  Enter the Apereo CAS log4j2 properties path $BWhite[default $CAS_LOG4J2_PATH_DEF]: $BYellow"
read CAS_LOG4J2_PATH
CAS_LOG4J2_PATH="${CAS_LOG4J2_PATH:-$CAS_LOG4J2_PATH_DEF}"
        
        
echo -en "$BGreen  Enter the Apereo CAS server prefix $BWhite[default $CAS_SERVER_PREFIX_DEF]: $BYellow"
read CAS_SERVER_PREFIX
CAS_SERVER_PREFIX="${CAS_SERVER_PREFIX:-$CAS_SERVER_PREFIX_DEF}"
        
echo -en "$BGreen  Enter the Apereo CAS Service registry location $BWhite[default $CAS_SERVICEREGISTRY_JSON_LOCATION_DEF]: $BYellow"
read CAS_SERVICEREGISTRY_JSON_LOCATION
CAS_SERVICEREGISTRY_JSON_LOCATION="${CAS_SERVICEREGISTRY_JSON_LOCATION:-$CAS_SERVICEREGISTRY_JSON_LOCATION_DEF}"
        
echo -en "$BGreen  Enter the Apereo CAS service name $BWhite[default $CAS_SERVICE_NAME_DEF]: $BYellow"
read CAS_SERVICE_NAME
CAS_SERVICE_NAME="${CAS_SERVICE_NAME:-$CAS_SERVICE_NAME_DEF}"
        
echo -en "$BGreen  Enter the Apereo CAS service ID $BWhite[default $CAS_SERVICE_ID_DEF]: $BYellow"
read CAS_SERVICE_ID
CAS_SERVICE_ID="${CAS_SERVICE_ID:-$CAS_SERVICE_ID_DEF}"


                            while true; do
        
                                    echo -en "$BGreen Do you want to Install SSl with CAS .....Yes/No : $BYellow"
                                    read ssl
                                    case $ssl in
                                    [yY][eE][sS]|[yY]) 
                                    echo -en "$BGreen Enter a valid e-mail for let's encrypt certificate: $BYellow"
	                                read EMAIL_NAME
                                    break;;
                                    [nN][oO]|[nN])  break;;
                                    *) echo -e "$BYellow Wrong Input ! Please Answer Yes or No $Color_Off" 
                                esac
                            done
        
        break;;
        [nN][oO]|[nN])  break;;
        *) echo -e "$BYellow Wrong Input ! Please Answer Yes or No $Color_Off" 
    esac
done
################
while true; do
 echo -en "$BGreen  Do you want to configure CAS with GOOGLE Credentials (yes/no): $BYellow"
 read CONFIGURE_GOOGLE
	case $CONFIGURE_GOOGLE in
		[yY][eE][sS]|[yY]) 

         echo -en "$BGreen  Enter the PAC4J Google ID $BWhite[default $CAS_AUTHN_PAC4J_GOOGLE_ID_DEF]: $BYellow"
         read CAS_AUTHN_PAC4J_GOOGLE_ID
         CAS_AUTHN_PAC4J_GOOGLE_ID="${CAS_AUTHN_PAC4J_GOOGLE_ID:-$CAS_AUTHN_PAC4J_GOOGLE_ID_DEF}"

         echo -en "$BGreen  Enter the PAC4J Google Secret $BWhite[default $CAS_AUTHN_PAC4J_GOOGLE_SECRET_DEF] : $BYellow"
         read CAS_AUTHN_PAC4J_GOOGLE_SECRET
         CAS_AUTHN_PAC4J_GOOGLE_SECRET="${CAS_AUTHN_PAC4J_GOOGLE_SECRET:-$CAS_AUTHN_PAC4J_GOOGLE_SECRET_DEF}"

         echo -en "$BGreen  Enter the PAC4J Google Scope $BWhite[default $CAS_AUTHN_PAC4J_GOOGLE_SCOPE_DEF] : $BYellow"
         read CAS_AUTHN_PAC4J_GOOGLE_SCOPE
         CAS_AUTHN_PAC4J_GOOGLE_SCOPE="${CAS_AUTHN_PAC4J_GOOGLE_SCOPE:-$CAS_AUTHN_PAC4J_GOOGLE_SCOPE_DEF}"
			
         break;;
            
            
            
        [nN][oO]|[nN])  
            break;;
			
            *|"" ) echo -e "$BYellow Please enter yes or no. $BYellow";;
	esac
done

#########################

while true; 
do
echo -en "$BCyan Would you like to proceed to setting up the Lamp     Yes/No: $BYellow"
read lamp

case $lamp in
        y|Y|yes|Yes|YES)
################################## Instaling Package ##################################
echo -e "$BCyan------------------------ Downloading and Installing HRN_LAMP (Official installer) ----------------------------$Color_Off"
sleep 1

yum update -y > update.log
yum install wget vim zip unzip git -y > install.log
yum install epel-release -y > install.log
yum install certbot python2-certbot-apache mod_ssl -y > install.log
yum install -y cairo-devel  gcc gnu-free-mono-fonts policycoreutils-python pulseaudio-libs-devel setroubleshoot uuid-devel nano mlocate net-tools wget telnet mlocate policycoreutils-python autoconf automake git libtool jq  > install.log

# Setup automatic cert renewal

systemctl enable certbot-renew.service
systemctl enable certbot-renew.timer
systemctl start certbot-renew.service
systemctl start certbot-renew.timer
systemctl list-timers --all | grep certbot


echo -e "$BCyan------------------------------- Installing JAVA --------------------------$Color_Off"
sleep 1
sudo yum install java-11-openjdk-devel -y > java-install.log


################################## PHP Instalation ##################################
echo -e "$BCyan------------------------ PHP Installation Under Process-------------------------------------------------------$Color_Off"

while true; do

        case $php in
                1) echo -e "$BCyan---------------------------Installing PHP 7.4 Under Process...... $Color_Off"
                        
                        sudo rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
                        yum --enablerepo=remi-php74 install php -y
                        yum --enablerepo=remi-php74 install php-xml php-soap php-xmlrpc php-mbstring php-json php-gd php-mcrypt  php-cli php-curl php-common php-intl php-mysqli php-pdo_mysql php-openssl php-zip php-imap php-ldap php-pdo_mysql -y
                        cp /etc/php.ini  /etc/php.ini_original
                        sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 200M/' /etc/php.ini
                        sed -i 's/memory_limit = 128M/memory_limit = 200M/' /etc/php.ini
                        
                        echo -e "$BCyan---------------------PHP Installation Completed--------------$Color_Off"
                        
                        break;;

                2) echo -e "$BCyan---------------------------Installing PHP 8.0 Under Process...... $Color_Off"
                      
                        sudo rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
                        yum --enablerepo=remi-php80 install php -y
                        yum --enablerepo=remi-php80 install php-xml php-soap php-xmlrpc php-mbstring php-json php-gd php-mcrypt  php-cli php-curl php-common php-intl php-mysqli php-pdo_mysql php-openssl php-zip php-imap php-ldap php-pdo_mysql -y
                        cp /etc/php.ini  /etc/php.ini_original
                        sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 200M/' /etc/php.ini
                        sed -i 's/memory_limit = 128M/memory_limit = 200M/' /etc/php.ini
                        echo -e "$BCyan---------------------PHP Installation Completed--------------$Color_Off"
                        break;;
                
                3) echo -e "$Color_Off"
                break;;

                *) echo -e "$BYellow Wrong Input ! Please Answer 1 ,2 or 3 $Color_Off" ;;        
        esac
done

##################################################### Installing MYSQL #########################################################
echo -e "$BCyan------------------------ MySQL Installation Under Process-----------------------------------------------------$Color_Off"
sleep 1
while true; do

case $mysql in
        1)               echo -e "$BCyan------------MariaDB Server Setup Under Process--------------$Color_Off"
            
echo "[mariadb]
name = MariaDB
baseurl = http://yum.mariadb.org/10.5/centos7-amd64
gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
gpgcheck=1
" >  /etc/yum.repos.d/MariaDB.repo

            yum install -y mariadb-server
            sudo systemctl start mariadb
            sudo systemctl enable mariadb
        
            /usr/bin/mysqladmin -u root password $MYSQL_ROOT_PASSWORD
            
            echo -e "$BCyan------------MariaDB Server Setup Completed--------------$Color_Off"
            break;;
            
        2) echo -e "$BCyan------------MySQL 8 Server Setup Under Process--------------$Color_Off"

            rpm -Uvh https://repo.mysql.com/mysql80-community-release-el7-3.noarch.rpm
            sed -i 's/enabled=1/enabled=0/' /etc/yum.repos.d/mysql-community.repo
            rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2022
            yum --enablerepo=mysql80-community install mysql-community-server -y
            systemctl start mysqld.service

            root_temp_pass=$(sudo grep 'A temporary password' /var/log/mysqld.log |tail -1 |awk '{split($0,a,": "); print a[2]}')
            
            
echo "[client]
user=root
password=$MYSQL_ROOT_PASSWORD
"> ~/.my.cnf 
chmod 600 ~/.my.cnf

            # mysql_secure_installation.sql
echo "# Make sure that NOBODY can access the server without a password
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
# Kill the anonymous users
DELETE FROM mysql.user WHERE User='';
# disallow remote login for root
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
# Kill off the demo database
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
# Make our changes take effect
FLUSH PRIVILEGES;
" >  mysql_secure_installation.sql

     
            sudo mysql -uroot -p"$root_temp_pass" --connect-expired-password <mysql_secure_installation.sql

            systemctl enable mysqld.service
            mysql -u root  -e "UNINSTALL COMPONENT 'file://component_validate_password'";

            echo -e "$BCyan Database Password Updated Successfully...... $Color_Off"
            
            echo -e "$BCyan------------MySQL Server Installation Done--------------$Color_Off"
            break;;
            
        3) echo -e "$Color_Off"
                break;;

        *) echo -e "$BYellow Wrong Input ! Please Answer 1 ,2 or 3 $Color_Off" ;;
esac
done

#########
######################################### Webserver ####################################################################

while true; do
   case $web in
        1) echo -e "$BCyan------------------------ Apache Server Setup Under Process-----------------------------------------------------$Color_Off"
        
        yum install -y httpd 
        systemctl start httpd.service
        systemctl enable httpd.service
        echo -e "$BCyan------------------------ Server Installation Successfully Completed-----------------------------------------------------$Color_Off"
        break;;

        2) echo -e "$BCyan------------------------ Nginx Server Setup Under Process-----------------------------------------------------$Color_Off"
        yum install -y nginx
        systemctl start nginx
        sudo systemctl enable nginx
        break;;
        3) echo -e "$Color_Off"
                break;;

        *) echo -e "$BYellow Wrong Input ! Please Answer 1 ,2 or 3 $Color_Off" ;;
    esac
done



######################################### Firewall ########################################

while true; do
#  echo -en "$BGreen Do you want allow Http/Https In Firewall .....Yes/No : $BGreen"
#  read firewall
        case $firewall in
            [yY][eE][sS]|[yY])
                        firewall-cmd --state
                        firewall-cmd --zone=public --permanent --add-service=http
                        firewall-cmd --zone=public --permanent --add-service=https
                        firewall-cmd --zone=public --permanent --add-port=8080/tcp
                        firewall-cmd --zone=public --permanent --add-port=8443/tcp
                        firewall-cmd --reload
                        break;;
            
            [nN][oO]|[nN]) echo -e "$Color_Off"
             break;;
    
            *) echo -e "$BYellow Wrong Input ! Please Answer Yes or No $Color_Off" 
            
    esac
done

##################### CAS ###################################
while true; 
do
# echo -en "$BGreen \n Do You Want Install APEREO CAS  ..... Y/N: $BGreen"
# read cas

case $cas in
        y|Y|yes|Yes|YES) 

# Tomcat
echo -e "$BCyan------------------------------- Installing Tomcat ------------------------$Color_Off"
sleep 1
sudo useradd -m -U -d $TOMCAT_INSTALL_DIR/tomcat -s /bin/false $TOMCAT_USER
sudo chown -R $TOMCAT_USER: $TOMCAT_INSTALL_DIR/tomcat
cd /tmp
wget $TOMCAT_URL 
mkdir -p $TOMCAT_INSTALL_DIR/tomcat 
tar -xf apache-tomcat-$TOMCAT_VER.tar.gz -C $TOMCAT_INSTALL_DIR/tomcat --strip-components 1
rm apache-tomcat-$TOMCAT_VER.tar.gz
sudo chown -R tomcat: $TOMCAT_INSTALL_DIR/tomcat
sudo sh -c 'chmod +x /usr/share/tomcat/bin/*.sh'

echo "[Unit]
Description=Tomcat 9 servlet container
After=network.target

[Service]
Type=forking

User=tomcat
Group=tomcat

Environment="JAVA_HOME=/usr/lib/jvm/java-11-openjdk-11.0.17.0.8-2.el7_9.x86_64"
Environment="JAVA_OPTS=-Djava.security.egd=file:///dev/urandom"

Environment="CATALINA_BASE=$TOMCAT_INSTALL_DIR/tomcat"
Environment="CATALINA_HOME=$TOMCAT_INSTALL_DIR/tomcat"
Environment="CATALINA_PID=$TOMCAT_INSTALL_DIR/tomcat/temp/tomcat.pid"
Environment="CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC"

ExecStart=$TOMCAT_INSTALL_DIR/tomcat/bin/startup.sh
ExecStop=$TOMCAT_INSTALL_DIR/tomcat/bin/shutdown.sh

[Install]
WantedBy=multi-user.target
" > /etc/systemd/system/tomcat.service


###### Install CAS   
echo -e "$BCyan------------------------------- Installing CAS ------------------------------------$Color_Off"
sleep 1
cd $CAS_INSTALL_DIR
git clone "$APEREO_GIT_URL" --branch $APEREO_CAS_VER
sed -i '129i \    implementation "org.apereo.cas:cas-server-support-pac4j-webflow"' cas-overlay-template/build.gradle
sed -i '130i \    implementation "org.apereo.cas:cas-server-support-json-service-registry"' cas-overlay-template/build.gradle
mkdir -p $CAS_HOME/services

######  GOOGLE PAC4J  MENU  #################################################
while true; do

	case $CONFIGURE_GOOGLE in
		[yY][eE][sS]|[yY]) 

         
echo "cas.server.name:$CAS_SERVER_NAME
cas.server.prefix:$CAS_SERVER_PREFIX

cas.authn.accept.users=
logging.config=file:$CAS_HOME/log4j2.xml

cas.view.defaultRedirectUrl=$CAS_REDIRECT_URI

cas.authn.pac4j.google.id=$CAS_AUTHN_PAC4J_GOOGLE_ID
cas.authn.pac4j.google.secret=$CAS_AUTHN_PAC4J_GOOGLE_SECRET
cas.authn.pac4j.google.scope=$CAS_AUTHN_PAC4J_GOOGLE_SCOPE
cas.authn.pac4j.google.principalAttributed=email
cas.serviceRegistry.json.location=$CAS_SERVICEREGISTRY_JSON_LOCATION
" > cas-overlay-template/etc/cas/config/cas.properties
                    break;;
            
            
            
        [nN][oO]|[nN])  
            
echo "cas.server.name:$CAS_SERVER_NAME
cas.server.prefix:$CAS_SERVER_PREFIX

cas.authn.accept.users=
logging.config=file:$CAS_HOME/log4j2.xml

cas.view.defaultRedirectUrl=$CAS_REDIRECT_URI

cas.serviceRegistry.json.location=$CAS_SERVICEREGISTRY_JSON_LOCATION
" > cas-overlay-template/etc/cas/config/cas.properties
            
            break;;
			
            *|"" ) echo -e "$BYellow Please enter yes or no. $BYellow";;
	esac
done



########################

    json=$(jq -n --arg CAS_REDIRECT_URI "^(https)://.*" --arg CAS_SERVICE_NAME "$CAS_SERVICE_NAME" --arg CAS_SERVICE_ID "$CAS_SERVICE_ID" \
               '{"@class" : "org.apereo.cas.services.RegexRegisteredService",
                  serviceId : $CAS_REDIRECT_URI,
                  name : $CAS_SERVICE_NAME,
                  id : $CAS_SERVICE_ID,
                  description : "Guacamole Remote Access Service",
                  evaluationOrder : 1
                }')
          echo "$json" > "$CAS_SERVICE_NAME-$CAS_SERVICE_ID".json

cp "$CAS_SERVICE_NAME-$CAS_SERVICE_ID".json $CAS_HOME/services/
cp cas-overlay-template/etc/cas/config/cas.properties $CAS_PROPERTIES_PATH
cp cas-overlay-template/etc/cas/config/log4j2.xml $CAS_LOG4J2_PATH

echo -e "$BCyan------------------------------- Downloading and configuring CAS $APEREO_CAS_VER ------------------- $Color_Off"
sleep 1   
cd $CAS_INSTALL_DIR/cas-overlay-template
./gradlew clean build

cd .. 
cp $CAS_INSTALL_DIR/cas-overlay-template/build/libs/cas.war /etc/cas/ 
mkdir -p /opt/etc
ln -sf -T /etc/cas /opt/etc/cas
ln -sf -T /etc/cas/cas.war $TOMCAT_INSTALL_DIR/tomcat/webapps/cas.war
ln -sf -T $TOMCAT_INSTALL_DIR/tomcat /opt/tomcat
ln -sf -T /etc/cas "$CAS_INSTALL_PATH"

chown -R $TOMCAT_USER:$TOMCAT_USER /etc/cas    
chown -R $TOMCAT_USER:$TOMCAT_USER $TOMCAT_INSTALL_DIR/tomcat/webapps/


#.5.################# Install Let’s Encrypt with Apache ###########################
 
while true; do
 DIR=/etc/letsencrypt/live/$DOMAIN_NAME 

 
    case $ssl in
            [yY][eE][sS]|[yY])
echo -e "$BCyan------------------------ Installing Let's Encrypt for $DOMAIN_NAME ----------------------$Color_Off"
sleep 2                          


                service httpd stop
                certbot certonly --standalone -n --agree-tos -m "$EMAIL_NAME" -d $DOMAIN_NAME
           
                if [ -d $DIR ]; then
                 cd /etc/letsencrypt/live/$DOMAIN_NAME 
                 cp {cert,chain,privkey}.pem /opt/tomcat/conf/ 
                    sed -i '86i         <Connector port="8443" protocol="org.apache.coyote.http11.Http11NioProtocol" \
                            maxThreads="150" SSLEnabled="true"> \
                        <SSLHostConfig> \
                            <Certificate certificateFile="conf/cert.pem" \
                                certificateKeyFile="conf/privkey.pem" \
                                certificateChainFile="conf/chain.pem" /> \
                        </SSLHostConfig> \
                    </Connector>'  /opt/tomcat/conf/server.xml
                    service httpd start

                 echo -e "$BGreen SSL Installation Successfully Completed $Color_Off"
                 break 1
                              
                else
                 echo -e "$BRed  SSL installation has been failed $Color_Off"
                              
                fi
                 echo -e "$Color_Off" ;;
            
            [nN][oO]|[nN]) echo -e "$Color_Off"
             break;;
    
            *) echo -e "$BYellow Wrong Input ! Please Answer Yes or No $Color_Off" 

      esac 
done

########################  END #####################################################


chown -R $TOMCAT_USER:$TOMCAT_USER /opt/tomcat/
sudo systemctl daemon-reload
sudo systemctl enable tomcat
sudo systemctl start tomcat




break;;



        n|N|no|No|NO) echo -e "$Color_Off"
        break;;
 
        *) echo -e "$BYellow Wrong Input ! Please Answer Yes or No $Color_Off" 
 
esac
done
##################### CAS END ###############################


################################### Summery ##################################


echo -e "$BCyan------------------------------- Server Installation Summary ---------------------------------$Color_Off"
case $web in
        1) 
         echo -e "$BCyan------------------------------- Apache Has been Installed ---------------------------------$Color_Off"
         ;; 
        2)
         echo -e "$BCyan------------------------------- Nginx Has been Installed ---------------------------------$Color_Off"
         ;; 
        3)
         echo -e "$BCyan------------------------------- Webserver Installation Was Canceled ---------------------------------$Color_Off"
         ;; 
esac

case $php in
        1)
         echo -e "$BCyan------------------------------- PHP 7.4 Has been Installed ---------------------------------$Color_Off"
         ;;        
        2)
         echo -e "$BCyan------------------------------- PHP 8.0 Has been Installed ---------------------------------$Color_Off" 
         ;;  
        3)
         echo -e "$BCyan------------------------------- PHP Installation Was Canceled  ---------------------------------$Color_Off"
         ;;                        
esac

case $mysql in
        1)
         echo -e "$BCyan------------------------------- MariaDB 10.5 Has been Installed ---------------------------------$Color_Off"
         ;;
        2)
         echo -e "$BCyan------------------------------- MySQL 8.0 Has been Installed ---------------------------------$Color_Off" 
         ;; 
        3)
         echo -e "$BCyan------------------------------- MySQL Installation Was Canceled ---------------------------------$Color_Off"
        ;;         

esac

case $firewall in
        [yY][eE][sS]|[yY])
         echo -e "$BCyan------------------------------- Allowed Http/Https In Firewall ---------------------------------$Color_Off"
         ;;
        [nN][oO]|[nN])
         echo -e "$BCyan------------------------------- Firewall exit  ---------------------------------$Color_Off" 
         ;;         
esac


case $cas in
        [yY][eE][sS]|[yY])
         echo -e "$BCyan------------------------------- CAS Installation Done ---------------------------------$Color_Off"
         ;;
        [nN][oO]|[nN])
         echo -e "$BCyan------------------------------- CAS Installation Was Canceled  ---------------------------------$Color_Off" 
         ;;         
esac
 
 break;;



        n|N|no|No|NO) echo -e "$BRed The lamp Installation Has Been Canceled $Color_Off"
        exit;;
 
        *) echo -e "$BYellow Wrong Input ! Please Answer Yes or No $Color_Off" 
 
esac
done
