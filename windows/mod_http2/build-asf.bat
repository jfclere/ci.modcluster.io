REM @author: Michal Karm Babacek <karm@fedoraproject.org>

REM This script is used to build and package mod_proxy_cluster modules for httpd trunk

set WORKSPACE=c:\Tools\HTTPD
set SOURCES=c:\Tools\SOURCES
set MYTARGET="c:/Program Files (x86)/APR"

PATH=%PATH%;C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin;C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build

call vcvars64

REM CMake workspace
del /s /f /q %WORKSPACE%\cmakebuild
mkdir %WORKSPACE%\cmakebuild
pushd %WORKSPACE%\cmakebuild

SET HTTPD_DEV_HOME_POSSIX=%HTTPD_DEV_HOME:\=/%

cmake -G "Visual Studio 17 2022" ^
-DAPR_LIBRARY=%MYTARGET%/lib/libapr-1.lib ^
-DAPR_INCLUDE_DIR=%MYTARGET%/include/ ^
-DAPACHE_INCLUDE_DIR=%MYTARGET%/include/ ^
-DAPRUTIL_LIBRARY=%MYTARGET%/lib/libaprutil-1.lib ^
-DAPRUTIL_INCLUDE_DIR=%MYTARGET%/include/ ^
-DAPACHE_LIBRARY=%MYTARGET%/lib/libhttpd.lib ^
-DPROXY_LIBRARY=%MYTARGET%/lib/mod_proxy.lib ^
-DNGHTTP2_LIBRARIES=%MYTARGET%/lib/nghttp2.lib ^
%SOURCES%/mod_h2/

cd c:\Tools\HTTPD\cmakebuild
MSBuild ALL_BUILD.vcxproj -t:build -p:Configuration=Release

copy  %WORKSPACE%\cmakebuild\Release\*.so %MYTARGET%\modules\
