#!/bin/sh

# mise a jour / si necessaire / de mon IP Dynamique de connexion

FILE_IPBOX="/var/tmp/myip-livebox.txt"

# le fichier n'existe pas encore (boot, etc.)
if test -f $FILE_IPBOX
 then
  PREV_IPBOX=`cat $FILE_IPBOX`
 else
  PREV_IPBOX="0.0.0.0"
 fi

# obtenir l'IP de sortie derriere un reseau avec NAT sans access au routeur...
while true ; do
  IPBOX=`wget -O - -q -4 https://www.bookmyname.com/my-ip-address`

  if [ $IPBOX != $PREV_IPBOX ]
  then

    echo `date +"%Y-%m-%d% %H:%M:%S %A"`
    echo "update my ip $IPBOX"

    wget -q -O/dev/null 'https://MP4838-FREE:PGOiml9489@www.bookmyname.com/dyndns/?hostname=chezmoi.countermatt.net&myip='$IPBOX


    # wget exit code 0 => No problems occurred.
    if [ $? -eq 0 ]
    then
      echo $IPBOX > $FILE_IPBOX
      echo "update done"

    fi
  fi
  sleep 5m
done
exit 0
