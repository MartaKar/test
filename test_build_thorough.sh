#!/bin/bash
set -e  # Exit on any error

echo "=== THOROUGH Build Server Package Testing ==="
echo ""

# Skipping Java/Gradle/Maven tests (not installed yet)
# Will test after Docker image is rebuilt

# Test Bun
echo "--- Testing Bun ---"
bun --version
mkdir -p test-bun && cd test-bun
cat > package.json << 'EOF'
{
  "name": "test-bun",
  "version": "1.0.0",
  "scripts": {
    "test": "bun run index.js"
  }
}
EOF

cat > index.js << 'EOF'
console.log("Bun works!");
const sum = (a, b) => a + b;
console.log("2 + 2 =", sum(2, 2));
EOF

bun install
bun run test
cd ..
echo "✅ Bun test passed"
echo ""

# Test pnpm
echo "--- Testing pnpm ---"
pnpm --version
mkdir -p test-pnpm && cd test-pnpm
cat > package.json << 'EOF'
{
  "name": "test-pnpm",
  "version": "1.0.0",
  "scripts": {
    "start": "node app.js"
  },
  "dependencies": {
    "lodash": "^4.17.21"
  }
}
EOF

cat > app.js << 'EOF'
const _ = require('lodash');
console.log("pnpm works!");
console.log("Lodash chunk:", _.chunk([1, 2, 3, 4], 2));
EOF

pnpm install
pnpm start
cd ..
echo "✅ pnpm test passed"
echo ""

# Test Node + npm
echo "--- Testing Node + npm ---"
node --version
npm --version
mkdir -p test-npm && cd test-npm
npm init -y > /dev/null
npm install express --silent
node -e "const express = require('express'); console.log('npm + Node works!')"
cd ..
echo "✅ npm test passed"
echo ""

# Test Ruby + Bundler
echo "--- Testing Ruby + Bundler ---"
ruby --version
mkdir -p test-ruby && cd test-ruby
cat > Gemfile << 'EOF'
source 'https://rubygems.org'
gem 'json'
EOF

cat > test.rb << 'EOF'
require 'json'
data = { message: "Ruby works!" }
puts JSON.generate(data)
EOF

bundle install
ruby test.rb
cd ..
echo "✅ Ruby test passed"
echo ""

# Test PHP + Composer
echo "--- Testing PHP + Composer ---"
php --version
mkdir -p test-php && cd test-php
cat > composer.json << 'EOF'
{
    "require": {
        "monolog/monolog": "^2.0"
    }
}
EOF

composer install --quiet
php -r "echo 'PHP works!' . PHP_EOL;"
cd ..
echo "✅ PHP test passed"
echo ""

# Test Python + pip
echo "--- Testing Python + pip ---"
python3 --version
pip3 --version
mkdir -p test-python && cd test-python
cat > requirements.txt << 'EOF'
requests
EOF

pip3 install -r requirements.txt --quiet
python3 -c "import requests; print('Python works!')"
cd ..
echo "✅ Python test passed"
echo ""

# Test Go
echo "--- Testing Go ---"
go version
mkdir -p test-go && cd test-go
cat > main.go << 'EOF'
package main
import "fmt"
func main() {
    fmt.Println("Go works!")
}
EOF

go build
./test-go
cd ..
echo "✅ Go test passed"
echo ""

echo "=== ALL THOROUGH TESTS PASSED ==="
