@echo off

:INPUT
echo.
echo ================输入命令===================
echo ======快捷【9=安装】 【 8=运行 】 【-1= 结束】 【7=构建】========
set /p cmd=请出入命令:

if    "%cmd%" ==  "8" (
	goto RUN
) else if     "%cmd%" == "9"  (
	goto INSTALL
) else if     "%cmd%" == "7"  (
	goto BUILD
) else if     "%cmd%" ==  "-1" (
	goto END
)  else if     "%cmd%" ==  "" (
	goto INPUT
)  else  (
	goto ISCMD 
)


:ISCMD
echo.
echo ================执行命令【%cmd%】==============
call %cmd%
echo ================执行命令结束===================
echo.
goto INPUT

:INSTALL
echo.
echo ================执行安装===================
call npm install
call npm install --save element-ui
echo ================安装结束===================
echo.
goto INPUT

:RUN
echo.
echo ================执行运行===================
call npm run start
echo ================执行运行结束===================
echo.
goto INPUT

:BUILD
echo.
echo ================执行构建===================
call npm run build
echo ================执行构建结束===================
echo.
goto INPUT

:END
echo ================结束===================
pause
