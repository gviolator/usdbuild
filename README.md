# Build OpenUSD
# Prerequisites
* Python: 3.10 (tested with 3.10.11), 3.11 (tested), 3.12 (not tested)  (**developer libraries are required !!!**)
* cmake (tested with 3.27.7, but most likely anyone with a version older than 3.20 will suffice)
* Visual Studio 2022 (with v143 build toolset)

**!!! IMPORTANT !!!**
Currently cmake and python expected to be accessible through **PATH** environment variable ! 


## Getting libraries sources

Dependencies:
* Intel-TBB: https://github.com/oneapi-src/oneTBB
* Boost: https://www.boost.org/users/download/ (must be downloaded manually)
* OpenSubdiv: https://github.com/PixarAnimationStudios/OpenSubdiv
* OpenUSD: https://github.com/PixarAnimationStudios/OpenUSD

Clone and checkout git's repos:
```cmd
.\checkout.cmd
```
It will download (and checkout with proper tag/branch) Intel's TBB, OpenSubdiv and OpenUSD libraries.
Next, prepare boost:

1. download boost's sources: [link to boost sources](https://www.boost.org/users/download/).
2. extract sources at ./src/
3. rename directory to just 'boost' (without version).

**NOTICES about ~~not~~ cool** :(  **boost**:  *from time to time it stops configuring: what worked yesterday may stop today. Most likely the problem is in the update of visual studio, or rather in the fact that boost with its clumsy configuration simply "doesn't know anything" about the new studio.*.
The latest boost that was configured and builded without problems is [1.86.0 beta 1](https://archives.boost.io/beta/1.86.0.beta1/source/boost_1_86_0_b1.7z)


For example:
* downloaded boost_1_86_0.7z
* extracted to src\boost_1_86_0
* dir 'src\boost_1_86_0' must be renamed to 'src\boost'

After setup there is should be next library directories (**check it before running the build**):
* src\boost
* src\intel-tbb
* src\opensubdiv
* src\openusd


## Build libraries
Just run:

```cmd
.\build.cmd
```
(*currently only Debug configuration will be builded*)

This will build all dependency libraries and OpenUSD. All libs will be installed at .\dist directory
* .dist\boost-debug
* .dist\opensubdiv-debug
* .dist\opensusd-debug
* .dist\tbb-debug

## After build

Run:

```cmd
.\run-usdview.cmd
```

to start Usd View application (to check that something is working).

## Add OpenUSD library to project

For cmake's configuration next variables must be specified:
* "CMAKE_PREFIX_PATH": "X:/local/path/to/usd-build/dist/openusd-debug;X:/local/path/to/usd-build/dist/boost-debug",
* "TBB_USE_DEBUG_BUILD": true,
* "Boost_USE_STATIC_LIBS": false,
* "Boost_COMPILER": "vc143"

for example within CMakePresets.json:

```json
{
    "version": 5,
    "configurePresets": [
        {
            "name": "config_base",
            "hidden": true,
            "binaryDir": "${sourceDir}/build/${presetName}",
            "installDir": "${sourceDir}/dist/${presetName}",
            "cacheVariables": {
                "CMAKE_EXPORT_COMPILE_COMMANDS": true,
                "CMAKE_SYSTEM_VERSION": "10.0",
                "CMAKE_TOOLCHAIN_FILE": "$env{VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake",
                "NAU_BUILD_SDK": true,
                "BUILD_SHARED_LIBS": false,
                "EASTL_BUILD_BENCHMARK": false,
                "EASTL_BUILD_TESTS": false,

                "CMAKE_PREFIX_PATH": "l:/libs/usd-build/dist/openusd-debug;l:/libs/usd-build/dist/boost-debug",
                "TBB_USE_DEBUG_BUILD": true,
                "Boost_USE_STATIC_LIBS": false,
                "Boost_COMPILER": "vc143"
        
            }
        },

```


cmake file that responsible to initialize usd (and related components):

```cmake
# file to find packages
find_package(pxr REQUIRED)
find_package(Boost 1.86.0 COMPONENTS python REQUIRED)

if (pxr_FOUND AND Boost_FOUND)
  message(STATUS "Using pre-installed pxr (openusd) and boost packages")
else()
  # message(FATAL_ERROR "Custom usd libraries not found")
  # or using default code path, if it exists
  message(STATUS "Fetch openusd as remote package")
  # ...

endif()

```