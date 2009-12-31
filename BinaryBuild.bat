@echo off
SET PROGRAMFILES_DIR=%programfiles(x86)%
if PROGRAMFILES_DIR=="" SET PROGRAMFILES_DIR=%programfiles%

SET CMAKE="cmake.exe"
IF EXIST "%PROGRAMFILES_DIR%\CMake 2.6\bin\cmake.exe" SET CMAKE="%PROGRAMFILES_DIR%\CMake 2.6\bin\cmake.exe"
IF EXIST "%PROGRAMFILES_DIR%\CMake 2.8\bin\cmake.exe" SET CMAKE="%PROGRAMFILES_DIR%\CMake 2.8\bin\cmake.exe"

SET VS2005="%PROGRAMFILES_DIR%\Microsoft Visual Studio 8\Common7\IDE\devenv.exe"
SET VS2008="%PROGRAMFILES_DIR%\Microsoft Visual Studio 9.0\Common7\IDE\devenv.exe"
SET MSBUILD35="C:\WINDOWS\Microsoft.NET\Framework\v3.5\MSBuild.exe"

IF EXIST %MSBUILD35% SET DEVENV=%MSBUILD35%
IF EXIST %VS2005% SET DEVENV=%VS2005% 
IF EXIST %VS2008% SET DEVENV=%VS2008%

IF %DEVENV%==%MSBUILD35% SET BUILD_TYPE=/property:Configuration=Release
IF %DEVENV%==%VS2005% SET BUILD_TYPE=/Build Release
IF %DEVENV%==%VS2008% SET BUILD_TYPE=/Build Release

IF %DEVENV%==%MSBUILD35% SET CMAKE_CONF="Visual Studio 8 2005"
IF %DEVENV%==%VS2005% SET CMAKE_CONF="Visual Studio 8 2005"
IF %DEVENV%==%VS2008% SET CMAKE_CONF="Visual Studio 9 2008"

@echo on
del CMakeCache.txt
%CMAKE% -G %CMAKE_CONF% -DBUILD_TESTS:BOOL=FALSE -DBUILD_NEW_PYTHON_SUPPORT=FALSE .  
%DEVENV% %BUILD_TYPE% emgucv.sln

