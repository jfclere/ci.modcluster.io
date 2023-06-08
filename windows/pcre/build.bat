REM @author: Michal Karm Babacek <karm@fedoraproject.org>
REM This script builds pcre

set WORKSPACE=c:\Tools\HTTPD
set SOURCES=c:\Tools\SOURCES
set MYTARGET="c:\Program Files (x86)"


REM Build environment
PATH=%PATH%;C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin;C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build

call vcvars64

mkdir %WORKSPACE%\target
mkdir %WORKSPACE%\build

cd  %WORKSPACE%\build

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

REM -DCMAKE_INSTALL_PREFIX=%WORKSPACEPOSSIX%/target/ ..
REM -DBZIP2_INCLUDE_DIR=%WORKSPACEPOSSIX%/bzip2/include ^
REM -DBZIP2_LIBRARIES=%WORKSPACEPOSSIX%/bzip2/bz2.lib ^
REM -DZLIB_INCLUDE_DIR=%WORKSPACEPOSSIX%/zlib/include ^
REM -DZLIB_LIBRARY=%WORKSPACEPOSSIX%/zlib/lib/zlib.lib ^
REM -DCMAKE_INSTALL_PREFIX=%MYTARGET%/APR %SOURCES/pcre
