#! /bin/bash

echo "Go to git directory"
pushd `dirname $0`/meta/meta-upload

echo "git pull"
git pull

echo "Build package"
mvn clean package
[ $? -ne 0 ] && exit

echo "Stop tomcat, requires sudo"
sudo service tomcat7 stop

echo "Backup old war"
mv /var/lib/tomcat7/webapps/meta-upload.war /var/lib/tomcat7/webapps/meta-upload.war.`date +%Y%m%d-%H%M%S`

echo "Delete old webapp"
sudo rm -r /var/lib/tomcat7/webapps/meta-upload
sudo rm -r /var/lib/tomcat7/work/Catalina/localhost/meta-upload

echo "Deploy package"
cp target/meta-upload-*.war /var/lib/tomcat7/webapps/meta-upload.war

echo "Start tomcat"
sudo service tomcat7 start

popd
