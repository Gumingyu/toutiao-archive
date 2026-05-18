@echo off
:: 头条英语角 · 档案部署脚本 (Windows简化版)

cd /d "%~dp0"

git init
git remote remove origin 2>nul
git remote add origin https://github.com/Gumingyu/toutiao-archive.git
git config user.email "toutiao@gusir.com"
git config user.name "gusir"
git checkout -b main 2>nul || git checkout main 2>nul

git add -A
git commit -m "update archive"
git push -u origin main --force

echo.
echo 完成！访问：https://Gumingyu.github.io/toutiao-archive/
echo.
pause
