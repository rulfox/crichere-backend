CREATE TABLE IF NOT EXISTS waiting_list_entries (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    league_id UUID NOT NULL REFERENCES leagues(id),
    user_id UUID NOT NULL REFERENCES users(id),
    franchise_id UUID REFERENCES franchises(id),
    type VARCHAR(50) NOT NULL,
    position INTEGER NOT NULL,
    status VARCHAR(50) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    promoted_at TIMESTAMP WITH TIME ZONE
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_waiting_list_league_position_waiting ON waiting_list_entries(league_id, position) WHERE status = 'WAITING';
CREATE INDEX IF NOT EXISTS idx_waiting_list_league_id ON waiting_list_entries(league_id);
CREATE INDEX IF NOT EXISTS idx_waiting_list_user_id ON waiting_list_entries(user_id);
