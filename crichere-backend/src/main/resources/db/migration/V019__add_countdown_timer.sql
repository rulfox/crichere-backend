-- V019__add_countdown_timer.sql

-- Add countdown config to auction_round_configs
ALTER TABLE auction_round_configs ADD COLUMN countdown_seconds INT NOT NULL DEFAULT 60;
ALTER TABLE auction_round_configs ADD COLUMN anti_snipe_seconds INT NOT NULL DEFAULT 10;

-- Add timer state to auctions
ALTER TABLE auctions ADD COLUMN timer_started_at TIMESTAMP WITH TIME ZONE NULL;
ALTER TABLE auctions ADD COLUMN timer_duration_seconds INT NULL;
