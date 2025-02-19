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
:: ��װ����
:: ---------------------------

echo ��װ����...
:: �ֶ�¼��������
echo wechaty==0.8.19 > temp_requirements.txt
echo wechaty-puppet-service==0.8.4 >> temp_requirements.txt
echo pyee==8.2.2 >> temp_requirements.txt
echo flask >> temp_requirements.txt
echo flask-cors >> temp_requirements.txt
echo sqlalchemy~=2.0.37 >> temp_requirements.txt
echo requests >> temp_requirements.txt
echo wxauto~=3.9.11.17.5 >> temp_requirements.txt
echo openai~=1.61.0 >> temp_requirements.txt
echo pyautogui >> temp_requirements.txt
echo werkzeug >> temp_requirements.txt
echo psutil>> temp_requirements.txt

python -m pip install -r temp_requirements.txt
if %errorlevel% neq 0 (
    echo ��װ����ʧ�ܣ�����������ֶ���װ������
    pause
    exit /b 1
)
echo ������װ��ɣ�

:: ɾ����ʱ�ļ�
del temp_requirements.txt

:: ����
cls

:: ---------------------------
:: ��������
:: ---------------------------

:: �������ñ༭��
start python config_editor.py

:: �����������Flask������
start "" "http://localhost:5000"
