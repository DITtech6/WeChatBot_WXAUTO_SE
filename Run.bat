@echo off
cd /d "%~dp0"
start python config_editor.py
start "" "http://localhost:5000"
:prompt
set /p answer=�Ƿ�������ã������������Y��: 
if /i "%answer%"=="Y" (
    python bot.py
) else (
    echo ��������ú�����Y��
    goto prompt
)
