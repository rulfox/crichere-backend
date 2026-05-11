-- V020__add_category_bid_increments.sql

CREATE TABLE auction_round_category_increments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    round_id UUID NOT NULL REFERENCES auction_round_configs(id) ON DELETE CASCADE,
    category VARCHAR(50) NULL,
    tag VARCHAR(50) NULL,
    bid_increment INT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_category_or_tag CHECK (category IS NOT NULL OR tag IS NOT NULL)
);

CREATE INDEX idx_arbi_round ON auction_round_category_increments(round_id);
