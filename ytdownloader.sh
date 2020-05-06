#!/bin/bash
trap "rm tmp tmp2; clear; echo -e "\033[0m" && exit 0 "  0 1 2 3 9 15 
FPATH=$(pwd)
database=(
[0]="$FPATH/scripts/colors"
[1]="$FPATH/scripts/Banner"
[2]="$FPATH/scripts/videoscript"
#[3]="$FPATH/Videos"
#[4]="$FPATH/Audios"
[6]="$FPATH/scripts/audioscript"
)
prompt=(
[0]="    [>]"
[1]="    [+]"
[2]="    [-]"
)
checkpath()
{
if [[ $FPATH =~ .*\/YT-Downloader$ ]]
then
        for i in  ${database[@]}
        do
        if [[ -f $i  ]]
        then 
                echo "`basename $0`: `basename $i` found" 1> /dev/null
                export START=0
		mkdir $FPATH/Videos $FPATH/Audios &> /dev/null
        else
                echo -e "`basename $0`: `basename $i` not found\n exiting  the script" && sleep 2 && exit 12
        fi
        done

else
        echo $FPATH
        echo "$(basename $0): not in the YT-Downloader directory" 
        exit 1
fi
}
banner()
{       
        which lolcat > /dev/null
        if [[ $? -eq 0 ]]
        then
		clear  
              cat  ${database[1]}  | lolcat
        else
	      clear        
	      cat ${database[1]}
	fi 
}
menu()
{
echo; echo -e "$G     [1] $C Video Download    $G      [2] $C Audio Download          "
echo; echo -e "$G     [0] $C Exit"
echo; echo -ne "$G ${prompt[0]} "
read choice
case $choice in 
	1) . ${database[2]} &&  banner && menuvideo ;;
	2) . ${database[6]} &&  banner && menuaudio;;
	0) echo -e "\033[0m"; clear && exit 0 ;;
	*) echo; echo -e "$R ${prompt[2]} $C Wrong choice enterer " && sleep 0.8 && banner && menu;;
esac
}

########
# MAIN #
########
while :
do
ping -c 1 8.8.8.8 &> /dev/null
	if [[ $? -gt 0 ]]
	then 
		. ${database[0]}
		banner && echo; echo -e "$R ${prompt[2]} $C Network Connection Not Available !!!! " 
		echo; echo -e "$R ${prompt[2]} $C Exiting The Script .. !!!"
		sleep 5 && clear && exit 1
	else
		. ${database[0]} 
		checkpath
		banner
		menu
	fi
rm tmp* &> /dev/null
done

