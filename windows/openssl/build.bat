REM @author: Michal Karm Babacek <karm@fedoraproject.org>
REM This script builds OpenSSL


set WORKSPACE=c:\Tools\HTTPD
set SOURCES=c:\Tools\SOURCES
set MYTARGET="c:/Program Files (x86)/APR"

PATH=%PATH%;C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin;C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build;C:\Program Files\Microsoft Visual Studio\2022\Community\Msbuild\Current\Bin;C:\Program Files\NASM


call vcvars64

cd %SOURCES%\openssl
perl Configure --prefix=%MYTARGET%
nmake
nmake install

# $Env:HARNESS_VERBOSE = 'yes'
# nmake test TESTS=test_quicapi HARNESS_VERBOSE=yes
# REM nmake install
