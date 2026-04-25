CREATE TABLE IF NOT EXISTS fee_obligations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    league_id UUID NOT NULL REFERENCES leagues(id),
    user_id UUID NOT NULL REFERENCES users(id),
    franchise_id UUID REFERENCES franchises(id),
    fee_type VARCHAR(50) NOT NULL,
    total_amount INTEGER NOT NULL,
    minimum_to_register INTEGER,
    paid_amount INTEGER DEFAULT 0,
    status VARCHAR(50) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(league_id, user_id, fee_type)
);

CREATE TABLE IF NOT EXISTS fee_payments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    obligation_id UUID NOT NULL REFERENCES fee_obligations(id),
    amount INTEGER NOT NULL,
    payment_mode VARCHAR(50) NOT NULL,
    notes TEXT,
    recorded_by UUID NOT NULL REFERENCES users(id),
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_fee_obligation_league_id ON fee_obligations(league_id);
CREATE INDEX IF NOT EXISTS idx_fee_obligation_user_id ON fee_obligations(user_id);
CREATE INDEX IF NOT EXISTS idx_fee_obligation_status ON fee_obligations(status);
CREATE INDEX IF NOT EXISTS idx_fee_payment_obligation_id ON fee_payments(obligation_id);
