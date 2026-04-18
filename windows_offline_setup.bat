@echo off
setlocal enabledelayedexpansion

echo =================================================
echo   [>>] OpenClaude Windows OFFLINE Installer
echo =================================================
echo.
echo   This will configure OpenClaude to use your local Ollama server.
echo   Ensure Ollama is installed and running on your PC.
echo =================================================
echo.

echo Choose your local model:
echo 1) gemma4:e2b (Recommended for Low RAM)
echo 2) llama3 (Standard)
echo 3) Custom Model
echo.

set /p MODEL_CHOICE="Choose a number (Default: 1): "
if "%MODEL_CHOICE%"=="" set MODEL_CHOICE=1

if "%MODEL_CHOICE%"=="1" set MODEL_NAME=gemma4:e2b
if "%MODEL_CHOICE%"=="2" set MODEL_NAME=llama3
if "%MODEL_CHOICE%"=="3" (
    set /p MODEL_NAME="Enter custom model name: "
)

if "!MODEL_NAME!"=="" set MODEL_NAME=gemma4:e2b

echo.
echo [OK] You have selected: !MODEL_NAME!
pause

echo.
echo =================================================
echo   [>>] Installing OpenClaude...
echo =================================================
echo.

mkdir openclaude_offline
cd openclaude_offline

call npm init -y
call npm install @gitlawb/openclaude

echo.
echo [3/3] Generating start_offline.bat launcher script...

(
echo @echo off
echo set CLAUDE_CODE_USE_OPENAI=1
echo set OPENAI_API_KEY=ollama
echo set OPENAI_BASE_URL=http://localhost:11434/v1
echo set OPENAI_MODEL=!MODEL_NAME!
echo set ANTHROPIC_API_KEY=
echo set OLLAMA_NUM_CTX=2048
echo echo Booting OpenClaude Offline with !MODEL_NAME!...
echo npx openclaude %%*
) > start_offline.bat

echo.
echo =================================================
echo   [DONE] Setup Complete!
echo.
echo   To run your AI assistant offline, just double
echo   click 'start_offline.bat'
echo =================================================
echo.
pause
