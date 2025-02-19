REM @author: Michal Karm Babacek <karm@fedoraproject.org>
REM This script builds OpenSSL


set WORKSPACE=c:\Tools\HTTPD
set SOURCES=c:\Tools\SOURCES
set MYTARGET="c:/Program Files (x86)/APR"

ver | findstr "10.0" &&  goto new

PATH=C:\perl\bin;C:\Tools\nasm-2.16.03;C:\Tools\cmake-3.22.6-windows-x86_64/bin;%PATH%;C:\Program Files (x86)\Microsoft Visual Studio 11.0\VC\bin\amd64;C:\Windows\Microsoft.NET\Framework64\v4.0.30319

goto next

:new

PATH=%PATH%;C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin;C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build;C:\Program Files\Microsoft Visual Studio\2022\Community\Msbuild\Current\Bin;C:\Program Files\NASM

:next

call vcvars64

cl

cd %SOURCES%\openssl
perl Configure --prefix=%MYTARGET%
nmake
nmake install

REM $Env:HARNESS_VERBOSE = 'yes'
REM  nmake test TESTS=test_quicapi HARNESS_VERBOSE=yes
REM nmake install
