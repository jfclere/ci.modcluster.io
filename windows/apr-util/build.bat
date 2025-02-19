REM @author: Michal Karm Babacek <karm@fedoraproject.org>
REM This script builds apr-util

set WORKSPACE=c:\Tools\HTTPD
set SOURCES=c:\Tools\SOURCES
set MYTARGET="c:\Program Files (x86)"

del /s /f /q %WORKSPACE%\target\64 
del /s /f /q %WORKSPACE%\build-64

mkdir %WORKSPACE%\target\64
mkdir %WORKSPACE%\apr-util\build-64
cd %WORKSPACE%\apr-util\build-64

ver | findstr "10.0" &&  goto new

PATH=C:\Tools\cmake-3.22.6-windows-x86_64/bin;C:\Program Files (x86)\Microsoft Visual Studio 11.0\VC\bin\amd64;C:\Windows\Microsoft.NET\Framework64\v4.0.30319

call vcvars64
cmake -G "Visual Studio 11" ^
-DCMAKE_INSTALL_PREFIX=%MYTARGET%\APR ^
-DEXPAT_INCLUDE_DIR=%MYTARGET%/expat/Source/lib/ ^
-DEXPAT_LIBRARY=%MYTARGET%/expat/Bin/libexpat.lib ^
-DAPR_INCLUDE_DIR=%MYTARGET%/APR/include/ ^
-DAPR_LIBRARIES=%MYTARGET%/APR/lib/libapr-1.lib;%MYTARGET%/APR/lib/libaprapp-1.lib ^
c:\Tools\SOURCES\apr-util

goto next

:new

REM Build environment
PATH=%PATH%;C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin;C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build
call vcvars64


cmake -G "Visual Studio 17 2022" ^
-DCMAKE_INSTALL_PREFIX=%MYTARGET%\APR ^
-DEXPAT_INCLUDE_DIR=%MYTARGET%/expat/include/ ^
-DEXPAT_LIBRARY=%MYTARGET%/expat/lib/libexpat.lib ^
-DAPR_INCLUDE_DIR=%MYTARGET%/APR/include/ ^
-DAPR_LIBRARIES=%MYTARGET%/APR/lib/libapr-1.lib;%MYTARGET%/APR/lib/libaprapp-1.lib ^
c:\Tools\httpd-asf\srclib\apr-util

cd c:\Tools\httpd-asf\srclib\apr-util

:next
MSBuild INSTALL.vcxproj -t:build -p:Configuration=Release
