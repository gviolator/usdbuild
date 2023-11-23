pip install PySide6 PyOpenGL Jinja2 Argparse

set DIR=%~dp0build-scripts
set DIST_DIR=%~dp0\dist
@if not exist "%DIST_DIR%" (
	echo Create 'dist' directory
	cd %~dp0
	mkdir dist
)

cd %DIR%

pushd "%DIR%"
call env_vc.cmd 17
popd

pushd "%DIR%"
call build-tbb.cmd
popd

pushd "%DIR%"
call build-boost.cmd
popd

pushd "%DIR%"
call build-opensubdiv.cmd
popd

pushd "%DIR%"
call build-openusd.cmd
popd
