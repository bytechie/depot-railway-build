#!/bin/bash
# Test Case 4: New Dependency
# Adds ESLint as a new dev dependency

set -e

echo "📝 Applying Test Case 4: New Dependency"

cd sample-app

# Add ESLint to devDependencies
npm install --save-dev eslint @typescript-eslint/parser @typescript-eslint/eslint-plugin --silent

# Create .eslintrc.js
cat > .eslintrc.js << 'EOF'
module.exports = {
  parser: '@typescript-eslint/parser',
  extends: [
    'eslint:recommended',
    'plugin:@typescript-eslint/recommended',
  ],
  plugins: ['@typescript-eslint'],
  env: {
    node: true,
    es6: true,
  },
  rules: {
    '@typescript-eslint/no-explicit-any': 'warn',
    '@typescript-eslint/explicit-function-return-type': 'off',
  },
};
EOF

# Add lint script to package.json
npm pkg set scripts.lint="eslint src/**/*.ts"

cd ..

echo "✅ Test Case 4 applied: Added ESLint dependency"
echo "📊 Expected: ~40% cache hit (dependency layers rebuild)"
