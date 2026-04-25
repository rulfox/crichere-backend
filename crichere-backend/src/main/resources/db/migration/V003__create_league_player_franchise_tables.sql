-- Leagues
CREATE TABLE leagues (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL,
    logo_url VARCHAR(500),
    banner_url VARCHAR(500),
    status VARCHAR(50) NOT NULL,
    created_by UUID NOT NULL REFERENCES users(id),
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Update user_league_memberships to reference leagues
ALTER TABLE user_league_memberships ADD CONSTRAINT fk_user_league_membership_league FOREIGN KEY (league_id) REFERENCES leagues(id);

-- Franchises
CREATE TABLE franchises (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    league_id UUID NOT NULL REFERENCES leagues(id),
    name VARCHAR(255) NOT NULL,
    logo_url VARCHAR(500),
    owner_id UUID NOT NULL REFERENCES users(id),
    total_purse INTEGER NOT NULL DEFAULT 0,
    remaining_purse INTEGER NOT NULL DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Update user_franchise_memberships to reference franchises
ALTER TABLE user_franchise_memberships ADD CONSTRAINT fk_user_franchise_membership_franchise FOREIGN KEY (franchise_id) REFERENCES franchises(id);

-- League Players
CREATE TABLE league_players (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    league_id UUID NOT NULL REFERENCES leagues(id),
    user_id UUID NOT NULL REFERENCES users(id),
    base_price INTEGER NOT NULL DEFAULT 0,
    status VARCHAR(50) NOT NULL,
    category VARCHAR(50),
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(league_id, user_id)
);

-- Franchise Invites
CREATE TABLE franchise_invites (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    franchise_id UUID NOT NULL REFERENCES franchises(id),
    email VARCHAR(255) NOT NULL,
    token UUID NOT NULL UNIQUE,
    status VARCHAR(50) NOT NULL,
    expires_at TIMESTAMP WITH TIME ZONE NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Auctions
CREATE TABLE auctions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    league_id UUID NOT NULL REFERENCES leagues(id),
    status VARCHAR(50) NOT NULL,
    current_round INT NOT NULL DEFAULT 1,
    total_rounds INT NOT NULL DEFAULT 1,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Franchise Purse States
CREATE TABLE franchise_purse_states (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    franchise_id UUID NOT NULL REFERENCES franchises(id),
    auction_id UUID NOT NULL REFERENCES auctions(id),
    round_number INT NOT NULL,
    initial_purse INTEGER NOT NULL,
    remaining_purse INTEGER NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(franchise_id, auction_id, round_number)
);

CREATE INDEX idx_leagues_status ON leagues(status);
CREATE INDEX idx_league_players_league_id ON league_players(league_id);
CREATE INDEX idx_league_players_user_id ON league_players(user_id);
CREATE INDEX idx_franchises_league_id ON franchises(league_id);
CREATE INDEX idx_franchises_owner_id ON franchises(owner_id);
CREATE INDEX idx_franchise_invites_token ON franchise_invites(token);
CREATE INDEX idx_auctions_league_id ON auctions(league_id);
CREATE INDEX idx_franchise_purse_states_franchise_auction ON franchise_purse_states(franchise_id, auction_id);
