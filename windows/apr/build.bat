REM @author: Michal Karm Babacek <karm@fedoraproject.org>
REM This script builds apr

set WORKSPACE=c:\Tools\HTTPD
set SOURCES=c:\Tools\SOURCES
set MYTARGET="c:\Program Files (x86)"


mkdir %WORKSPACE%\target\64
mkdir %WORKSPACE%\apr\build-64
cd %WORKSPACE%\apr\build-64

ver | findstr "10.0" &&  goto new

PATH=C:\Tools\cmake-3.22.6-windows-x86_64/bin;C:\Program Files (x86)\Microsoft Visual Studio 11.0\VC\bin\amd64;C:\Windows\Microsoft.NET\Framework64\v4.0.30319

call vcvars64
cmake -G "Visual Studio 11" ^
-DAPU_USE_EXPAT=OFF -DAPU_USE_LIBXML2=ON ^
-DAPR_INSTALL_PRIVATE_H=ON ^
-DCMAKE_INSTALL_PREFIX=%MYTARGET%/APR ^
c:\Tools\SOURCES\apr
goto next

:new

REM Build environment
PATH=%PATH%;C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin;C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build;C:\Program Files\Microsoft Visual Studio\2022\Community\Msbuild\Current\Bin

call vcvars64


cmake -G "Visual Studio 17 2022" ^
-DAPU_USE_EXPAT=OFF -DAPU_USE_LIBXML2=ON ^
-DAPR_INSTALL_PRIVATE_H=ON ^
-DCMAKE_INSTALL_PREFIX=%MYTARGET%/APR ^
c:\Tools\httpd-asf\srclib\apr
cd c:\Tools\httpd-asf\srclib\apr

:next

MSBuild INSTALL.vcxproj -t:build -p:Configuration=Release
