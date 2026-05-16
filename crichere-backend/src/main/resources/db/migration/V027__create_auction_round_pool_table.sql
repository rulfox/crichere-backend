CREATE TABLE auction_round_pool_players (
    id UUID PRIMARY KEY,
    round_id UUID NOT NULL REFERENCES auction_round_configs(id) ON DELETE CASCADE,
    league_player_id UUID NOT NULL REFERENCES league_players(id) ON DELETE CASCADE
);

CREATE INDEX idx_auction_round_pool_round ON auction_round_pool_players(round_id);
