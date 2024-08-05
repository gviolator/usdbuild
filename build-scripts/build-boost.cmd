set CURRENT_DIR=%~dp0
pushd "%CURRENT_DIR%"

set SRC_PATH=%CURRENT_DIR%..\src

set BUILD_CONFIG=debug
rem set BUILD_CONFIG=release

set BOOST_DIST_PATH=%CURRENT_DIR%..\dist\boost-%BUILD_CONFIG%


cd %SRC_PATH%\boost

bootstrap.bat && b2.exe install --prefix=%BOOST_DIST_PATH% --with-python toolset=msvc variant=%BUILD_CONFIG% link=shared runtime-link=shared threading=multi address-model=64 architecture=x86

popd
