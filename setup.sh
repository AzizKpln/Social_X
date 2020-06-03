
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
echo -e "                          Version:1.0" 
echo ${green} ------------------------------------------------------------------

sudo dpkg --add-architecture i386 && sudo apt update -y
sudo apt install libc6-dev -y
sudo apt install gcc-9-base -y
sudo apt install libgcc-9-dev -y
sudo apt install wine -y
sudo apt install wine -y
sudo apt install chromium -y
sudo apt install mono-complete -y
sudo apt install xterm -y
wine Windows/vbs2exe.exe
wget https://www.python.org/ftp/python/2.7.18/python-2.7.18.amd64.msi
wine msiexec /i python-2.7.18.amd64.msi
mkdir python27
mv python-2.7.18.amd64.msi python27/
rm *.msi.1
wine $HOME/.wine/drive_c/Python27/Scripts/pip.exe install pyinstaller
wine $HOME/.wine/drive_c/Python27/Scripts/pip.exe install cryptography
wine $HOME/.wine/drive_c/Python27/Scripts/pip.exe install Fernet
wine $HOME/.wine/drive_c/Python27/Scripts/pip.exe install base64
wine $HOME/.wine/drive_c/Python27/Scripts/pip.exe install shutil
wine $HOME/.wine/drive_c/Python27/Scripts/pip.exe install tempfile
wine $HOME/.wine/drive_c/Python27/Scripts/pip.exe install pyautogui
wine $HOME/.wine/drive_c/Python27/Scripts/pip.exe install scipy
wine $HOME/.wine/drive_c/Python27/Scripts/pip.exe install sounddevice
wine $HOME/.wine/drive_c/Python27/Scripts/pip.exe install pywin32

