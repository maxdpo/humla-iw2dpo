@echo off
REM IW2DPO - Compila i jar di humla-spongycastle (prov e pkix) usando il JDK 21 (jbr-21.0.11).

set "JAVA_HOME=C:\Users\max\.jdks\jbr-21.0.11"
set "PATH=%JAVA_HOME%\bin;%PATH%"
echo JAVA_HOME=%JAVA_HOME%
java -version

cd /d C:\humla-iw2dpo\libs\humla-spongycastle
echo.
echo === Compilazione jar humla-spongycastle (puo' richiedere qualche minuto) ===
call ..\..\gradlew.bat jar > C:\humla-iw2dpo\spongycastle-build.log 2>&1
type C:\humla-iw2dpo\spongycastle-build.log

echo.
echo Verifica jar:
dir /b C:\humla-iw2dpo\libs\humla-spongycastle\prov\build\libs
dir /b C:\humla-iw2dpo\libs\humla-spongycastle\pkix\build\libs

echo.
echo === FINITO === (log in C:\humla-iw2dpo\spongycastle-build.log)
pause
