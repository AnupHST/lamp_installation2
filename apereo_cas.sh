#!/bin/bash
# Bold
Color_Off='\033[0m'       # Text Reset
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

#Tomcat Install
TOMCAT_INSTALL_DIR="/usr/share"
TOMCAT_VER="9.0.68"
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



while true; 
do
echo -en "$BWhite \n Do You Want to Install APEREO CAS  ..... Y/N: $BGreen"
read cas

case $cas in
        y|Y|yes|Yes|YES) 

echo -en "$BGreen Enter a valid hostname or public domain such as mydomain.com : $BYellow"
read DOMAIN_NAME

#DOMAIN_NAME="${DOMAIN_NAME:-$DOMAIN_NAME_DEF}"
# (default ${DOMAIN_NAME_DEF})
# Related with domain name
CAS_SERVER_NAME_DEF="https://$DOMAIN_NAME"
CAS_SERVER_PREFIX_DEF="https://$DOMAIN_NAME/cas"
CAS_AUTHORIZATION_ENDPOINT_DEF="https://$DOMAIN_NAME/cas"
CAS_REDIRECT_URI_DEF="https://$DOMAIN_NAME"
CAS_SERVER_NAME_DEF="https://$DOMAIN_NAME"
CAS_SERVER_PREFIX_DEF="https://$DOMAIN_NAME/cas"
CAS_AUTHORIZATION_ENDPOINT_DEF="https://$DOMAIN_NAME/cas"
CAS_REDIRECT_URI_DEF="https://$DOMAIN_NAME/suitecrm"


############################ Reading Data #############################
echo -en "$BGreen Enter the Apereo CAS server name (default $CAS_SERVER_NAME_DEF) : $BYellow"
read CAS_SERVER_NAME
CAS_SERVER_NAME="${CAS_SERVER_NAME:-$CAS_SERVER_NAME_DEF}"

echo -en "$BGreen Enter the CAS Authorization Endpoint (default $CAS_AUTHORIZATION_ENDPOINT_DEF): $BYellow"
read CAS_AUTHORIZATION_ENDPOINT
CAS_AUTHORIZATION_ENDPOINT="${CAS_AUTHORIZATION_ENDPOINT:-$CAS_AUTHORIZATION_ENDPOINT_DEF}"
        
echo -en "$BGreen Enter the redirect URI for CAS (default $CAS_REDIRECT_URI_DEF): $BYellow"
read CAS_REDIRECT_URI
CAS_REDIRECT_URI="${CAS_REDIRECT_URI:-$CAS_REDIRECT_URI_DEF}"
        
# echo -en "$BGreen Enter the Apereo CAS DB Name (default $CAS_DB_NAME_DEF) : $BYellow"
# read CAS_DB_NAME
# CAS_DB_NAME="${CAS_DB_NAME:-$CAS_DB_NAME_DEF}"
        
# echo -en "$BGreen Enter the Apereo CAS DB UserName (default $CAS_DB_USER_DEF) : $BYellow"
# read CAS_DB_USER
# CAS_DB_USER="${CAS_DB_USER:-$CAS_DB_USER_DEF}"

# echo -n "$BGreen Enter the CAS DB Password (default cas_password) : $BYellow"
# read CAS_DB_PASSWORD
# CAS_DB_PASSWORD="${CAS_DB_PASSWORD:-$CAS_DB_PASSWORD_DEF}"
        
echo -en "$BGreen Enter the Apereo CAS Prefix Key (default $CAS_PREFIX_KEY_DEF) : $BYellow"
read CAS_PREFIX_KEY
CAS_PREFIX_KEY="${CAS_PREFIX_KEY:-$CAS_PREFIX_KEY_DEF}"
        
echo -en "$BGreen Enter the Apereo CAS Prefix (default $CAS_PREFIX_DEF) : $BYellow"
read CAS_PREFIX
CAS_PREFIX="${CAS_PREFIX:-$CAS_PREFIX_DEF}"
        
echo -en "$BGreen Enter the Apereo CAS Install PATH (default $CAS_INSTALL_PATH_DEF) : $BYellow"
read CAS_INSTALL_PATH
CAS_INSTALL_PATH="${CAS_INSTALL_PATH:-$CAS_INSTALL_PATH_DEF}"
        
echo -en "$BGreen Enter the Apereo CAS Properties path (default $CAS_PROPERTIES_PATH_DEF) : $BYellow"
read CAS_PROPERTIES_PATH
CAS_PROPERTIES_PATH="${CAS_PROPERTIES_PATH:-$CAS_PROPERTIES_PATH_DEF}"
        
echo -en "$BGreen Enter the Apereo CAS log4j2 properties path (default $CAS_LOG4J2_PATH_DEF) : $BYellow"
read CAS_LOG4J2_PATH
CAS_LOG4J2_PATH="${CAS_LOG4J2_PATH:-$CAS_LOG4J2_PATH_DEF}"
        
        
echo -en "$BGreen Enter the Apereo CAS server prefix (default $CAS_SERVER_PREFIX_DEF) : $BYellow"
read CAS_SERVER_PREFIX
CAS_SERVER_PREFIX="${CAS_SERVER_PREFIX:-$CAS_SERVER_PREFIX_DEF}"
        
echo -en "$BGreen Enter the Apereo CAS Service registry location (default $CAS_SERVICEREGISTRY_JSON_LOCATION_DEF) : $BYellow"
read CAS_SERVICEREGISTRY_JSON_LOCATION
CAS_SERVICEREGISTRY_JSON_LOCATION="${CAS_SERVICEREGISTRY_JSON_LOCATION:-$CAS_SERVICEREGISTRY_JSON_LOCATION_DEF}"
        
