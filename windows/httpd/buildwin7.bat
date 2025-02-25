REM Build environment

set WORKSPACE=c:\Tools\HTTPD
set SOURCES=c:\Tools\SOURCES
set MYTARGET="c:/Program Files (x86)"

del /s /f /q %WORKSPACE%\target\64 
del /s /f /q %WORKSPACE%\build-64


mkdir %WORKSPACE%\target\64
mkdir %WORKSPACE%\build-64

cd %WORKSPACE%\build-64

if not "x%PATH:Studio=%"=="x%PATH%" (
  echo "Yes"
  goto next
) else (
  echo "No"
)

REM C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin
REM C:\Tools\VS\2017b\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin
REM PATH=%PATH%;C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin;C:\Tools\VS\2017b\VC\Auxiliary\Build;C:\Tools\VS\2017b\MSBuild\15.0\Bin
REM cmake-3.31.5-windows-x86_64/bin
PATH=C:\Tools\cmake-3.22.6-windows-x86_64/bin;%PATH%;C:\Program Files (x86)\Microsoft Visual Studio 11.0\VC\bin\amd64;C:\Windows\Microsoft.NET\Framework64\v4.0.30319

call vcvars64

:next


REM CMake. Beware: Command must be shorter than 8191 chars...
REM -DAPR_HAS_XLATE=ON ^
REM cmake --trace-expand -G "Visual Studio 15 2017 Win64" ^
REM -DPCRE_CFLAGS=-DHAVE_PCRE2 ^

REM cmake -G "Visual Studio 11" ^
cmake -G "NMake Makefiles" ^
-DAPR_INCLUDE_DIR=%MYTARGET%/APR/include ^
-DAPR_LIBRARIES=%MYTARGET%/APR/lib/libapr-1.lib;%MYTARGET%/APR/lib/libaprapp-1.lib;%MYTARGET%/APR/lib/apr_ldap-1.lib;%MYTARGET%/APR/lib/libaprutil-1.lib ^
-DCMAKE_INSTALL_PREFIX=%MYTARGET%/APR ^
-DCMAKE_LIBRARY_PATH_FLAG="C:/Program Files (x86)/APR/bin" ^
-DOPENSSL_LIBRARIES="C:/Program Files (x86)/APR/lib/libssl.lib;C:/Program Files (x86)/APR/lib/libcrypto.lib" ^
-DOPENSSL_INCLUDE_DIR="C:/Program Files (x86)/APR/include" ^
c:\Tools\SOURCES\httpd

MSBuild libhttpd.vcxproj -t:build -p:Configuration=Release
MSBuild httpd.vcxproj -t:build -p:Configuration=Release
MSBuild INSTALL.vcxproj -t:build -p:Configuration=Release

echo "Done!"
