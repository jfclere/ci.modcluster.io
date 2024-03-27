REM @author: Michal Karm Babacek <karm@fedoraproject.org>
REM This script builds nghttp2

set WORKSPACE=c:\Tools\HTTPD
set SOURCES=c:\Tools\SOURCES
set MYTARGET="c:/Program Files (x86)/APR"

REM Build environment
PATH=%PATH%;C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin;C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build

call vcvars64

del /s /f /q %WORKSPACE%\cmakebuild
mkdir %WORKSPACE%\cmakebuild
pushd %WORKSPACE%\cmakebuild

REM Note that some attributes cannot handle backslashes...
SET WORKSPACEPOSSIX=%WORKSPACE:\=/%

cmake -G "Visual Studio 17 2022" ^
%SOURCES%/nghttp2

cd c:\Tools\HTTPD\cmakebuild
MSBuild ALL_BUILD.vcxproj -t:build -p:Configuration=Release

REM install part
copy lib\Release\* %MYTARGET%\lib
del /s /f /q  %MYTARGET%\include\nghttp2
mkdir  %MYTARGET%\include\nghttp2
copy lib\includes\nghttp2\*  %MYTARGET%\include\nghttp2
copy %SOURCES%\nghttp2\lib\includes\nghttp2\nghttp2.h  %MYTARGET%\include\nghttp2

popd
