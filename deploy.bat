@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

rem Toutiao Archive deployment script for Windows
rem This script commits local changes and deploys them to GitHub Pages.

cd /d "%~dp0" || goto :dir_error

where git >nul 2>nul
if errorlevel 1 (
    echo [ERROR] Git is not installed or not available in PATH.
    goto :fail
)

if not exist ".git" (
    git init || goto :fail
)

git remote get-url origin >nul 2>nul
if errorlevel 1 (
    git remote add origin https://github.com/Gumingyu/toutiao-archive.git || goto :fail
) else (
    git remote set-url origin https://github.com/Gumingyu/toutiao-archive.git || goto :fail
)

git config user.email "toutiao@gusir.com" || goto :fail
git config user.name "gusir" || goto :fail

set "current_branch="
for /f "delims=" %%b in ('git branch --show-current 2^>nul') do set "current_branch=%%b"
if /i not "!current_branch!"=="main" (
    git checkout main 2>nul || git checkout -b main || goto :fail
)

git add -A || goto :fail

git diff --cached --quiet
if not errorlevel 1 (
    echo [INFO] No file changes to commit.
) else (
    git commit -m "update archive" || goto :fail
)

echo [INFO] Pushing to GitHub...
git push -u origin main || goto :fail

echo.
echo [OK] Deployment complete: https://Gumingyu.github.io/toutiao-archive/
echo.
pause
exit /b 0

:fail
echo.
echo [ERROR] Deployment failed. Please check the message above.
echo.
pause
exit /b 1

:dir_error
echo.
echo [ERROR] Could not enter the script directory.
echo.
pause
exit /b 1