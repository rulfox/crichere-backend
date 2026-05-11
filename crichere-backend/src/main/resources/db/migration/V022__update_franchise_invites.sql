-- V022__update_franchise_invites.sql

ALTER TABLE franchise_invites ADD COLUMN accepted_by_user_id UUID NULL REFERENCES users(id);
ALTER TABLE franchise_invites ADD COLUMN accepted_at TIMESTAMP WITH TIME ZONE NULL;
ALTER TABLE franchise_invites ADD COLUMN max_uses INT NOT NULL DEFAULT 1;
ALTER TABLE franchise_invites ADD COLUMN use_count INT NOT NULL DEFAULT 0;

CREATE INDEX idx_franchise_invites_token_pending ON franchise_invites(token) WHERE status = 'SENT';
