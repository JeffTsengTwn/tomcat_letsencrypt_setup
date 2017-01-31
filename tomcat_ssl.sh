apt-get update
apt-get upgrade
add-apt-repository ppa:webupd8team/java
apt-get update
apt-get install oracle-java8-installer
apt-get install oracle-java8-set-default
mv tomcat /opt
cd /opt
cd letsencrypt
read -p "Please input your domain name: " domain
read -p "Please input your email:  " mail   
./letsencrypt-auto certonly --standalone -d ${domain} --email mail
cd /etc/letsencrypt/live/${domain}/
read -p "Please input your alias name:  " NAME   
openssl pkcs12 -export -in fullchain.pem -inkey privkey.pem -out pkcs.p12 -name ${NAME}
read -p "Please input your password:  " password
keytool -importkeystore -deststorepass ${password} -destkeypass ${password} -destkeystore keystore.jks -srckeystore pkcs.p12 -srcstoretype PKCS12 -srcstorepass ${password} -alias ${NAME}
sed -i 's/<changeit>/'${password}'/g' /opt/tomcat/conf/server.xml