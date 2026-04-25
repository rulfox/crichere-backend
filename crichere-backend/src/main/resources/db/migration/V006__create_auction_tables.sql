-- Auction Sequence for Audit Log
CREATE SEQUENCE IF NOT EXISTS global_auction_sequence START WITH 1;

-- Update Auctions table
ALTER TABLE auctions ADD COLUMN IF NOT EXISTS auctioneer_id UUID REFERENCES users(id);
ALTER TABLE auctions ADD COLUMN IF NOT EXISTS current_round_id UUID;
ALTER TABLE auctions ADD COLUMN IF NOT EXISTS current_league_player_id UUID;
ALTER TABLE auctions ADD COLUMN IF NOT EXISTS started_at TIMESTAMP WITH TIME ZONE;
ALTER TABLE auctions ADD COLUMN IF NOT EXISTS completed_at TIMESTAMP WITH TIME ZONE;
DO $$ 
BEGIN 
    IF NOT EXISTS (SELECT 1 FROM information_schema.table_constraints WHERE constraint_name = 'unique_league_auction') THEN
        ALTER TABLE auctions ADD CONSTRAINT unique_league_auction UNIQUE (league_id);
    END IF;
END $$;

-- Auction Rounds
CREATE TABLE IF NOT EXISTS auction_round_configs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    auction_id UUID NOT NULL REFERENCES auctions(id),
    round_number INT NOT NULL,
    name VARCHAR(100),
    currency_type VARCHAR(50) NOT NULL,
    purse_amount INT,
    purse_source VARCHAR(50) NOT NULL,
    bid_mode VARCHAR(50) NOT NULL,
    player_pool_source VARCHAR(50) NOT NULL,
    franchise_eligibility_rule VARCHAR(50) NOT NULL,
    completion_trigger VARCHAR(50) NOT NULL,
    status VARCHAR(50) NOT NULL,
    started_at TIMESTAMP WITH TIME ZONE,
    completed_at TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(auction_id, round_number)
);

-- Bid Increment Slabs
CREATE TABLE IF NOT EXISTS bid_increment_slabs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    round_id UUID NOT NULL REFERENCES auction_round_configs(id),
    from_amount INT NOT NULL,
    to_amount INT,
    increment_by INT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Bids
CREATE TABLE IF NOT EXISTS bids (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    auction_id UUID NOT NULL REFERENCES auctions(id),
    round_id UUID NOT NULL REFERENCES auction_round_configs(id),
    league_player_id UUID NOT NULL REFERENCES league_players(id),
    franchise_id UUID NOT NULL REFERENCES franchises(id),
    bid_amount INT NOT NULL,
    status VARCHAR(50) NOT NULL,
    recorded_by UUID NOT NULL REFERENCES users(id),
    bid_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Player Auction State
CREATE TABLE IF NOT EXISTS player_auction_states (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    auction_id UUID NOT NULL REFERENCES auctions(id),
    league_player_id UUID NOT NULL REFERENCES league_players(id),
    state VARCHAR(50) NOT NULL,
    current_highest_bid INT,
    current_highest_bidder_id UUID REFERENCES franchises(id),
    final_price INT,
    sold_to_franchise_id UUID REFERENCES franchises(id),
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(auction_id, league_player_id)
);

-- Update Franchise Purse States
ALTER TABLE franchise_purse_states ADD COLUMN IF NOT EXISTS round_id UUID REFERENCES auction_round_configs(id);
ALTER TABLE franchise_purse_states ADD COLUMN IF NOT EXISTS currency_type VARCHAR(50);
ALTER TABLE franchise_purse_states ADD COLUMN IF NOT EXISTS starting_amount INT;
DO $$ 
BEGIN 
    IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='franchise_purse_states' AND column_name='remaining_purse') THEN
        ALTER TABLE franchise_purse_states RENAME COLUMN remaining_purse TO current_amount;
    END IF;
END $$;
ALTER TABLE franchise_purse_states ADD COLUMN IF NOT EXISTS reserved_amount INT DEFAULT 0;
ALTER TABLE franchise_purse_states ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE franchise_purse_states DROP CONSTRAINT IF EXISTS franchise_purse_states_franchise_id_auction_id_round_number_key;
DO $$ 
BEGIN 
    IF NOT EXISTS (SELECT 1 FROM information_schema.table_constraints WHERE constraint_name = 'unique_franchise_round') THEN
        ALTER TABLE franchise_purse_states ADD CONSTRAINT unique_franchise_round UNIQUE (franchise_id, round_id);
    END IF;
END $$;

-- Auction Audit Log
CREATE TABLE IF NOT EXISTS auction_audit_logs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    auction_id UUID NOT NULL REFERENCES auctions(id),
    sequence_number BIGINT NOT NULL,
    action VARCHAR(50) NOT NULL,
    payload JSONB NOT NULL,
    actor_id UUID REFERENCES users(id),
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX IF NOT EXISTS idx_round_auction_id ON auction_round_configs(auction_id);
CREATE INDEX IF NOT EXISTS idx_bid_auction_id ON bids(auction_id);
CREATE INDEX IF NOT EXISTS idx_bid_league_player_id ON bids(league_player_id);
CREATE INDEX IF NOT EXISTS idx_player_auction_state_auction_id ON player_auction_states(auction_id);
CREATE INDEX IF NOT EXISTS idx_player_auction_state_league_player_id ON player_auction_states(league_player_id);
CREATE INDEX IF NOT EXISTS idx_purse_state_franchise_round ON franchise_purse_states(franchise_id, round_id);
CREATE INDEX IF NOT EXISTS idx_audit_log_auction_sequence ON auction_audit_logs(auction_id, sequence_number);

-- Franchise Players (Link table for sold players)
CREATE TABLE IF NOT EXISTS franchise_players (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    franchise_id UUID NOT NULL REFERENCES franchises(id),
    league_player_id UUID NOT NULL REFERENCES league_players(id),
    bought_price INT NOT NULL,
    round_id UUID NOT NULL REFERENCES auction_round_configs(id),
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(league_player_id)
);
