#!/bin/bash
termux-setup-storage
echo; echo "  [!] Updating.."
apt-get update &>> .log
echo; echo "  [!] Installing Dependencies.."
echo; echo "     [!] Git"
apt-get install git -y &>> .log
echo; echo "     [!] Ruby"
apt-get install ruby -y &>> .log
echo; echo "     [!] Lolcat"
git clone https://github.com/busyloop/lolcat.git &>> .log
cd lolcat  &>> .log
gem install lolcat &>> .log
cd ../ &>> .log
mv lolcat scripts/ &> /dev/null
echo; echo "     [!] Downloader"
apt-get install wget -y  &>> .log  && wget https://yt-dl.org/latest/youtube-dl -O /bin/youtube-dl &>> .log ||  apt-get install youtube-dl -y &>> .log 
chmod +x /bin/youtube-dl &>> .log
echo; echo "     [!] Converter"
apt-get install ffmpeg -y &>> .log
echo; echo "     [!] Player"
apt-get install sox -y &>> .log
apt-get install sed -y &>> .log
echo; echo "  [!] Checking installation"

for i in gem lolcat git youtube-dl sed ffmpeg ffprobe sox
do 
	which $i  &> /dev/null
	if [[ $? -gt 0 ]]
	then
	echo; echo "     [-] Not found $i"
	fi
done	
