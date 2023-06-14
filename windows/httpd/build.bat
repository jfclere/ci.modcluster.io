REM Build environment

set WORKSPACE=c:\Tools\HTTPD
set SOURCES=c:\Tools\SOURCES
set MYTARGET="c:/Program Files (x86)"

mkdir %WORKSPACE%\target\64
mkdir %WORKSPACE%\build-64

PATH=%PATH%;C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin;C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build;C:\Program Files\Microsoft Visual Studio\2022\Community\Msbuild\Current\Bin

call vcvars64

cd %WORKSPACE%\build-64

REM -DLIBXML2_ICONV_INCLUDE_DIR=%WORKSPACE_POSSIX%/dependencies/libxml2/include/ ^
REM -DLIBXML2_ICONV_LIBRARIES=%WORKSPACE_POSSIX%/dependencies/libxml2/lib/libiconv.lib;%WORKSPACE_POSSIX%/dependencies/libxml2/lib/libcharset.lib ^
REM

REM CMake. Beware: Command must be shorter than 8191 chars...

cmake -G "Visual Studio 17 2022" ^
-DAPR_INCLUDE_DIR=%MYTARGET%/APR/include ^
-DAPR_LIBRARIES=%MYTARGET%/APR/lib/libapr-1.lib;%MYTARGET%/APR/lib/libaprapp-1.lib;%MYTARGET%/APR/lib/apr_ldap-1.lib;%MYTARGET%/APR/lib/libaprutil-1.lib ^
-DCMAKE_INSTALL_PREFIX=%MYTARGET%/APR ^
-DPCRE_CFLAGS=-DHAVE_PCRE2 ^
-DOPENSSL_ROOT_DIR="C:/Program Files/OpenSSL" ^
-DOPENSSL_LIBRARIES="C:/Program Files/OpenSSL/lib" ^
-DOPENSSL_INCLUDE_DIR="C:/Program Files/OpenSSL/include" ^
c:\Tools\httpd-asf

cd c:\Tools\httpd-asf
MSBuild libhttpd.vcxproj -t:build -p:Configuration=Release
MSBuild httpd.vcxproj -t:build -p:Configuration=Release
MSBuild INSTALL.vcxproj -t:build -p:Configuration=Release

REM -DPCRE_LIBRARIES=%MYTARGET%/APR/lib/pcre2-8.lib ^
REM -DPCRE_INCLUDE_DIR=%MYTARGET%/APR/include/ ^

REM -DCMAKE_C_FLAGS_RELWITHDEBINFO="/DWIN32 /D_WINDOWS /W3 /MD /Zi /O2 /Ob1 /DNDEBUG" ^

REM -DCMAKE_C_FLAGS="/DWIN32 /D_WINDOWS /W3 /MD /Zi /O2 /Ob1 /DNDEBUG" ^

REM -DLIBXML2_INCLUDE_DIR=%WORKSPACE_POSSIX%/dependencies/libxml2/include/libxml2/ ^
REM -DLIBXML2_LIBRARIES=%WORKSPACE_POSSIX%/dependencies/libxml2/lib/libxml2.lib;%WORKSPACE_POSSIX%/dependencies/libxml2/lib/libxml2_a.lib;^
REM %WORKSPACE_POSSIX%/dependencies/libxml2/lib/libxml2_a_dll.lib ^
REM -DLIBXML2_XMLLINT_EXECUTABLE=%WORKSPACE_POSSIX%/dependencies/libxml2/bin/xmllint.exe ^
REM -DZLIB_INCLUDE_DIRS=%WORKSPACE_POSSIX%/dependencies/zlib/include/ -DZLIB_LIBRARY=%WORKSPACE_POSSIX%/dependencies/zlib/lib/zlib.lib ^
REM %WORKSPACE_POSSIX%/dependencies/apr-util/lib/apr_crypto_openssl-1.lib;%WORKSPACE_POSSIX%/dependencies/apr-util/lib/apr_dbd_odbc-1.lib;^
REM -DEXTRA_INCLUDES=%WORKSPACE_POSSIX%/dependencies/apr-util/include/ ^
REM -DAPU_HAVE_CRYPTO=ON ^
REM -DAPR_HAS_XLATE=ON ^
REM -DAPR_HAS_LDAP=ON ^
REM -DINSTALL_PDB=ON ^
REM -DPCRE_LIBRARIES=%WORKSPACE_POSSIX%/dependencies/bzip2/bz2.lib;%WORKSPACE_POSSIX%/dependencies/pcre/lib/pcre.lib;^
REM %WORKSPACE_POSSIX%/dependencies/pcre/lib/pcrecpp.lib;%WORKSPACE_POSSIX%/dependencies/pcre/lib/pcreposix.lib ^
REM -DPCRE_INCLUDE_DIR=%WORKSPACE_POSSIX%/dependencies/pcre/include/ -DLUA_LIBRARIES=%WORKSPACE_POSSIX%/dependencies/lua/lib/lua-v5-3-4.lib;^
REM %WORKSPACE_POSSIX%/dependencies/lua/lib/luac.lib -DLUA_INCLUDE_DIR=%WORKSPACE_POSSIX%/dependencies/lua/include/ ^
REM -DNGHTTP2_LIBRARIES=%WORKSPACE_POSSIX%/dependencies/nghttp2/lib/nghttp2.lib -DNGHTTP2_INCLUDE_DIR=%WORKSPACE_POSSIX%/dependencies/nghttp2/include/ ^
REM -DCMAKE_INSTALL_PREFIX=%CMAKE_INSTALL_PREFIX_POSSIX% ..
