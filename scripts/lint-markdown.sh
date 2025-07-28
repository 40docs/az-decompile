#!/bin/bash
# Markdown linting script using markdownlint-cli2

echo "🔍 Running markdownlint-cli2 validation..."

# Check if markdownlint-cli2 is available
if command -v markdownlint-cli2 &> /dev/null; then
    echo "✅ markdownlint-cli2 found locally"
    markdownlint-cli2 "**/*.md"
elif command -v npx &> /dev/null; then
    echo "📦 Using markdownlint-cli2 via npx"
    npx markdownlint-cli2 "**/*.md"
else
    echo "❌ markdownlint-cli2 not available. Install with: npm install -g markdownlint-cli2"
    exit 1
fi

echo "✅ Markdown validation complete"
