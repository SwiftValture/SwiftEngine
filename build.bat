@echo off

for /f "delims=" %%i in ('git rev-parse --short HEAD') do set GIT_COMMIT=%%i

echo class GitCommit {
echo     public static var hash:String = "%GIT_COMMIT%";
echo } > source\GitCommit.hx

echo.
echo Git Commit: %GIT_COMMIT%
echo.

lime test windows