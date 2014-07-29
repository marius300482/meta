#! /bin/bash

echo "Go to git directory"
pushd `dirname $0`

echo "git pull"
git pull

echo "Delete theme ida"
rm -r /usr/local/vufind2/themes/ida
echo "Delete theme genderbib"
rm -r /usr/local/vufind2/themes/genderbib
echo "Delete module Ida"
rm -r /usr/local/vufind2/module/Ida/
echo "Copy all to vufind"
cp -R meta/vufind/* /usr/local/vufind2/

#echo "Restart Solr"
#pushd $VUFIND_HOME
#./vufind.sh restart
echo "Remember to restart Solr, if schema xml was modified!"

popd
popd
