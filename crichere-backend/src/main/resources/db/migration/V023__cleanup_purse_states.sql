-- Remove obsolete columns and constraints
ALTER TABLE franchise_purse_states DROP CONSTRAINT IF EXISTS franchise_purse_states_franchise_id_auction_id_round_number_key;
ALTER TABLE franchise_purse_states DROP COLUMN IF EXISTS round_number;
ALTER TABLE franchise_purse_states DROP COLUMN IF EXISTS initial_purse;

-- Ensure round_id is NOT NULL since it's now part of the unique constraint
ALTER TABLE franchise_purse_states ALTER COLUMN round_id SET NOT NULL;
