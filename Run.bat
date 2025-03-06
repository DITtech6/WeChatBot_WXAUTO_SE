@echo off
setlocal enabledelayedexpansion

:: ---------------------------
:: ���Python�����Ͱ汾
:: ---------------------------

:: ���Python�Ƿ�װ
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Pythonδ��װ�����Ȱ�װPython 3.8����ߵİ汾�����밲װ3.12���µİ汾��
    echo �����Ѱ�װPython,�����Ƿ��Ѿ���Python��ӵ�ϵͳPath��
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
    echo ����Python�汾��%pyversion%������Ҫ����Python 3.8���ҵ���Python 3.12��
    pause
    exit /b 1
)

if %major% equ 3 (
    if %minor% lss 8 (
        echo ����Python�汾��%pyversion%������Ҫ����Python 3.8���ҵ���Python 3.12��
        pause
        exit /b 1
    )
    if %minor% gtr 11 (
        echo ����Python�汾��%pyversion%����Ŀǰ��֧��Python 3.12���°汾��
        pause
        exit /b 1
    )
)

:: ���pip�Ƿ�װ
python -m pip --version >nul 2>&1
if %errorlevel% neq 0 (
    echo pipδ��װ�����Ȱ�װpip��
    pause
    exit /b 1
)

echo Python�汾���ͨ����


:: ---------------------------
:: ��װ����
:: ---------------------------

echo ���ڼ����þ���Դ...

:: ���԰���Դ
echo ���ڳ��԰���Դ...
python -m pip install --upgrade pip --index-url https://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com
if !errorlevel! equ 0 (
    set "SOURCE_URL=https://mirrors.aliyun.com/pypi/simple/"
    set "TRUSTED_HOST=mirrors.aliyun.com"
    echo �ɹ�ʹ�ð���Դ��
    goto :INSTALL
)

:: �����廪Դ
echo ���ڳ����廪Դ...
python -m pip install --upgrade pip --index-url https://pypi.tuna.tsinghua.edu.cn/simple --trusted-host pypi.tuna.tsinghua.edu.cn
if !errorlevel! equ 0 (
    set "SOURCE_URL=https://pypi.tuna.tsinghua.edu.cn/simple"
    set "TRUSTED_HOST=pypi.tuna.tsinghua.edu.cn"
    echo �ɹ�ʹ���廪Դ��
    goto :INSTALL
)

:: ���Թٷ�Դ
echo ���ڳ��Թٷ�Դ...
python -m pip install --upgrade pip --index-url https://pypi.org/simple
if !errorlevel! equ 0 (
    set "SOURCE_URL=https://pypi.org/simple"
    set "TRUSTED_HOST="
    echo �ɹ�ʹ�ùٷ�Դ��
    goto :INSTALL
)

:: ����Դ��ʧ��
echo ���о���Դ�������ã������������ӡ�
pause
exit /b 1

:INSTALL
echo ����ʹ��Դ��%SOURCE_URL%
echo ��װ����...

if "!TRUSTED_HOST!"=="" (
    python -m pip install -r requirements.txt -f ./libs --index-url !SOURCE_URL!
) else (
    python -m pip install -r requirements.txt -f ./libs --index-url !SOURCE_URL! --trusted-host !TRUSTED_HOST!
)

if !errorlevel! neq 0 (
    echo ��װ����ʧ�ܣ�����������ֶ���װ��
    pause
    exit /b 1
)

echo ������װ��ɣ�
cls

:: ---------------------------
:: ���������
:: ---------------------------

echo ���������...

python updater.py

echo ���������ɣ�

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
echo �˿� %PORT% �� PID %PID% �Ľ���ռ�ã����ڹرս���...

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