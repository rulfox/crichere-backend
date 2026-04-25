CREATE UNIQUE INDEX IF NOT EXISTS idx_waiting_list_league_position_waiting
ON waiting_list_entries (league_id, position)
WHERE status = 'WAITING';
