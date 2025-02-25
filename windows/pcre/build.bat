REM @author: Michal Karm Babacek <karm@fedoraproject.org>
REM This script builds pcre

set WORKSPACE=c:\Tools\HTTPD
set SOURCES=c:\Tools\SOURCES
set MYTARGET="c:\Program Files (x86)"

del /s /f /q %WORKSPACE%\pcre\target\64 
del /s /f /q %WORKSPACE%\pcre\build-64

mkdir %WORKSPACE%\pcre\build-64
cd  %WORKSPACE%\pcre\build-64

ver | findstr "10.0" &&  goto new

PATH=C:\Tools\cmake-3.22.6-windows-x86_64/bin;C:\Program Files (x86)\Microsoft Visual Studio 11.0\VC\bin\amd64;C:\Windows\Microsoft.NET\Framework64\v4.0.30319

REM SET CL=/std:c17
REM SET CL=/std:clatest (both are ignored...)

call vcvars64
cmake -G "Visual Studio 11" ^
-DBUILD_SHARED_LIBS=ON ^
-DBUILD_STATIC_LIBS=OFF ^
-DPCRE_NEWLINE=ANYCRLF ^
-DPCRE_SUPPORT_JIT=ON ^
-DPCRE_SUPPORT_PCREGREP_JIT=ON ^
-DPCRE_SUPPORT_UTF=ON ^
-DPCRE_SUPPORT_UNICODE_PROPERTIES=ON ^
-DPCRE_SUPPORT_BSR_ANYCRLF=ON ^
-DCMAKE_INSTALL_ALWAYS=1 ^
-DINSTALL_MSVC_PDB=ON ^
-DCMAKE_INSTALL_PREFIX=%MYTARGET%\APR\ ^
%SOURCES%/pcre-8.30

goto next

:new
REM Build environment
PATH=%PATH%;C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin;C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build;C:\Program Files\Microsoft Visual Studio\2022\Community\Msbuild\Current\Bin

call vcvars64


REM Note that some attributes cannot handle backslashes...
REM SET WORKSPACEPOSSIX=%WORKSPACE:\=/%

cmake -G "Visual Studio 17 2022" ^
-DBUILD_SHARED_LIBS=ON ^
-DBUILD_STATIC_LIBS=OFF ^
-DPCRE_NEWLINE=ANYCRLF ^
-DPCRE_SUPPORT_JIT=ON ^
-DPCRE_SUPPORT_PCREGREP_JIT=ON ^
-DPCRE_SUPPORT_UTF=ON ^
-DPCRE_SUPPORT_UNICODE_PROPERTIES=ON ^
-DPCRE_SUPPORT_BSR_ANYCRLF=ON ^
-DCMAKE_INSTALL_ALWAYS=1 ^
-DINSTALL_MSVC_PDB=ON ^
-DCMAKE_INSTALL_PREFIX=%MYTARGET%\APR\ %SOURCES%/pcre

:next
MSBuild INSTALL.vcxproj -t:build -p:Configuration=Release

REM -DCMAKE_INSTALL_PREFIX=%WORKSPACEPOSSIX%/target/ ..
REM -DBZIP2_INCLUDE_DIR=%WORKSPACEPOSSIX%/bzip2/include ^
REM -DBZIP2_LIBRARIES=%WORKSPACEPOSSIX%/bzip2/bz2.lib ^
REM -DZLIB_INCLUDE_DIR=%WORKSPACEPOSSIX%/zlib/include ^
REM -DZLIB_LIBRARY=%WORKSPACEPOSSIX%/zlib/lib/zlib.lib ^
REM -DCMAKE_INSTALL_PREFIX=%MYTARGET%/APR %SOURCES/pcre
