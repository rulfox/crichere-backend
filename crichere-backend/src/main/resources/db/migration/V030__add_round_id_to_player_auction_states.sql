-- V030: tag PlayerAuctionState with the round of its last assignment so per-round
-- summaries and "unsold-in-previous-round" filters can be exact instead of
-- approximate. Backfills with the auction's current round when present.
ALTER TABLE player_auction_states ADD COLUMN round_id UUID NULL;

UPDATE player_auction_states pas
SET round_id = a.current_round_id
FROM auctions a
WHERE pas.auction_id = a.id AND a.current_round_id IS NOT NULL;

CREATE INDEX idx_player_auction_states_round ON player_auction_states (auction_id, round_id);
