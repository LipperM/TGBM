@echo off

:INPUT
echo.
echo ================��������===================
echo ======��ݡ�9=��װ�� �� 8=���� �� ��-1= ������ ��7=������========
set /p cmd=���������:

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
echo ================ִ�����%cmd%��==============
call %cmd%
echo ================ִ���������===================
echo.
goto INPUT

:INSTALL
echo.
echo ================ִ�а�װ===================
call npm install
call npm install --save element-ui
echo ================��װ����===================
echo.
goto INPUT

:RUN
echo.
echo ================ִ������===================
call npm run start
echo ================ִ�����н���===================
echo.
goto INPUT

:BUILD
echo.
echo ================ִ�й���===================
call npm run build
echo ================ִ�й�������===================
echo.
goto INPUT

:END
echo ================����===================
pause
