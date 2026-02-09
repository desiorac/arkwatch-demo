-- ArkWatch Database Initialization

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Users table
CREATE TABLE IF NOT EXISTS users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email VARCHAR(255) UNIQUE NOT NULL,
    stripe_customer_id VARCHAR(255),
    plan VARCHAR(50) DEFAULT 'free',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Watches table
CREATE TABLE IF NOT EXISTS watches (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    url TEXT NOT NULL,
    name VARCHAR(255),
    check_interval INTEGER DEFAULT 86400, -- 24h in seconds
    last_check TIMESTAMP,
    next_check TIMESTAMP,
    status VARCHAR(50) DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Reports table
CREATE TABLE IF NOT EXISTS reports (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    watch_id UUID REFERENCES watches(id) ON DELETE CASCADE,
    change_detected BOOLEAN DEFAULT false,
    summary TEXT,
    diff_data JSONB,
    check_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create indexes
CREATE INDEX IF NOT EXISTS idx_watches_user_id ON watches(user_id);
CREATE INDEX IF NOT EXISTS idx_watches_next_check ON watches(next_check);
CREATE INDEX IF NOT EXISTS idx_reports_watch_id ON reports(watch_id);
CREATE INDEX IF NOT EXISTS idx_reports_timestamp ON reports(check_timestamp);

-- Demo data
INSERT INTO users (email, plan) VALUES
    ('demo@arkwatch.local', 'free')
ON CONFLICT (email) DO NOTHING;
