@echo off

set sys=Operating system:
set arch=Architecture:
set copying=Copying flash video files from %USERPROFILE%\AppData\Local\Temp\ to videos\
set tip=After the copying program closes go to the videos\ folder, and view your files using VLC (http://www.videolan.org/vlc/)
set copy=%USERPROFILE%\AppData\Local\Temp\ videos\ fla*.tmp
set pre=hobocopy\Hobocopy-
set suf=-bit.exe

ver | find "XP" > nul
if %ERRORLEVEL% == 0 goto xp

set RegQry=HKLM\Hardware\Description\System\CentralProcessor\0
 
REG.exe Query %RegQry% > checkOS.txt
 
Find /i "x86" < CheckOS.txt > StringCheck.txt
 
if %ERRORLEVEL% == 0 (
	set Bit=32
) else (
	set Bit=64
)

ver | find "2003" > nul
if %ERRORLEVEL% == 0 set os_ver=2003 & goto other

if not exist %SystemRoot%\system32\systeminfo.exe goto undetermined_os_arch_exit

systeminfo | find "OS Name" > %TEMP%\osname.txt
for /F "usebackq delims=: tokens=2" %%i in (%TEMP%\osname.txt) do set vers=%%i

echo %vers% | find "Windows 7" > nul
if %ERRORLEVEL% == 0 set os_ver=7 & goto other

echo %vers% | find "Windows Server 2008" > nul
if %ERRORLEVEL% == 0 set os_ver=Server 2008 & goto other

echo %vers% | find "Windows Vista" > nul
if %ERRORLEVEL% == 0 set os_ver=Vista & goto other

goto undetermined_os_arch_exit

:xp
echo. & echo %sys% Windows XP
echo %arch% 32/64-bit
echo Using Hobocopy-XP-32-bit.exe & echo.
echo %copying% & echo.
echo %tip% & echo.
%pre%XP-32%suf%-bit.exe copy
goto exit

:other
echo. & echo %sys% Windows %os_ver%
echo %arch% %bit%-bit
echo Using HoboCopy-W2K3-Vista-%Bit%-bit.exe & echo.
echo %copying% & echo.
echo %tip% & echo.
%pre%W2K3-Vista-%Bit%%suf% %copy%
goto exit

:undetermined_os_arch_exit
echo Can't determine your OS/architecture.

:exit
pause