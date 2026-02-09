# Contributing to ArkWatch

Thank you for your interest in contributing to ArkWatch! 🎉

## Getting Started

1. Fork the repository
2. Clone your fork: `git clone https://github.com/YOUR_USERNAME/arkwatch-demo.git`
3. Create a branch: `git checkout -b feature/your-feature-name`
4. Make your changes
5. Test locally: `./quick-start.sh`
6. Commit: `git commit -m "Add your feature"`
7. Push: `git push origin feature/your-feature-name`
8. Open a Pull Request

## Development Setup

```bash
# Start services
docker-compose up -d

# View logs
docker-compose logs -f

# Run tests (when available)
docker-compose exec backend pytest
```

## Code Style

- **Python**: Follow PEP 8
- **JavaScript**: Use ES6+ features
- **Comments**: Write clear, concise comments
- **Commits**: Use conventional commits (feat:, fix:, docs:, etc.)

## Testing

Before submitting a PR:

1. Test the quick-start script: `./quick-start.sh`
2. Verify all services start correctly
3. Test API endpoints manually
4. Check logs for errors

## Documentation

- Update README.md if you change functionality
- Add comments to complex code
- Update API documentation if you add endpoints

## Reporting Issues

- Use GitHub Issues
- Include steps to reproduce
- Include error logs
- Specify your Docker version

## Questions?

Open an issue or email hello@arkforge.fr

Thank you! 🙏
