#!/bin/bash
 
echo Sync started `date` >> /Volumes/Logs/Sync_log.txt
 
echo "Now starting rsync"
 
rsync -avz --delete "/Volumes/PrimaryWebsite/" --rsh='ssh -p8286' username@XX.18.XX.22:www/domains/SecondaryWebsite
 
echo "Now starting modifications"
 
scp -oPort=8286 "/Volumes/modifications/wp-config.php" username@XX.18.XX.22:www/domains/SecondaryWebsite
 
echo "Now starting database sync"
 
mysqldump --user=primarymysqlusername --password=primarymysqlpassword primarydatabasename | ssh secondarysshusername@XX.18.XX.22 -p8286 mysql --user= secondarymysqlusername --password= secondarymysqlpassword secondarydatabasename
 
echo Sync finished `date` >> /Volumes/Logs/Sync_log.txt