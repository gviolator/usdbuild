set CURRENT_DIR=%~dp0
set PYTHONPATH=%CURRENT_DIR%dist\openusd-debug\lib\python
set PATH=%CURRENT_DIR%dist\openusd-debug\lib;%CURRENT_DIR%dist\boost-debug\lib;%CURRENT_DIR%dist\tbb-debug\bin;%PATH%

python.exe %CURRENT_DIR%dist\openusd-debug\bin\usdview %CURRENT_DIR%sample\sample.usda
