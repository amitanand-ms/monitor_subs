#!/bin/bash
read -p "This script is to perform maintainance activities to your Azure Account. Press Y to continue you may need to sign in to your accoutnt. Or press any other key to Exit " c
if [ "$c" == "y" ]  || [ "$c" == 'Y' ] 
then 

#az login
loop=1
az account list | grep -A 5 -i cloudname  | grep "\"name\":" | cut -d "\"" -f 4 > /tmp/subslist.txt
az account list | grep -A 5 -i cloudname  | grep "\"id\":" | cut -d "\"" -f 4 > /tmp/subidlist.txt
while [ $loop == 1 ]
do
clear
totalsub=`cat /tmp/subslist.txt | wc -l`
start
echo "Total Subs" $totalsub
echo "===========Subscriptions in your account======================="
cat -n /tmp/subslist.txt
echo 
echo

read -p "Enter the number of subscription you want to get details for or q to quit     " snum
if [ "$snum" == "q" ] || [ "$snum" == "Q" ]
then 
loop=0
rm /tmp/subslist.txt
rm /tmp/subidlist.txt
exit
fi
if [ $snum -lt  1 ] || [ $snum -gt $totalsub ]
then
read -p  "Invalid entry please enter any key to proceed" p
else
reqsub=`head -n $snum /tmp/subidlist.txt | tail -n 1`
clear
az resource list --subscription $reqsub --o table
read -p  "Press any key to go back or q to quit    " snum
if [ "$snum" == "q" ] || [ "$snum" == "Q" ]
then
loop=0
rm /tmp/subslist.txt
rm /tmp/subidlist.txt
fi
fi
done

else
exit
fi
