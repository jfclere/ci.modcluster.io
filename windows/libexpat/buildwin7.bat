REM @author: Michal Karm Babacek <karm@fedoraproject.org>
REM This script builds libexpat
REM trying https://github.com/libexpat/libexpat/tree/R_2_2_0

set WORKSPACE=c:\Tools\HTTPD
set SOURCES=c:\Tools\SOURCES
set MYTARGET="c:/Program Files (x86)"

del /s /f /q %WORKSPACE%\expat\build-64

mkdir %WORKSPACE%\expat\build-64

REM Build environment
PATH=C:\Tools\cmake-3.22.6-windows-x86_64/bin;c:\cmsc\msvc\bin;%PATH%;C:\Program Files (x86)\Microsoft Visual Studio 11.0\VC\bin\amd64;C:\Windows\Microsoft.NET\Framework64\v4.0.30319

call vcvars64
cd %WORKSPACE%\expat\build-64
cmake -G "NMake Makefiles" ^
-DCMAKE_INSTALL_PREFIX=%MYTARGET%/APR ^
-DBUILD_tests=false ^
%SOURCES%\libexpat\expat
nmake
nmake install
