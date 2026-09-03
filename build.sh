#!/bin/bash
# Generating PDFs from *_UG.yml files.
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
   echo "$(date +'%d %B %Y - %k:%M'): ${ENVIRONMENT}: ${userGuide}: Building PDF documents"
   ENABLE_PDF_EXPORT=1 /venv/bin/mkdocs build -f ${userGuide}_UG.yml
done


echo "$(date +'%d %B %Y - %k:%M'): ${ENVIRONMENT}: Deploying new version to /app"
/venv/bin/mkdocs build -v --site-dir /app/
