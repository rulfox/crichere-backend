CREATE TABLE IF NOT EXISTS forfeit_requests (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    league_id UUID NOT NULL REFERENCES leagues(id),
    user_id UUID NOT NULL REFERENCES users(id),
    franchise_id UUID REFERENCES franchises(id),
    type VARCHAR(50) NOT NULL,
    reason TEXT NOT NULL,
    status VARCHAR(50) NOT NULL,
    fee_refund_decision VARCHAR(50),
    fee_refund_amount INTEGER,
    admin_notes TEXT,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    resolved_at TIMESTAMP WITH TIME ZONE
);

CREATE INDEX IF NOT EXISTS idx_forfeit_request_league_id ON forfeit_requests(league_id);
CREATE INDEX IF NOT EXISTS idx_forfeit_request_user_id ON forfeit_requests(user_id);
CREATE INDEX IF NOT EXISTS idx_forfeit_request_status ON forfeit_requests(status);
