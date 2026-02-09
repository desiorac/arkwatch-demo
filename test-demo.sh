#!/bin/bash

# ArkWatch Demo - Quick Test Script
# Validates that the demo is working correctly

set -e

echo "🧪 ArkWatch Demo - Quick Test"
echo "=============================="
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Test results
PASSED=0
FAILED=0

# Function to test endpoint
test_endpoint() {
    local name=$1
    local url=$2
    local expected=$3

    echo -n "Testing $name... "

    if curl -sf "$url" | grep -q "$expected"; then
        echo -e "${GREEN}✓ PASS${NC}"
        ((PASSED++))
        return 0
    else
        echo -e "${RED}✗ FAIL${NC}"
        ((FAILED++))
        return 1
    fi
}

# Function to test service
test_service() {
    local name=$1
    local container=$2

    echo -n "Testing $name container... "

    if docker ps | grep -q "$container"; then
        echo -e "${GREEN}✓ PASS${NC}"
        ((PASSED++))
        return 0
    else
        echo -e "${RED}✗ FAIL${NC}"
        ((FAILED++))
        return 1
    fi
}

echo "📦 Testing Docker Services"
echo "-------------------------"
test_service "PostgreSQL" "arkwatch-postgres"
test_service "Redis" "arkwatch-redis"
test_service "Backend" "arkwatch-backend"
test_service "Worker" "arkwatch-worker"
test_service "Monitoring" "arkwatch-monitoring"
echo ""

echo "🔌 Testing API Endpoints"
echo "------------------------"
test_endpoint "Root endpoint" "http://localhost:8080/" "ArkWatch"
test_endpoint "Health check" "http://localhost:8080/health" "healthy"
test_endpoint "Pricing" "http://localhost:8080/pricing" "plans"
test_endpoint "Watches list" "http://localhost:8080/api/v1/watches" "watches"
echo ""

echo "🌐 Testing Dashboard"
echo "-------------------"
test_endpoint "Monitoring UI" "http://localhost:3000/" "Monitoring Dashboard"
echo ""

echo "🗄️  Testing Database"
echo "-------------------"
echo -n "Testing PostgreSQL connection... "
if docker exec arkwatch-postgres pg_isready -U arkwatch > /dev/null 2>&1; then
    echo -e "${GREEN}✓ PASS${NC}"
    ((PASSED++))
else
    echo -e "${RED}✗ FAIL${NC}"
    ((FAILED++))
fi

echo -n "Testing Redis connection... "
if docker exec arkwatch-redis redis-cli ping 2>&1 | grep -q "PONG"; then
    echo -e "${GREEN}✓ PASS${NC}"
    ((PASSED++))
else
    echo -e "${RED}✗ FAIL${NC}"
    ((FAILED++))
fi
echo ""

echo "🔄 Testing API Functionality"
echo "----------------------------"
echo -n "Creating test watch... "
RESPONSE=$(curl -sf -X POST "http://localhost:8080/api/v1/watches?url=https://example.com&name=TestWatch" 2>&1)
if echo "$RESPONSE" | grep -q "demo-watch"; then
    echo -e "${GREEN}✓ PASS${NC}"
    ((PASSED++))
else
    echo -e "${RED}✗ FAIL${NC}"
    ((FAILED++))
fi
echo ""

# Summary
echo "=============================="
echo "📊 Test Results Summary"
echo "=============================="
echo -e "Passed: ${GREEN}$PASSED${NC}"
echo -e "Failed: ${RED}$FAILED${NC}"
echo ""

if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN}🎉 All tests passed! Demo is ready to ship!${NC}"
    exit 0
else
    echo -e "${RED}⚠️  Some tests failed. Check logs:${NC}"
    echo "  docker-compose logs"
    exit 1
fi
