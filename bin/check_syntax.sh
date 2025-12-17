#!/bin/bash

# Define colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo "🔍 Checking for Liquid syntax errors..."
ERROR_FOUND=0

# Check for spaces inside Liquid tags (e.g., { { or } })
# We exclude this script itself from the check
# Check for spaces inside Liquid opening tags (e.g., { { or { %)
# We use -I to ignore binary files 
grep -rEI "{ {" . --exclude-dir=_site --exclude-dir=.git --exclude-dir=vendor --exclude=check_syntax.sh
if [ $? -eq 0 ]; then
    echo -e "${RED}[ERROR] Found invalid liquid start tag '{ {' in the files above.${NC}"
    ERROR_FOUND=1
fi

grep -rEI "{ %" . --exclude-dir=_site --exclude-dir=.git --exclude-dir=vendor --exclude=check_syntax.sh
if [ $? -eq 0 ]; then
    echo -e "${RED}[ERROR] Found invalid liquid start tag '{ %' in the files above.${NC}"
    ERROR_FOUND=1
fi

if [ $ERROR_FOUND -eq 0 ]; then
    echo -e "${GREEN}✅ No common Liquid syntax errors found.${NC}"
    exit 0
else
    echo -e "${RED}❌ Verification failed.${NC}"
    exit 1
fi
