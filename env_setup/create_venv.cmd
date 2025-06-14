@echo off
set VENV_NAME=%1
if "%VENV_NAME%"=="" set VENV_NAME=venv

echo Creating venv: %VENV_NAME%
where python > tmp.txt
set /p PY_PATH=<tmp.txt
del tmp.txt

%PY_PATH% -m venv %VENV_NAME%
call %VENV_NAME%\Scripts\activate

echo Activating venv: %VENV_NAME%
python -m pip install --upgrade pip ipykernel
python -m ipykernel install --user --name %VENV_NAME% --display-name "Python (%VENV_NAME%)"

echo Venv %VENV_NAME% is ready and active.
pause
