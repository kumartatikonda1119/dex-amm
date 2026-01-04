#!/bin/bash

echo "🚀 Starting DEX AMM Verification..."
echo "=================================="

echo "📦 Installing dependencies..."
npm install

echo "🔨 Compiling contracts..."
npm run compile

if [ $? -ne 0 ]; then
    echo "❌ Compilation failed!"
    exit 1
fi

echo "🧪 Running tests..."
npm test

if [ $? -ne 0 ]; then
    echo "❌ Tests failed!"
    exit 1
fi

echo "📊 Generating coverage report..."
npm run coverage

if [ $? -ne 0 ]; then
    echo "❌ Coverage check failed!"
    exit 1
fi

echo "✅ All checks passed!"
echo "🎉 DEX AMM is ready for submission!"