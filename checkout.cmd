set CURRENT_DIR=%~dp0
set SRC_DIR=%CURRENT_DIR%src

@if not exist "%SRC_DIR%" (
	cd %CURRENT_DIR%
	mkdir src
)

git clone --depth 1 --branch v2020.3  https://github.com/oneapi-src/oneTBB.git %SRC_DIR%\intel-tbb
git clone --depth 1 --branch release  https://github.com/PixarAnimationStudios/OpenSubdiv.git %SRC_DIR%\opensubdiv
git clone --depth 1 --branch release  https://github.com/PixarAnimationStudios/OpenUSD.git %SRC_DIR%\openusd
