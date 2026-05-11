-- V021__add_public_view_token.sql

ALTER TABLE auctions ADD COLUMN public_view_token VARCHAR(64) UNIQUE;

-- Backfill existing auctions
UPDATE auctions SET public_view_token = encode(gen_random_bytes(32), 'hex') WHERE public_view_token IS NULL;

ALTER TABLE auctions ALTER COLUMN public_view_token SET NOT NULL;
ALTER TABLE auctions ALTER COLUMN public_view_token SET DEFAULT encode(gen_random_bytes(32), 'hex');

CREATE UNIQUE INDEX idx_auction_public_view_token ON auctions(public_view_token);
