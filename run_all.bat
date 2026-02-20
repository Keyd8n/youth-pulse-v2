@echo off
setlocal

echo [1/3] Checking environment...

:: Check for python
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Python not found! Please install Python.
    pause
    exit /b 1
)

:: Check for node
node -v >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Node.js not found! Please install Node.js.
    pause
    exit /b 1
)

echo [2/3] Starting Backend (FastAPI)...
cd backend
if not exist venv (
    echo Creating virtual environment...
    python -m venv venv
)
call venv\Scripts\activate
echo Installing backend dependencies...
pip install -r requirements.txt
start "YouthPulse Backend" cmd /c "venv\Scripts\activate && uvicorn main:app --reload --host 127.0.0.1 --port 8000"
cd ..

echo [3/3] Starting Frontend (React)...
cd frontend
if not exist node_modules (
    echo Installing frontend dependencies...
    npm install
)
start "YouthPulse Frontend" cmd /c "npm run dev -- --host"
cd ..

echo ======================================================
echo YouthPulse v2.0 is starting!
echo Backend: http://127.0.0.1:8000
echo Frontend: http://localhost:5173 (check console for IP if --host is used)
echo ======================================================
echo Keep this window open or close it (processes run in separate windows).
pause
