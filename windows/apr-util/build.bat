REM @author: Michal Karm Babacek <karm@fedoraproject.org>
REM This script builds apr-util

set WORKSPACE=c:\Tools\HTTPD
set SOURCES=c:\Tools\SOURCES
set MYTARGET="c:\Program Files (x86)"


mkdir %WORKSPACE%\target\64
mkdir %WORKSPACE%\build-64

REM Build environment
PATH=%PATH%;C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin;C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build
call vcvars64

cd %WORKSPACE%\build-64

cmake -G "Visual Studio 17 2022" -DCMAKE_INSTALL_PREFIX=%MYTARGET%\APR -DEXPAT_INCLUDE_DIR=%MYTARGET%/expat/include/ -DEXPAT_LIBRARY=%MYTARGET%/expat/lib/libexpat.lib -DAPR_INCLUDE_DIR=%MYTARGET%/APR/include/ -DAPR_LIBRARIES=%MYTARGET%/APR/lib/libapr-1.lib;%MYTARGET%/APR/lib/libaprapp-1.lib c:\Tools\httpd-asf\srclib\apr-util
