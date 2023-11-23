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

set BUILD_PATH=%BUILD_DIR%\opensubdiv-build

@if not exist "%BUILD_PATH%" (
	cd %BUILD_DIR%
	mkdir opensubdiv-build
	cd %CURRENT_DIR%
)

set TBB_DIR=%DIST_DIR%\tbb-%BUILD_CONFIG%
set INSTALL_PATH=%DIST_DIR%\opensubdiv-%BUILD_CONFIG%

cmake -G"Visual Studio 17 2022" ^
	-DCMAKE_PREFIX_PATH=%TBB_DIR% ^
	-DCMAKE_INSTALL_PREFIX=%INSTALL_PATH% ^
	-DNO_EXAMPLES=1 ^
	-DNO_TUTORIALS=1 ^
	-DNO_REGRESSION=1 ^
	-DNO_PTEX=1 ^
	-DNO_DOC=1 ^
	-DNO_OMP=1 ^
	-DNO_TBB=1 ^
	-DNO_CUDA=1 ^
	-DNO_OPENCL=1 ^
	-DNO_OPENGL=0 ^
	-DNO_CLEW=1 ^
	-B %BUILD_PATH% ^
	-S %SRC_DIR%\opensubdiv
	
	
cmake --build %BUILD_PATH% --config %BUILD_CONFIG% --target install
