#!/bin/bash

set -e

echo "🚀 ArkWatch Quick Start Script"
echo "==============================="
echo ""

# Check Docker
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed. Please install Docker first:"
    echo "   https://docs.docker.com/get-docker/"
    exit 1
fi

# Check Docker Compose
if ! command -v docker-compose &> /dev/null && ! docker compose version &> /dev/null; then
    echo "❌ Docker Compose is not installed. Please install Docker Compose first:"
    echo "   https://docs.docker.com/compose/install/"
    exit 1
fi

echo "✅ Docker and Docker Compose are installed"
echo ""

# Use docker compose or docker-compose
DOCKER_COMPOSE="docker compose"
if ! docker compose version &> /dev/null; then
    DOCKER_COMPOSE="docker-compose"
fi

echo "📦 Starting ArkWatch services..."
echo "This will take 2-3 minutes on first run (downloading images)"
echo ""

# Start services
$DOCKER_COMPOSE up -d

echo ""
echo "⏳ Waiting for services to be healthy..."
sleep 15

# Check if services are running
if docker ps | grep -q "arkwatch-backend"; then
    echo "✅ Backend is running"
else
    echo "❌ Backend failed to start"
    echo "   Check logs with: $DOCKER_COMPOSE logs backend"
    exit 1
fi

if docker ps | grep -q "arkwatch-postgres"; then
    echo "✅ PostgreSQL is running"
else
    echo "❌ PostgreSQL failed to start"
    exit 1
fi

if docker ps | grep -q "arkwatch-redis"; then
    echo "✅ Redis is running"
else
    echo "❌ Redis failed to start"
    exit 1
fi

echo ""
echo "🎉 ArkWatch is now running!"
echo ""
echo "📊 Access points:"
echo "   • API:        http://localhost:8080"
echo "   • API Health: http://localhost:8080/health"
echo "   • API Docs:   http://localhost:8080/docs"
echo "   • Monitoring: http://localhost:3000"
echo ""
echo "🧪 Quick tests:"
echo "   • Health check:  curl http://localhost:8080/health"
echo "   • Create watch:  curl -X POST 'http://localhost:8080/api/v1/watches?url=https://example.com&name=Test'"
echo "   • List watches:  curl http://localhost:8080/api/v1/watches"
echo ""
echo "📝 Useful commands:"
echo "   • View logs:   $DOCKER_COMPOSE logs -f"
echo "   • Stop:        $DOCKER_COMPOSE down"
echo "   • Restart:     $DOCKER_COMPOSE restart"
echo "   • Clean all:   $DOCKER_COMPOSE down -v"
echo ""
echo "⏱️  Total setup time: ~3 minutes ✅"
