@echo off
REM IW2DPO - Scarica i submodule di Humla (opus, speex, celt, spongycastle)
REM e compila i jar di spongycastle richiesti da build.gradle.

cd /d C:\humla-iw2dpo

echo.
echo === 1/2  git submodule update --init --recursive ===
git submodule update --init --recursive
if errorlevel 1 (
  echo ERRORE durante il download dei submodule.
  pause
  exit /b 1
)

echo.
echo === 2/2  Compilazione jar humla-spongycastle ===
cd /d C:\humla-iw2dpo\libs\humla-spongycastle
call ..\..\gradlew.bat jar > C:\humla-iw2dpo\spongycastle-build.log 2>&1
type C:\humla-iw2dpo\spongycastle-build.log

echo.
echo Verifica jar:
dir /b C:\humla-iw2dpo\libs\humla-spongycastle\prov\build\libs
dir /b C:\humla-iw2dpo\libs\humla-spongycastle\pkix\build\libs

echo.
echo === FINITO === (log in C:\humla-iw2dpo\spongycastle-build.log)
pause
