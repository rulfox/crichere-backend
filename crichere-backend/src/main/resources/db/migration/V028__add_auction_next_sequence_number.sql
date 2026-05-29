-- V028: per-auction monotonic counter for audit-log/SSE event ordering.
-- Backfills with current max(sequence_number) so existing audit chains continue from
-- where they left off without colliding with V024's unique (auction_id, sequence_number).
ALTER TABLE auctions ADD COLUMN next_sequence_number BIGINT NOT NULL DEFAULT 0;

UPDATE auctions a
SET next_sequence_number = COALESCE(
    (SELECT MAX(sequence_number) FROM auction_audit_logs WHERE auction_id = a.id),
    0
);
