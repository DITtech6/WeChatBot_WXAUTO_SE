@echo off
setlocal enabledelayedexpansion

:: ---------------------------
:: ���Python�����Ͱ汾
:: ---------------------------

:: ���Python�Ƿ�װ
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Pythonδ��װ�����Ȱ�װPython 3.8����߰汾��
    pause
    exit /b 1
)

:: ��ȡPython�汾
for /f "tokens=2" %%i in ('python --version 2^>^&1') do set "pyversion=%%i"

:: ����Python�汾
for /f "tokens=1,2 delims=." %%a in ("%pyversion%") do (
    set major=%%a
    set minor=%%b
)

:: ���汾�Ƿ����Ҫ��
if %major% lss 3 (
    echo ����Python�汾��%pyversion%������Ҫ����Python 3.8��
    pause
    exit /b 1
)

if %major% equ 3 if %minor% lss 8 (
    echo ����Python�汾��%pyversion%������Ҫ����Python 3.8��
    pause
    exit /b 1
)

:: ���pip�Ƿ�װ
python -m pip --version >nul 2>&1
if %errorlevel% neq 0 (
    echo pipδ��װ�����Ȱ�װpip��
    pause
    exit /b 1
)

:: ---------------------------
:: ���������
:: ---------------------------

echo ���������...

python updater.py

echo ���������ɣ�

:: ---------------------------
:: ��װ����
:: ---------------------------

echo ��װ����...

python -m pip install -r requirements.txt

if %errorlevel% neq 0 (
    echo ��װ����ʧ�ܣ�����������ֶ���װ������
    pause
    exit /b 1
)
echo ������װ��ɣ�

:: ����
cls

:: ---------------------------
:: ���˿�ռ�ò��ر�
:: ---------------------------

echo ���˿�ռ��...
set "PORT=5000"  :: ����Ҫ���Ķ˿ں�

:: ʹ��netstat���˿�ռ��
for /f "tokens=5" %%a in ('netstat -aon ^| findstr :%PORT%') do (
    set "PID=%%a"
    goto :found
)

echo �˿� %PORT% δ��ռ�ã�������������...
goto :start_program

:found
echo �˿� %PORT% �� PID %PID% �Ľ���ռ�ã�
choice /c YN /m "�Ƿ�Ҫ�ر�ռ�ö˿ڵĳ���"
if errorlevel 2 goto :start_program

:: �ر�ռ�ö˿ڵĽ���
echo ���ڹر� PID %PID% �Ľ���...
taskkill /F /PID %PID% >nul 2>&1
echo �����ѹرգ�

:start_program
echo.

:: ---------------------------
:: ��������
:: ---------------------------

:: �������ñ༭��
start python config_editor.py

:: �����������Flask������
start "" "http://localhost:5000"