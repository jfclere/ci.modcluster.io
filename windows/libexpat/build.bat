REM @author: Michal Karm Babacek <karm@fedoraproject.org>
REM This script builds libexpat

set WORKSPACE=c:\Tools\HTTPD
set SOURCES=c:\Tools\SOURCES

mkdir %WORKSPACE%\target\64
mkdir %WORKSPACE%\expat\build-64

REM Build environment
PATH=%PATH%;C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin;C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build
call vcvars64

cd %WORKSPACE%\expat\build-64

cmake -G "Visual Studio 17 2022" %SOURCES%\expat
