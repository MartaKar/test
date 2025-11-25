#!/bin/bash

echo "=== Testing Build Server Packages ==="
echo ""

echo "--- New Java Versions ---"
java -version
echo ""
gradle --version
echo ""
mvn --version
echo ""

echo "--- New Package Managers ---"
bun --version
echo ""
pnpm --version
echo ""

echo "--- Existing Packages (Verification) ---"
node --version
npm --version
yarn --version
ruby --version
python --version
php --version
go version
echo ""

echo "=== All Tests Complete ==="
