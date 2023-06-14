REM @author: Michal Karm Babacek <karm@fedoraproject.org>
REM This script builds OpenSSL


set WORKSPACE=c:\Tools\HTTPD
set SOURCES=c:\Tools\SOURCES
set MYTARGET="c:/Program Files (x86)"

mkdir %WORKSPACE%\target\64
mkdir %WORKSPACE%\openssl\build-64

PATH=%PATH%;C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin;C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build;C:\Program Files\Microsoft Visual Studio\2022\Community\Msbuild\Current\Bin;C:\Program Files\NASM


call vcvars64

cd %SOURCES%\openssl
perl Configure
nmake
nmake test
nmake install
