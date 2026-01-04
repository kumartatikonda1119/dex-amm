@echo off
echo 🚀 Starting DEX AMM Verification...
echo ==================================
echo.

echo 📦 Installing dependencies...
call npm install
if %errorlevel% neq 0 (
    echo ❌ Dependency installation failed!
    exit /b 1
)
echo.

echo 🔨 Compiling contracts...
call npm run compile
if %errorlevel% neq 0 (
    echo ❌ Compilation failed!
    exit /b 1
)
echo.

echo 🧪 Running tests...
call npm test
if %errorlevel% neq 0 (
    echo ❌ Tests failed!
    exit /b 1
)
echo.

echo 📊 Generating coverage report...
call npm run coverage
if %errorlevel% neq 0 (
    echo ❌ Coverage check failed!
    exit /b 1
)
echo.

echo ✅ All checks passed!
echo 🎉 DEX AMM is ready for submission!
echo.