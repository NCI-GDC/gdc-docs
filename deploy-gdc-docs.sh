#!/bin/bash
# This script is executed on the server to pull the latest version from git, build PDF and mkdocs.
# Takes the following arguments:
# - dev
# - qa
while [[ $# > 1 ]]
do
key="$1"

case $key in
    -e|--environment)
    ENVIRONMENT="$2"
    shift
    ;;
    --default)
    ENVIRONMENT='dev'
    ;;
    *)

    ;;
esac
shift
done
if [ "$ENVIRONMENT" != "dev" ] && [ "$ENVIRONMENT" != "qa" ]; then
   echo "$(date +'%d %B %Y - %k:%M'): ${ENVIRONMENT}: Incorrect environment, needs to be dev or qa"
   exit;
fi

echo "$(date +'%d %B %Y - %k:%M'): ${ENVIRONMENT}: Building script for ${ENVIRONMENT}"

if [ -d "/home/ubuntu/gdc-docs-${ENVIRONMENT}/" ]; then
   echo "$(date +'%d %B %Y - %k:%M'): ${ENVIRONMENT}: Directory exists, removing"
   sudo rm /home/ubuntu/gdc-docs-${ENVIRONMENT}/ -R
   # wait to avoid error finding a directory
   sleep 10s
   echo "$(date +'%d %B %Y - %k:%M'): ${ENVIRONMENT}: Directory exists, removing"
else
   echo "$(date +'%d %B %Y - %k:%M'): ${ENVIRONMENT}: Directory ~/gdc-docs-${ENVIRONMENT}/ does not exist"
fi
echo "$(date +'%d %B %Y - %k:%M'): ${ENVIRONMENT}: Creating directory and cloning git repo"
mkdir ~/gdc-docs-${ENVIRONMENT}/
git clone git@github.com:NCI-GDC/gdc-docs.git ~/gdc-docs-${ENVIRONMENT}/
cd ~/gdc-docs-${ENVIRONMENT}/

echo "$(date +'%d %B %Y - %k:%M'): ${ENVIRONMENT}: Switching to correct branch"
if [ "$ENVIRONMENT" = "dev" ] ; then
   /usr/bin/git checkout develop
elif [ "$ENVIRONMENT" = "qa" ] ; then
   /usr/bin/git checkout master
else
   exit;
fi

#iconv --verbose -f ascii -t utf-8 -o /tmp/test docs/Data_Portal/PDF/Data_Portal_UG.pd
hasEncodingError=false
echo "$(date +'%d %B %Y - %k:%M'): ${ENVIRONMENT}: Veryfing if all MARKDOWN have no encoding issue"
for scanFile in $( find docs/ | grep md | egrep -v Eliminate ); do
   iconv -f ascii -t utf-8 -o /tmp/test ${scanFile} >> /tmp/${ENVIRONMENT}-buildlog.txt
   if [ "$?" -gt 0 ] ; then
      echo "$(date +'%d %B %Y - %k:%M'): ${ENVIRONMENT}: NOK: ${scanFile} has an encoding error, to address open in vim and use :goto POSITION"
      hasEncodingError=true
   else
      echo "$(date +'%d %B %Y - %k:%M'): ${ENVIRONMENT}: OK: ${scanFile} "
   fi
done

if $hasEncodingError  ; then
   echo "$(date +'%d %B %Y - %k:%M'): ${ENVIRONMENT}: ERROR: Some of the files have encoding errors, not building the site"
   if [ -f /tmp/${ENVIRONMENT}-buildlog.txt ]; then
      echo "$(date +'%d %B %Y - %k:%M'): ${ENVIRONMENT}: Copying log file"
      cp /tmp/${ENVIRONMENT}-buildlog.txt /var/www/gdc-docs-${ENVIRONMENT}.nci.nih.gov/buildlog.txt
   fi
   exit
fi


echo "$(date +'%d %B %Y - %k:%M'): ${ENVIRONMENT}: Looking for User Guides"
userGuides=()
for i in $( ls *_UG.yml ); do
   userGuides+=(${i::${#i}-7})
done
echo "$(date +'%d %B %Y - %k:%M'): ${ENVIRONMENT}: Number of User Guides found: ${#userGuides[@]}"

for userGuide in "${userGuides[@]}"; do
   echo "$(date +'%d %B %Y - %k:%M'): ${ENVIRONMENT}: ${userGuide}: Starting creation"
   if [ ! -d "docs/Data_Portal/PDF/" ]; then
      echo "$(date +'%d %B %Y - %k:%M'): ${ENVIRONMENT}: ${userGuide}: PDF Directory does not exists, creating ..."
      mkdir docs/${userGuide}/PDF/
   fi
   echo "$(date +'%d %B %Y - %k:%M'): ${ENVIRONMENT}: ${userGuide}: Building pandoc document"
   /usr/local/bin/mkdocs2pandoc -f ${userGuide}_UG.yml -o docs/${userGuide}/PDF/${userGuide}_UG.pd
   echo "$(date +'%d %B %Y - %k:%M'): ${ENVIRONMENT}: ${userGuide}: Replacing strings in pandoc document "
   /bin/sed -i -e 's/# / /g' docs/${userGuide}/PDF/${userGuide}_UG.pd
   /bin/sed -i -e 's/### /## /g' docs/${userGuide}/PDF/${userGuide}_UG.pd
   /bin/sed -i -e 's/\/site\//\/docs\//g' docs/${userGuide}/PDF/${userGuide}_UG.pd
   /bin/sed -i -e "s/(images/(https:\/\/gdc-docs.nci.nih.gov\/"$userGuide"\/Users_Guide\/images/g" docs/${userGuide}/PDF/${userGuide}_UG.pd #To make images clickable in the PDF
   echo "$(date +'%d %B %Y - %k:%M'): ${ENVIRONMENT}: ${userGuide}: Building PDF from pandoc document "
   /usr/bin/pandoc --listings -H theme/latex/listings-setup.tex --toc -V documentclass=report -V geometry:"top=2cm, bottom=1.5cm, left=1cm, right=1cm" -f markdown+grid_tables+table_captions docs/${userGuide}/PDF/${userGuide}_Title.txt -o docs/${userGuide}/PDF/${userGuide}_UG.pdf docs/${userGuide}/PDF/${userGuide}_UG.pd
done

echo "$(date +'%d %B %Y - %k:%M'): ${ENVIRONMENT}: Cleaning previous website directory (rm)"
sudo rm /var/www/gdc-docs-${ENVIRONMENT}.nci.nih.gov/* -R
   # wait to avoid error finding a directory
   sleep 10s

echo "$(date +'%d %B %Y - %k:%M'): ${ENVIRONMENT}: Build Encyclopedia"
python buildencyclopedia.py

echo "$(date +'%d %B %Y - %k:%M'): ${ENVIRONMENT}: Deploying new version to /var/www/gdc-docs-${ENVIRONMENT}.nci.nih.gov/"
/usr/local/bin/mkdocs build -v --site-dir /var/www/gdc-docs-${ENVIRONMENT}.nci.nih.gov/

if [ -f /tmp/${ENVIRONMENT}-buildlog.txt ]; then
   echo "$(date +'%d %B %Y - %k:%M'): ${ENVIRONMENT}: Copying log file"
   cp /tmp/${ENVIRONMENT}-buildlog.txt /var/www/gdc-docs-${ENVIRONMENT}.nci.nih.gov/buildlog.txt
fi

sudo chown -R ubuntu:www-data /var/www/gdc-docs-${ENVIRONMENT}.nci.nih.gov
