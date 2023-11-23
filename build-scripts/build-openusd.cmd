set CURRENT_DIR=%~dp0
set BUILD_CONFIG=debug
set SRC_DIR=%CURRENT_DIR%..\src
set DIST_DIR=%CURRENT_DIR%..\dist
set BUILD_DIR=%CURRENT_DIR%..\build


@if not exist "%BUILD_DIR%" (
	cd ..
	mkdir build
	cd %CURRENT_DIR%
)

set BUILD_PATH=%BUILD_DIR%\openusd-build

@if not exist "%BUILD_PATH%" (
	cd %BUILD_DIR%
	mkdir openusd-build
	cd %CURRENT_DIR%
)



set TBB_PATH=%DIST_DIR%\tbb-%BUILD_CONFIG%
set BOOST_PATH=%DIST_DIR%\boost-%BUILD_CONFIG%
set OPENSUBDIV_PATH=%DIST_DIR%\opensubdiv-%BUILD_CONFIG%
set INSTALL_PATH=%DIST_DIR%\openusd-%BUILD_CONFIG%

cmake -G"Visual Studio 17 2022" ^
	-DCMAKE_CONFIG_TYPES="%BUILD_CONFIG%" ^
	-DTBB_USE_DEBUG_BUILD=ON ^
	-DCMAKE_INSTALL_PREFIX=%INSTALL_PATH% ^
	-DTBB_ROOT_DIR=%TBB_PATH% ^
	-DOPENSUBDIV_ROOT_DIR=%OPENSUBDIV_PATH% ^
	-DCMAKE_PREFIX_PATH=%BOOST_PATH% ^
	-DBOOST_ROOT=%BOOST_PATH% ^
	-DBoost_NO_BOOST_CMAKE=OFF ^
	-B %BUILD_PATH% ^
	-S %SRC_DIR%\openusd
	
	
cmake --build %BUILD_PATH% --config %BUILD_CONFIG% --target install
