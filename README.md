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

For example:
* downloaded boost_1_83_0.7z
* extracted to src\boost_1_83_0
* dir 'src\boost_1_83_0' must be renamed to 'src\boost'

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
...