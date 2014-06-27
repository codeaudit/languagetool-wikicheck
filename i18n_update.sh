#!/bin/sh
# Download latest website translations from Transifex and copy them over the existing local files.

# Transifex username and password
USERNAME=dnaber
PASSWORD=`cat ~/.transifex_password`

rm -I i18n-temp
mkdir i18n-temp
cd i18n-temp

# list of languages in the same order as on https://www.transifex.com/projects/p/languagetool/:
for lang in ast be br ca zh da nl eo fr gl de el_GR it pl ru sl es tl uk ro sk cs sv is lt km pt_PT pt_BR
do
  SOURCE=downloaded.tmp
  curl --user $USERNAME:$PASSWORD http://www.transifex.net/api/2/project/languagetool/resource/wikicheck/translation/$lang/?file >$SOURCE
  localLang=$lang
  if [ $lang = 'pt_PT' ]; then
    # special case: if this is named pt_PT it never becomes active because we use "lang=xx" links
    # in the web app that don't contain the country code:
    localLang=pt
  fi
  TARGET="../grails-app/i18n/messages_${localLang}.properties"
  # ignore new strings not translated yet (Transifex adds them, but commented out):
  modified_lines=`diff $TARGET $SOURCE | grep "^[<>]" | grep "^[<>] [a-zA-Z]"|wc -l`
  if [ $modified_lines -ne "0" ]; then
    echo "Moving $SOURCE to $TARGET ($modified_lines lines modified)"
    mv $SOURCE $TARGET
  else
    echo "No real modification in $lang"
    rm $SOURCE
  fi
done

cd ..
rm -r i18n-temp