echo -en "$BGreen Enter the Apereo CAS service name (default $CAS_SERVICE_NAME_DEF) : $BYellow"
read CAS_SERVICE_NAME
CAS_SERVICE_NAME="${CAS_SERVICE_NAME:-$CAS_SERVICE_NAME_DEF}"
        
echo -en "$BGreen Enter the Apereo CAS service ID (default $CAS_SERVICE_ID_DEF) : $BYellow"
read CAS_SERVICE_ID
CAS_SERVICE_ID="${CAS_SERVICE_ID:-$CAS_SERVICE_ID_DEF}"

######
# Install Java
echo -e "$BCyan------------------------------- Updating ---------------------------------$Color_Off"
sleep 1
yum update -y
yum -y install git wget vim 
yum install epel-release -y
yum install -y cairo-devel ffmpeg-devel freerdp-devel freerdp-plugins gcc gnu-free-mono-fonts libjpeg-turbo-devel libjpeg-turbo-official libpng-devel libssh2-devel libtelnet-devel libvncserver-devel libgcrypt-devel libvorbis-devel libwebp-devel libwebsockets-devel policycoreutils-python pulseaudio-libs-devel setroubleshoot uuid-devel nano mlocate net-tools wget telnet mlocate policycoreutils-python autoconf automake git libtool jq #java-11-openjdk-11.0.17.0.8-1.el7_9 java-11-openjdk-devel-11.0.17.0.8-1.el7_9


echo -e "$BCyan------------------------------- Installing JAVA --------------------------$Color_Off"
sleep 1
sudo yum install java-11-openjdk-devel -y


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
 echo -en "$BGreen Do you want to configure CAS with GOOGLE Credentials (yes/no): $BYellow"
 read CONFIGURE_GOOGLE
	case $CONFIGURE_GOOGLE in
		[yY][eE][sS]|[yY]) 

         echo -en "$BGreen Enter the PAC4J Google ID (default $CAS_AUTHN_PAC4J_GOOGLE_ID_DEF) : $BYellow"
         read CAS_AUTHN_PAC4J_GOOGLE_ID
         CAS_AUTHN_PAC4J_GOOGLE_ID="${CAS_AUTHN_PAC4J_GOOGLE_ID:-$CAS_AUTHN_PAC4J_GOOGLE_ID_DEF}"

         echo -en "$BGreen Enter the PAC4J Google Secret (default $CAS_AUTHN_PAC4J_GOOGLE_SECRET_DEF) : $BYellow"
         read CAS_AUTHN_PAC4J_GOOGLE_SECRET
         CAS_AUTHN_PAC4J_GOOGLE_SECRET="${CAS_AUTHN_PAC4J_GOOGLE_SECRET:-$CAS_AUTHN_PAC4J_GOOGLE_SECRET_DEF}"

         echo -en "$BGreen Enter the PAC4J Google Scope (default $CAS_AUTHN_PAC4J_GOOGLE_SCOPE_DEF) : $BYellow"
         read CAS_AUTHN_PAC4J_GOOGLE_SCOPE
         CAS_AUTHN_PAC4J_GOOGLE_SCOPE="${CAS_AUTHN_PAC4J_GOOGLE_SCOPE:-$CAS_AUTHN_PAC4J_GOOGLE_SCOPE_DEF}"
			
echo "cas.server.name:$CAS_SERVER_NAME
cas.server.prefix:$CAS_SERVER_PREFIX

cas.authn.accept.users=
logging.config=file:$CAS_HOME/log4j2.xml

cas.view.defaultRedirectUrl=$CAS_REDIRECT_URI

cas.authn.pac4j.google.id=$CAS_AUTHN_PAC4J_GOOGLE_ID
cas.authn.pac4j.google.secret=$CAS_AUTHN_PAC4J_GOOGLE_SECRET
cas.authn.pac4j.google.scope=$CAS_AUTHN_PAC4J_GOOGLE_SCOPE

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
ln -sf -T /etc/cas/cas.war $TOMCAT_INSTALL_DIR/tomcat/webapps/cas.war
ln -sf -T $TOMCAT_INSTALL_DIR/tomcat /opt/tomcat
chown -R $TOMCAT_USER:$TOMCAT_USER /etc/cas    
chown -R $TOMCAT_USER:$TOMCAT_USER $TOMCAT_INSTALL_DIR/tomcat/webapps/


#.5.################# Install Let???s Encrypt with Apache ###########################
 
while true; do
 DIR=/etc/letsencrypt/live/$DOMAIN_NAME 
 echo -en "$BWhite Do you want to install SSL ? Yes or No ...: $BGreen"
 read ssl
 
    case $ssl in
            [yY][eE][sS]|[yY])
echo -e "$BCyan------------------------ Installing Let's Encrypt for $DOMAIN_NAME ----------------------$Color_Off"
sleep 2                          
    # echo -en "$BWhite Enter a valid e-mail for let's encrypt certificate: $BYellow"
	# read EMAIL_NAME

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


# echo -en "$BWhite The Server will be available at https://$DOMAIN_NAME:8080/cas"
# echo -e "$BWhite Enter ???casuser??? as the username and ???Mellon??? as the password. $Color_Off"

break;;



        n|N|no|No|NO) echo -e "$Color_Off"
        break;;
 
        *) echo -e "$BYellow Wrong Input ! Please Answer Yes or No $Color_Off" 
 
esac
done
