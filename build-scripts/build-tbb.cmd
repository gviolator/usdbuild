set CURRENT_DIR=%~dp0
set BUILD_CONFIG=debug
set SRC_DIR=%CURRENT_DIR%..\src
set DIST_DIR=%CURRENT_DIR%..\dist
set TBB_DIR_NAME=tbb-%BUILD_CONFIG%
set TBB_DIST_DIR=%DIST_DIR%\%TBB_DIR_NAME%

call %CURRENT_DIR%env_vc.cmd 17

msbuild %SRC_DIR%\intel-tbb\build\vs2013\tbb.vcxproj -p:Configuration=%BUILD_CONFIG% -p:Platform=x64 /p:PlatformToolset=v143

@if not exist "%TBB_DIST_DIR%" (
	cd %DIST_DIR%
	mkdir "%TBB_DIR_NAME%"
	cd %CURRENT_DIR%
)

@if not exist "%TBB_DIST_DIR%\lib" (
	cd %TBB_DIST_DIR%
	mkdir lib
	cd %CURRENT_DIR%
)

@if not exist "%TBB_DIST_DIR%\bin" (
	cd %TBB_DIST_DIR%
	mkdir bin
	cd %CURRENT_DIR%
)

@if not exist "%TBB_DIST_DIR%\include" (
	cd %TBB_DIST_DIR%
	mklink /D/J include %SRC_DIR%\intel-tbb\include
	cd %CURRENT_DIR%
)

set BUILD_DIR=%SRC_DIR%\intel-tbb\build\vs2013\x64\%BUILD_CONFIG%
set FILE_NAME=tbb_%BUILD_CONFIG%

copy /Y %BUILD_DIR%\%FILE_NAME%.dll %TBB_DIST_DIR%\bin\%FILE_NAME%.dll
copy /Y %BUILD_DIR%\%FILE_NAME%.lib %TBB_DIST_DIR%\lib\%FILE_NAME%.lib
copy /Y %BUILD_DIR%\%FILE_NAME%.pdb %TBB_DIST_DIR%\lib\%FILE_NAME%.pdb
copy /Y %BUILD_DIR%\%FILE_NAME%.exp %TBB_DIST_DIR%\lib\%FILE_NAME%.exp
copy /Y %BUILD_DIR%\%FILE_NAME%.map %TBB_DIST_DIR%\lib\%FILE_NAME%.map
