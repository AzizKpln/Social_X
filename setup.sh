
lightblue=`tput setaf 14` 
green=`tput setaf 46`     
RED=`tput setaf 196`      
yellow=`tput setaf 11`    
purple=`tput setaf 129`   
reset=`tput sgr0` 
clear
echo ${green}
figlet Social_X -f banner/larry3d.flf 
echo ${green} ------------------------------------------------------------------
echo -e "                         By:Aziz Kaplan" 
echo -e "                          Version:2.0" 
echo ${green} ------------------------------------------------------------------

sudo dpkg --add-architecture i386 && sudo apt update -y
sudo apt install xterm -y
sudo apt install libc6-dev -y
sudo apt install gcc-9-base -y
sudo apt install libgcc-9-dev -y
sudo apt install libgcc-8-dev -y 
sudo apt install libc6-dev -y
sudo apt install wine -y
sudo apt install wine64 -y
sudo apt install figlet -y
sudo apt install chromium -y
sudo apt install mono-complete -y
sudo apt install xterm -y
sudo apt install python3 -y
sudo apt install python3-pip -y
sudo pip3 install -r requirements.txt
wine Windows/vbs2exe.exe
wget https://www.python.org/ftp/python/3.6.0/python-3.6.0.exe
sudo wine python-3.6.0.exe
rm python-3.6.0.exe
wget https://netix.dl.sourceforge.net/project/orwelldevcpp/Setup%20Releases/Dev-Cpp%205.11%20TDM-GCC%204.9.2%20Setup.exe
wine Dev-Cpp*.exe
rm Dev-Cpp*.exe
wget https://github.com/electron/rcedit/releases/download/v1.1.1/rcedit-x64.exe
mkdir RCedit && cp rcedit-x64.exe RCedit/ && rm rcedit-x64.exe
mkdir SOCIALX_BACKDOOR
mkdir CppCodes
mkdir Metasploit
mkdir wsgi_sw/Upload_Server/images
wget https://github.com/upx/upx/releases/download/v3.96/upx-3.96-win32.zip
unzip upx-3.96-win32.zip
rm -r *.zip

wine $HOME'/.wine/drive_c/users/'$(whoami)'/Local Settings/Application Data/Programs/Python/Python36-32/python.exe' -m pip install --upgrade pip
wine $HOME'/.wine/drive_c/users/'$(whoami)'/Local Settings/Application Data/Programs/Python/Python36-32/Scripts/pip.exe' install pyinstaller
wine $HOME'/.wine/drive_c/users/'$(whoami)'/Local Settings/Application Data/Programs/Python/Python36-32/Scripts/pip.exe' install pyautogui
