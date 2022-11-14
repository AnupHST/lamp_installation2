#!/bin/bash
#!/bin/sh
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


################################### Check if running as root  
 if [ "$(id -u)" != "0" ]; then  
   echo -e "$BRed This script must be run as root $Color_Off" 1>&2  
   exit 1  
 fi  


###################################### web server ##################################
while true; do
        echo -e "$BCyan------------------------ Please Choose Webserver ----------------------------$Color_Off"
        echo -e "$BCyan------------------------ We Recommend Apache --------------------------------$Color_Off"
        echo -en "$BWhite       1. Apache       2. Ngnix     3.Cancel :$BYellow"
        read web
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
        echo -en "$BWhite       1. PHP 7.4      2. PHP 8.0       3. Cancel : $BYellow"
        read php
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
        echo -en "$BWhite       1. MariaDB 10.5     2. MySQL 8.0   3.Cancel: $BYellow"
        read mysql
        
    
    case $mysql in
        1) echo -en "$BWhite Please Set MySQL Root Password $BGreen(Default Pass: $MYSQL_PASSWD_DEF):$BYellow"
        read MYSQL_ROOT_PASSWORD
        MYSQL_ROOT_PASSWORD="${MYSQL_ROOT_PASSWORD:-$MYSQL_PASSWD_DEF}"

        break;;
        2) echo -en "$BWhite Please Set MySQL Root Password $BGreen(Default Pass: $MYSQL_PASSWD_DEF):$BYellow"
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
        echo -en "$BWhite Do you want allow Http/Https In Firewall .....Yes/No : $BYellow"
        read firewall
        case $firewall in
        [yY][eE][sS]|[yY]) break;;
        [nN][oO]|[nN])  break;;
        *) echo -e "$BYellow Wrong Input ! Please Answer Yes or No $Color_Off" 
    esac
done



while true; 
do
echo -en "$BCyan Would you like to proceed to setting up the Lamp     Yes/No: $BYellow"
read lamp

case $lamp in
        y|Y|yes|Yes|YES)
################################## Instaling Package ##################################
echo -e "$BCyan------------------------ Downloading and Installing HRN_LAMP (Official installer) ----------------------------$Color_Off"
sleep 1
yum update -y 
yum install wget vim zip unzip -y
yum install epel-release -y
yum install certbot python2-certbot-apache mod_ssl -y
# Setup automatic cert renewal

systemctl enable certbot-renew.service
systemctl enable certbot-renew.timer
systemctl start certbot-renew.service
systemctl start certbot-renew.timer
systemctl list-timers --all | grep certbot

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
            
echo "# MariaDB 10.5 CentOS repository list - created 2022-10-25 12:13 UTC
# https://mariadb.org/download/
[mariadb]
name = MariaDB
baseurl = https://mirrors.aliyun.com/mariadb/yum/10.5/centos7-amd64
gpgkey=https://mirrors.aliyun.com/mariadb/yum/RPM-GPG-KEY-MariaDB
gpgcheck=1
" > /etc/yum.repos.d/MariaDB.repo

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
#  echo -en "$BWhite Do you want allow Http/Https In Firewall .....Yes/No : $BGreen"
#  read firewall
        case $firewall in
            [yY][eE][sS]|[yY])
                        firewall-cmd --state
                        firewall-cmd --zone=public --permanent --add-service=http
                        firewall-cmd --zone=public --permanent --add-service=https
                        firewall-cmd --reload
                        break;;
            
            [nN][oO]|[nN]) echo -e "$Color_Off"
             break;;
    
            *) echo -e "$BYellow Wrong Input ! Please Answer Yes or No $Color_Off" 
            
    esac
done

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
 
 break;;



        n|N|no|No|NO) echo -e "$BRed The lamp Installation Has Been Canceled $Color_Off"
        exit;;
 
        *) echo -e "$BYellow Wrong Input ! Please Answer Yes or No $Color_Off" 
 
esac
done
