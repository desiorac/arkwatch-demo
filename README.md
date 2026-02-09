# 🔍 ArkWatch Demo - Docker Setup

> **Get ArkWatch running locally in under 5 minutes!**

ArkWatch is a web monitoring service with AI-powered change summaries. This demo repository lets you run the entire stack locally using Docker.

## ⚡ Quick Start (< 5 minutes)

```bash
git clone https://github.com/arkforge/arkwatch-demo.git
cd arkwatch-demo
./quick-start.sh
```

That's it! Open http://localhost:3000 to see the monitoring dashboard.

## 📋 Prerequisites

- Docker 20.10+ ([Install Docker](https://docs.docker.com/get-docker/))
- Docker Compose 2.0+ ([Install Compose](https://docs.docker.com/compose/install/))
- 2GB free RAM
- 5GB free disk space

## 🏗️ Architecture

```
┌─────────────────┐
│   Monitoring    │  Port 3000 - Dashboard UI
│   Dashboard     │
└────────┬────────┘
         │
┌────────▼────────┐
│   API Backend   │  Port 8080 - FastAPI
│   (Python)      │
└────────┬────────┘
         │
    ┌────┴────┐
    │         │
┌───▼───┐ ┌──▼───┐
│ Redis │ │ PostgreSQL │
│       │ │            │
└───────┘ └────────────┘
```

## 🚀 What's Included

- **Backend API** (FastAPI + Python 3.13)
  - RESTful endpoints for watch management
  - Health monitoring
  - Demo mode with mock data

- **PostgreSQL Database**
  - Pre-configured schema
  - Sample data included

- **Redis Cache**
  - Fast in-memory caching
  - Task queue management

- **Worker Service**
  - Background job processing
  - URL checking simulation

- **Monitoring Dashboard**
  - Live health checks
  - Quick API testing
  - System metrics

## 📚 API Endpoints

### Health Check
```bash
curl http://localhost:8080/health
```

### Create a Watch
```bash
curl -X POST "http://localhost:8080/api/v1/watches?url=https://example.com&name=My Watch"
```

### List Watches
```bash
curl http://localhost:8080/api/v1/watches
```

### Get Reports
```bash
curl http://localhost:8080/api/v1/watches/demo-watch-1/reports
```

### Pricing Info
```bash
curl http://localhost:8080/pricing
```

## 🔧 Configuration

### Environment Variables

Edit `docker-compose.yml` to customize:

```yaml
environment:
  DATABASE_URL: postgresql://arkwatch:yourpassword@postgres:5432/arkwatch
  REDIS_URL: redis://redis:6379
  ARKWATCH_ENV: development
  SECRET_KEY: your-secret-key
```

### Port Mapping

Change ports in `docker-compose.yml`:

```yaml
ports:
  - "YOUR_PORT:8080"  # API
  - "YOUR_PORT:3000"  # Dashboard
```

## 🛠️ Development

### View Logs
```bash
docker-compose logs -f backend
docker-compose logs -f worker
```

### Access Database
```bash
docker exec -it arkwatch-postgres psql -U arkwatch
```

### Access Redis CLI
```bash
docker exec -it arkwatch-redis redis-cli
```

### Rebuild Containers
```bash
docker-compose down
docker-compose build --no-cache
docker-compose up -d
```

## 🧪 Testing

### Run Health Check
```bash
curl http://localhost:8080/health | jq
```

### Test Full Flow
```bash
# 1. Create a watch
WATCH=$(curl -s -X POST "http://localhost:8080/api/v1/watches?url=https://example.com" | jq -r '.id')

# 2. List watches
curl http://localhost:8080/api/v1/watches | jq

# 3. Get reports
curl "http://localhost:8080/api/v1/watches/$WATCH/reports" | jq
```

## 📊 Monitoring Dashboard

Open http://localhost:3000 to access the monitoring dashboard:

- **Live Health Status**: Real-time API health checks
- **System Metrics**: Database, Redis, Worker status
- **Quick Testing**: Interactive API testing UI

## 🐛 Troubleshooting

### Services won't start

```bash
# Check Docker is running
docker ps

# Check logs
docker-compose logs

# Reset everything
docker-compose down -v
./quick-start.sh
```

### Port already in use

```bash
# Find process using port
lsof -i :8080

# Or change port in docker-compose.yml
ports:
  - "8081:8080"
```

### Database connection issues

```bash
# Wait for database to be ready
docker-compose logs postgres

# Manually check connection
docker exec -it arkwatch-postgres pg_isready -U arkwatch
```

## 🗑️ Cleanup

### Stop services
```bash
docker-compose down
```

### Remove all data (including volumes)
```bash
docker-compose down -v
```

### Remove images
```bash
docker-compose down --rmi all
```

## 📖 Documentation

- [Full ArkWatch Documentation](https://arkforge.fr/docs)
- [API Reference](https://watch.arkforge.fr/docs)
- [Production Deployment Guide](https://github.com/arkforge/arkwatch/wiki/deployment)

## 🤝 Production Deployment

This is a **demo environment** for testing. For production use:

1. Use strong passwords
2. Enable HTTPS (reverse proxy with Caddy/Nginx)
3. Configure proper secrets management
4. Set up backups
5. Use managed databases (AWS RDS, Digital Ocean, etc.)
6. Enable monitoring and alerting
7. Review security best practices

See our [Production Deployment Guide](https://github.com/arkforge/arkwatch/wiki/deployment) for details.

## 💡 Use Cases

ArkWatch is perfect for:

- **DevOps**: Monitor API uptime and response times
- **Indie Hackers**: Track competitor product changes
- **Agencies**: Monitor client websites for unauthorized changes
- **E-commerce**: Get alerted when prices change
- **Content Creators**: Track when new content is published
- **Compliance Teams**: Ensure terms of service updates are tracked

## 🎯 Next Steps

1. **Try the Live Demo**: [watch.arkforge.fr](https://watch.arkforge.fr)
2. **Sign Up for Free**: 3 URLs, daily checks, no credit card
3. **Upgrade to Pro**: Unlimited URLs, hourly checks, priority support
4. **Join the Community**: [Discord](https://discord.gg/arkforge)

## 📧 Support

- **Issues**: [GitHub Issues](https://github.com/arkforge/arkwatch-demo/issues)
- **Email**: hello@arkforge.fr
- **Documentation**: [arkforge.fr/docs](https://arkforge.fr/docs)

## 📜 License

MIT License - Free to use and modify

---

**Built with ❤️ by [ArkForge](https://arkforge.fr)**

*Making web monitoring accessible to everyone*
