# ArkWatch Demo - Quick Reference Card

One-page reference for the most common operations.

## 🚀 Quick Start

```bash
git clone https://github.com/arkforge/arkwatch-demo.git
cd arkwatch-demo
./quick-start.sh
```

## 🔗 Access URLs

| Service | URL | Purpose |
|---------|-----|---------|
| API | http://localhost:8080 | RESTful API |
| API Docs | http://localhost:8080/docs | Interactive API docs |
| Health | http://localhost:8080/health | Health check |
| Dashboard | http://localhost:3000 | Monitoring UI |

## 📡 Common API Calls

```bash
# Health check
curl http://localhost:8080/health

# Create watch
curl -X POST "http://localhost:8080/api/v1/watches?url=https://example.com&name=MyWatch"

# List watches
curl http://localhost:8080/api/v1/watches

# Get reports
curl http://localhost:8080/api/v1/watches/WATCH_ID/reports

# Pricing info
curl http://localhost:8080/pricing
```

## 🐳 Docker Commands

```bash
# Start services
docker-compose up -d

# Stop services
docker-compose down

# View logs (all services)
docker-compose logs -f

# View logs (specific service)
docker-compose logs -f backend

# Restart service
docker-compose restart backend

# Rebuild containers
docker-compose build --no-cache

# Check status
docker-compose ps

# Clean everything (including data)
docker-compose down -v
```

## 🔍 Debugging

```bash
# Check service status
docker ps | grep arkwatch

# Connect to PostgreSQL
docker exec -it arkwatch-postgres psql -U arkwatch

# Connect to Redis
docker exec -it arkwatch-redis redis-cli

# View backend logs
docker-compose logs backend --tail=100

# Check database tables
docker exec arkwatch-postgres psql -U arkwatch -c '\dt'

# Test API directly
curl -v http://localhost:8080/health
```

## 🛠️ Customization

### Change Ports

Edit `docker-compose.yml`:
```yaml
ports:
  - "YOUR_PORT:8080"  # Backend
  - "YOUR_PORT:3000"  # Dashboard
```

### Change Database Password

Edit `docker-compose.yml`:
```yaml
environment:
  POSTGRES_PASSWORD: your_secure_password
  DATABASE_URL: postgresql://arkwatch:your_secure_password@postgres:5432/arkwatch
```

### Enable Production Mode

Edit `docker-compose.yml`:
```yaml
environment:
  ARKWATCH_ENV: production
```

## 🧪 Testing

```bash
# Full test suite
./quick-start.sh && \
curl http://localhost:8080/health && \
curl -X POST "http://localhost:8080/api/v1/watches?url=https://example.com" && \
curl http://localhost:8080/api/v1/watches

# Load test (requires apache-bench)
ab -n 1000 -c 10 http://localhost:8080/health
```

## 🐛 Troubleshooting

| Problem | Solution |
|---------|----------|
| Port in use | `lsof -i :8080` and kill process |
| Permission denied | Add user to docker group: `sudo usermod -aG docker $USER` |
| Services won't start | Check logs: `docker-compose logs` |
| Database errors | Reset: `docker-compose down -v && ./quick-start.sh` |
| Slow startup | Wait 30-60s for PostgreSQL initialization |

## 📊 Monitoring

```bash
# Resource usage
docker stats --no-stream

# Disk usage
docker system df

# Container health
docker inspect arkwatch-backend | jq '.[0].State.Health'
```

## 🎯 Performance Tips

- Use `docker-compose up -d` for background mode
- Allocate at least 2GB RAM to Docker
- Use SSD for better database performance
- Monitor logs regularly: `docker-compose logs -f`

## 🔐 Security Notes

**This is a DEMO environment. For production:**
- [ ] Change all passwords
- [ ] Use HTTPS (reverse proxy)
- [ ] Enable authentication
- [ ] Use secrets management
- [ ] Regular security updates
- [ ] Enable firewall rules
- [ ] Use managed databases

## 📚 Resources

- [Full README](README.md)
- [Validation Checklist](VALIDATION_CHECKLIST.md)
- [GitHub Setup Guide](GITHUB_SETUP.md)
- [Contributing Guide](CONTRIBUTING.md)

---

**Support:** hello@arkforge.fr | **Website:** https://arkforge.fr
