"""ArkWatch API - Demo Version"""

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI(
    title="ArkWatch API (Demo)",
    description="Web monitoring API with AI-powered change summaries",
    version="0.1.0-demo",
)

# CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Demo mode - allow all
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get("/")
async def root():
    return {
        "name": "ArkWatch API (Demo)",
        "version": "0.1.0-demo",
        "status": "running",
        "message": "Welcome to ArkWatch! Monitor web changes with AI-powered summaries.",
    }


@app.get("/health")
async def health():
    return {
        "status": "healthy",
        "database": "connected",
        "redis": "connected",
    }


@app.post("/api/v1/watches")
async def create_watch(url: str, name: str = None):
    """Create a new watch (demo endpoint)"""
    return {
        "id": "demo-watch-1",
        "url": url,
        "name": name or "My Watch",
        "status": "active",
        "check_interval": 86400,
        "message": "Watch created successfully! In production, this would start monitoring your URL.",
    }


@app.get("/api/v1/watches")
async def list_watches():
    """List all watches (demo endpoint)"""
    return {
        "watches": [
            {
                "id": "demo-watch-1",
                "url": "https://example.com",
                "name": "Example Website",
                "status": "active",
                "last_check": "2026-02-09T10:00:00Z",
            }
        ],
        "total": 1,
    }


@app.get("/api/v1/watches/{watch_id}/reports")
async def get_reports(watch_id: str):
    """Get reports for a watch (demo endpoint)"""
    return {
        "reports": [
            {
                "id": "demo-report-1",
                "watch_id": watch_id,
                "change_detected": True,
                "summary": "The homepage title changed from 'Welcome' to 'Welcome Back!'",
                "timestamp": "2026-02-09T10:00:00Z",
            }
        ],
        "total": 1,
    }


@app.get("/pricing")
async def pricing():
    """Get pricing information"""
    return {
        "plans": [
            {
                "name": "Free",
                "price": 0,
                "features": ["3 URLs", "Daily checks", "Email alerts"],
            },
            {
                "name": "Pro",
                "price": 9.99,
                "features": ["Unlimited URLs", "Hourly checks", "Priority support"],
            },
        ]
    }
