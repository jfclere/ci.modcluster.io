REM Build environment

set WORKSPACE=c:\Tools\HTTPD
set SOURCES=c:\Tools\SOURCES
set MYTARGET="c:/Program Files (x86)"

del /s /f /q %WORKSPACE%\target\64 
del /s /f /q %WORKSPACE%\build-64


mkdir %WORKSPACE%\target\64
mkdir %WORKSPACE%\build-64

if not "x%PATH:CMake=%"=="x%PATH%" (
  echo "Yes"
  goto next
) else (
  echo "No"
)

REM C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin
REM C:\Tools\VS\2017b\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin
PATH=%PATH%;C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin;C:\Tools\VS\2017b\VC\Auxiliary\Build;C:\Tools\VS\2017b\MSBuild\15.0\Bin

call vcvars64

:next

cd %WORKSPACE%\build-64

REM CMake. Beware: Command must be shorter than 8191 chars...
REM -DAPR_HAS_XLATE=ON ^
REM cmake --trace-expand -G "Visual Studio 15 2017 Win64" ^

SET CL=/D _WIN32_WINNT=0x0601 /D WINVER=0x0601

cmake -G "Visual Studio 15 2017 Win64" ^
-DAPR_INCLUDE_DIR=%MYTARGET%/APR/include ^
-DAPR_LIBRARIES=%MYTARGET%/APR/lib/libapr-1.lib;%MYTARGET%/APR/lib/libaprapp-1.lib;%MYTARGET%/APR/lib/apr_ldap-1.lib;%MYTARGET%/APR/lib/libaprutil-1.lib ^
-DCMAKE_INSTALL_PREFIX=%MYTARGET%/APR ^
-DPCRE_CFLAGS=-DHAVE_PCRE2 ^
-DCMAKE_LIBRARY_PATH_FLAG="C:/Program Files/OpenSSL/bin" ^
-DOPENSSL_LIBRARIES="C:/Program Files/OpenSSL/lib/libssl.lib;C:/Program Files/OpenSSL/lib/libcrypto.lib" ^
-DOPENSSL_INCLUDE_DIR="C:/Program Files/OpenSSL/include" ^
c:\Tools\SOURCES\httpd

MSBuild libhttpd.vcxproj -t:build -p:Configuration=Release
MSBuild httpd.vcxproj -t:build -p:Configuration=Release
MSBuild INSTALL.vcxproj -t:build -p:Configuration=Release

echo "Done!"
