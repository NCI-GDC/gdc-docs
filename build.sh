#!/bin/bash
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
   /venv/bin/mkdocs2pandoc -f ${userGuide}_UG.yml -o docs/${userGuide}/PDF/${userGuide}_UG.pd
   echo "$(date +'%d %B %Y - %k:%M'): ${ENVIRONMENT}: ${userGuide}: Replacing strings in pandoc document "
   /bin/sed -i -e 's/# / /g' docs/${userGuide}/PDF/${userGuide}_UG.pd
   /bin/sed -i -e 's/### /## /g' docs/${userGuide}/PDF/${userGuide}_UG.pd
   /bin/sed -i -e 's/\/site\//\/docs\//g' docs/${userGuide}/PDF/${userGuide}_UG.pd
   /bin/sed -i -e "s/(images/(https:\/\/gdc-docs.nci.nih.gov\/"$userGuide"\/Users_Guide\/images/g" docs/${userGuide}/PDF/${userGuide}_UG.pd #To make images clickable in the PDF
   echo "$(date +'%d %B %Y - %k:%M'): ${ENVIRONMENT}: ${userGuide}: Building PDF from pandoc document "
   /usr/bin/pandoc --listings -H theme/latex/listings-setup.tex --toc -V documentclass=report -V geometry:"top=2cm, bottom=1.5cm, left=1cm, right=1cm" -f markdown+grid_tables+table_captions docs/${userGuide}/PDF/${userGuide}_Title.txt -o docs/${userGuide}/PDF/${userGuide}_UG.pdf docs/${userGuide}/PDF/${userGuide}_UG.pd
done


echo "$(date +'%d %B %Y - %k:%M'): ${ENVIRONMENT}: Build Encyclopedia"
python buildencyclopedia.py


echo "$(date +'%d %B %Y - %k:%M'): ${ENVIRONMENT}: Deploying new version to /app"
/venv/bin/mkdocs build -v --site-dir /app/
