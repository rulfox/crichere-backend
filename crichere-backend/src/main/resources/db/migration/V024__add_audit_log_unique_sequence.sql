-- V024__add_audit_log_unique_sequence.sql
ALTER TABLE auction_audit_logs ADD CONSTRAINT unique_auction_sequence UNIQUE (auction_id, sequence_number);
