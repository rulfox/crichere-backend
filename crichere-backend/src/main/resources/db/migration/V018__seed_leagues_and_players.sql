-- ============================================================
-- League 1: Kerala Premier League 2025  (OPEN, T20)
-- League 2: South India Super League 2025 (DRAFT, T10)
-- League 3: All India Club Championship 2025 (OPEN, ODI)
-- All leagues created by: Aswin (phone: 7293318484)
-- ============================================================

-- LEAGUES
INSERT INTO leagues (id, name, format, status, player_order_mode, must_sell_all, waiting_list_mode, created_by, auction_date, created_at, updated_at)
VALUES
    ('11111111-1111-1111-1111-111111111111',
     'Kerala Premier League 2025',
     'T20', 'OPEN', 'RANDOM', FALSE, 'ADMIN_PICKS',
     (SELECT id FROM users WHERE phone = '7293318484'),
     '2025-06-15 10:00:00+05:30', NOW(), NOW()),

    ('22222222-2222-2222-2222-222222222222',
     'South India Super League 2025',
     'T10', 'DRAFT', 'RANDOM', FALSE, 'ADMIN_PICKS',
     (SELECT id FROM users WHERE phone = '7293318484'),
     NULL, NOW(), NOW()),

    ('33333333-3333-3333-3333-333333333333',
     'All India Club Championship 2025',
     'ODI', 'OPEN', 'RANDOM', TRUE, 'AUTO_PROMOTE',
     (SELECT id FROM users WHERE phone = '7293318484'),
     '2025-07-20 10:00:00+05:30', NOW(), NOW());

-- ASWIN AS LEAGUE_ADMIN FOR ALL LEAGUES
INSERT INTO user_league_memberships (id, user_id, league_id, role, is_primary, joined_at)
VALUES
    (gen_random_uuid(), (SELECT id FROM users WHERE phone = '7293318484'), '11111111-1111-1111-1111-111111111111', 'LEAGUE_ADMIN', TRUE, NOW()),
    (gen_random_uuid(), (SELECT id FROM users WHERE phone = '7293318484'), '22222222-2222-2222-2222-222222222222', 'LEAGUE_ADMIN', TRUE, NOW()),
    (gen_random_uuid(), (SELECT id FROM users WHERE phone = '7293318484'), '33333333-3333-3333-3333-333333333333', 'LEAGUE_ADMIN', TRUE, NOW());

-- CATEGORY BASE PRICES
INSERT INTO league_category_base_prices (id, league_id, category, price)
VALUES
    -- League 1: KPL
    (gen_random_uuid(), '11111111-1111-1111-1111-111111111111', 'BATTER',        100000),
    (gen_random_uuid(), '11111111-1111-1111-1111-111111111111', 'BOWLER',        100000),
    (gen_random_uuid(), '11111111-1111-1111-1111-111111111111', 'ALL_ROUNDER',   150000),
    (gen_random_uuid(), '11111111-1111-1111-1111-111111111111', 'WICKET_KEEPER', 150000),
    -- League 2: SISL
    (gen_random_uuid(), '22222222-2222-2222-2222-222222222222', 'BATTER',         75000),
    (gen_random_uuid(), '22222222-2222-2222-2222-222222222222', 'BOWLER',         75000),
    (gen_random_uuid(), '22222222-2222-2222-2222-222222222222', 'ALL_ROUNDER',   100000),
    (gen_random_uuid(), '22222222-2222-2222-2222-222222222222', 'WICKET_KEEPER', 100000),
    -- League 3: ICC
    (gen_random_uuid(), '33333333-3333-3333-3333-333333333333', 'BATTER',        200000),
    (gen_random_uuid(), '33333333-3333-3333-3333-333333333333', 'BOWLER',        200000),
    (gen_random_uuid(), '33333333-3333-3333-3333-333333333333', 'ALL_ROUNDER',   300000),
    (gen_random_uuid(), '33333333-3333-3333-3333-333333333333', 'WICKET_KEEPER', 300000);

-- FRANCHISES
INSERT INTO franchises (id, league_id, name, owner_id, total_purse, remaining_purse, created_at, updated_at)
VALUES
    -- KPL franchises (purse: ₹10L each)
    ('11111111-1111-1111-1111-000000000001', '11111111-1111-1111-1111-111111111111', 'Alappuzha Aces',      (SELECT id FROM users WHERE phone = '7293318484'), 1000000, 1000000, NOW(), NOW()),
    ('11111111-1111-1111-1111-000000000002', '11111111-1111-1111-1111-111111111111', 'Kochi Kings',         (SELECT id FROM users WHERE phone = '9000000001'), 1000000, 1000000, NOW(), NOW()),
    ('11111111-1111-1111-1111-000000000003', '11111111-1111-1111-1111-111111111111', 'Thrissur Tigers',     (SELECT id FROM users WHERE phone = '9000000053'), 1000000, 1000000, NOW(), NOW()),

    -- SISL franchises (purse: ₹7.5L each)
    ('22222222-2222-2222-2222-000000000001', '22222222-2222-2222-2222-222222222222', 'Chennai Challengers', (SELECT id FROM users WHERE phone = '9000000005'),  750000,  750000, NOW(), NOW()),
    ('22222222-2222-2222-2222-000000000002', '22222222-2222-2222-2222-222222222222', 'Bangalore Blasters',  (SELECT id FROM users WHERE phone = '9000000025'),  750000,  750000, NOW(), NOW()),
    ('22222222-2222-2222-2222-000000000003', '22222222-2222-2222-2222-222222222222', 'Hyderabad Hunters',   (SELECT id FROM users WHERE phone = '9000000056'),  750000,  750000, NOW(), NOW()),
    ('22222222-2222-2222-2222-000000000004', '22222222-2222-2222-2222-222222222222', 'Kochi Tuskers',       (SELECT id FROM users WHERE phone = '9000000070'),  750000,  750000, NOW(), NOW()),

    -- ICC franchises (purse: ₹20L each)
    ('33333333-3333-3333-3333-000000000001', '33333333-3333-3333-3333-333333333333', 'Mumbai Mavericks',    (SELECT id FROM users WHERE phone = '9000000050'), 2000000, 2000000, NOW(), NOW()),
    ('33333333-3333-3333-3333-000000000002', '33333333-3333-3333-3333-333333333333', 'Delhi Dynamos',       (SELECT id FROM users WHERE phone = '9000000013'), 2000000, 2000000, NOW(), NOW()),
    ('33333333-3333-3333-3333-000000000003', '33333333-3333-3333-3333-333333333333', 'Punjab Panthers',     (SELECT id FROM users WHERE phone = '9000000017'), 2000000, 2000000, NOW(), NOW()),
    ('33333333-3333-3333-3333-000000000004', '33333333-3333-3333-3333-333333333333', 'Rajasthan Royals XI', (SELECT id FROM users WHERE phone = '9000000040'), 2000000, 2000000, NOW(), NOW());

-- USER FRANCHISE MEMBERSHIPS (franchise owners)
INSERT INTO user_franchise_memberships (id, user_id, franchise_id, joined_at)
VALUES
    (gen_random_uuid(), (SELECT id FROM users WHERE phone = '7293318484'), '11111111-1111-1111-1111-000000000001', NOW()),
    (gen_random_uuid(), (SELECT id FROM users WHERE phone = '9000000001'), '11111111-1111-1111-1111-000000000002', NOW()),
    (gen_random_uuid(), (SELECT id FROM users WHERE phone = '9000000053'), '11111111-1111-1111-1111-000000000003', NOW()),
    (gen_random_uuid(), (SELECT id FROM users WHERE phone = '9000000005'), '22222222-2222-2222-2222-000000000001', NOW()),
    (gen_random_uuid(), (SELECT id FROM users WHERE phone = '9000000025'), '22222222-2222-2222-2222-000000000002', NOW()),
    (gen_random_uuid(), (SELECT id FROM users WHERE phone = '9000000056'), '22222222-2222-2222-2222-000000000003', NOW()),
    (gen_random_uuid(), (SELECT id FROM users WHERE phone = '9000000070'), '22222222-2222-2222-2222-000000000004', NOW()),
    (gen_random_uuid(), (SELECT id FROM users WHERE phone = '9000000050'), '33333333-3333-3333-3333-000000000001', NOW()),
    (gen_random_uuid(), (SELECT id FROM users WHERE phone = '9000000013'), '33333333-3333-3333-3333-000000000002', NOW()),
    (gen_random_uuid(), (SELECT id FROM users WHERE phone = '9000000017'), '33333333-3333-3333-3333-000000000003', NOW()),
    (gen_random_uuid(), (SELECT id FROM users WHERE phone = '9000000040'), '33333333-3333-3333-3333-000000000004', NOW());

-- LEAGUE PLAYERS
-- League 1: Kerala Premier League — Kerala-based players
INSERT INTO league_players (id, league_id, user_id, base_price_override, status, category, created_at, updated_at)
VALUES
    (gen_random_uuid(), '11111111-1111-1111-1111-111111111111', (SELECT id FROM users WHERE phone = '7293318484'), NULL, 'APPROVED', 'BATTER',        NOW(), NOW()),
    (gen_random_uuid(), '11111111-1111-1111-1111-111111111111', (SELECT id FROM users WHERE phone = '9000000001'), NULL, 'APPROVED', 'BATTER',        NOW(), NOW()),
    (gen_random_uuid(), '11111111-1111-1111-1111-111111111111', (SELECT id FROM users WHERE phone = '9000000002'), NULL, 'APPROVED', 'BATTER',        NOW(), NOW()),
    (gen_random_uuid(), '11111111-1111-1111-1111-111111111111', (SELECT id FROM users WHERE phone = '9000000003'), NULL, 'APPROVED', 'BATTER',        NOW(), NOW()),
    (gen_random_uuid(), '11111111-1111-1111-1111-111111111111', (SELECT id FROM users WHERE phone = '9000000004'), NULL, 'APPROVED', 'BATTER',        NOW(), NOW()),
    (gen_random_uuid(), '11111111-1111-1111-1111-111111111111', (SELECT id FROM users WHERE phone = '9000000028'), NULL, 'APPROVED', 'BOWLER',        NOW(), NOW()),
    (gen_random_uuid(), '11111111-1111-1111-1111-111111111111', (SELECT id FROM users WHERE phone = '9000000029'), NULL, 'APPROVED', 'BOWLER',        NOW(), NOW()),
    (gen_random_uuid(), '11111111-1111-1111-1111-111111111111', (SELECT id FROM users WHERE phone = '9000000030'), NULL, 'APPROVED', 'BOWLER',        NOW(), NOW()),
    (gen_random_uuid(), '11111111-1111-1111-1111-111111111111', (SELECT id FROM users WHERE phone = '9000000049'), NULL, 'APPROVED', 'BOWLER',        NOW(), NOW()),
    (gen_random_uuid(), '11111111-1111-1111-1111-111111111111', (SELECT id FROM users WHERE phone = '9000000052'), NULL, 'APPROVED', 'ALL_ROUNDER',   NOW(), NOW()),
    (gen_random_uuid(), '11111111-1111-1111-1111-111111111111', (SELECT id FROM users WHERE phone = '9000000053'), NULL, 'APPROVED', 'ALL_ROUNDER',   NOW(), NOW()),
    (gen_random_uuid(), '11111111-1111-1111-1111-111111111111', (SELECT id FROM users WHERE phone = '9000000063'), NULL, 'APPROVED', 'ALL_ROUNDER',   NOW(), NOW()),
    (gen_random_uuid(), '11111111-1111-1111-1111-111111111111', (SELECT id FROM users WHERE phone = '9000000067'), NULL, 'APPROVED', 'ALL_ROUNDER',   NOW(), NOW()),
    (gen_random_uuid(), '11111111-1111-1111-1111-111111111111', (SELECT id FROM users WHERE phone = '9000000068'), NULL, 'APPROVED', 'ALL_ROUNDER',   NOW(), NOW()),
    (gen_random_uuid(), '11111111-1111-1111-1111-111111111111', (SELECT id FROM users WHERE phone = '9000000077'), NULL, 'APPROVED', 'WICKET_KEEPER', NOW(), NOW()),
    (gen_random_uuid(), '11111111-1111-1111-1111-111111111111', (SELECT id FROM users WHERE phone = '9000000084'), NULL, 'APPROVED', 'WICKET_KEEPER', NOW(), NOW()),
    (gen_random_uuid(), '11111111-1111-1111-1111-111111111111', (SELECT id FROM users WHERE phone = '9000000085'), NULL, 'APPROVED', 'WICKET_KEEPER', NOW(), NOW());

-- League 2: South India Super League — Tamil Nadu, Karnataka, Telangana players
INSERT INTO league_players (id, league_id, user_id, base_price_override, status, category, created_at, updated_at)
VALUES
    (gen_random_uuid(), '22222222-2222-2222-2222-222222222222', (SELECT id FROM users WHERE phone = '9000000005'), NULL, 'APPROVED', 'BATTER',        NOW(), NOW()),
    (gen_random_uuid(), '22222222-2222-2222-2222-222222222222', (SELECT id FROM users WHERE phone = '9000000006'), NULL, 'APPROVED', 'BATTER',        NOW(), NOW()),
    (gen_random_uuid(), '22222222-2222-2222-2222-222222222222', (SELECT id FROM users WHERE phone = '9000000007'), NULL, 'APPROVED', 'BATTER',        NOW(), NOW()),
    (gen_random_uuid(), '22222222-2222-2222-2222-222222222222', (SELECT id FROM users WHERE phone = '9000000021'), NULL, 'APPROVED', 'BATTER',        NOW(), NOW()),
    (gen_random_uuid(), '22222222-2222-2222-2222-222222222222', (SELECT id FROM users WHERE phone = '9000000022'), NULL, 'APPROVED', 'BATTER',        NOW(), NOW()),
    (gen_random_uuid(), '22222222-2222-2222-2222-222222222222', (SELECT id FROM users WHERE phone = '9000000024'), NULL, 'APPROVED', 'BATTER',        NOW(), NOW()),
    (gen_random_uuid(), '22222222-2222-2222-2222-222222222222', (SELECT id FROM users WHERE phone = '9000000025'), NULL, 'APPROVED', 'BOWLER',        NOW(), NOW()),
    (gen_random_uuid(), '22222222-2222-2222-2222-222222222222', (SELECT id FROM users WHERE phone = '9000000026'), NULL, 'APPROVED', 'BOWLER',        NOW(), NOW()),
    (gen_random_uuid(), '22222222-2222-2222-2222-222222222222', (SELECT id FROM users WHERE phone = '9000000027'), NULL, 'APPROVED', 'BOWLER',        NOW(), NOW()),
    (gen_random_uuid(), '22222222-2222-2222-2222-222222222222', (SELECT id FROM users WHERE phone = '9000000031'), NULL, 'APPROVED', 'BOWLER',        NOW(), NOW()),
    (gen_random_uuid(), '22222222-2222-2222-2222-222222222222', (SELECT id FROM users WHERE phone = '9000000032'), NULL, 'APPROVED', 'BOWLER',        NOW(), NOW()),
    (gen_random_uuid(), '22222222-2222-2222-2222-222222222222', (SELECT id FROM users WHERE phone = '9000000033'), NULL, 'APPROVED', 'BOWLER',        NOW(), NOW()),
    (gen_random_uuid(), '22222222-2222-2222-2222-222222222222', (SELECT id FROM users WHERE phone = '9000000048'), NULL, 'APPROVED', 'BOWLER',        NOW(), NOW()),
    (gen_random_uuid(), '22222222-2222-2222-2222-222222222222', (SELECT id FROM users WHERE phone = '9000000054'), NULL, 'APPROVED', 'ALL_ROUNDER',   NOW(), NOW()),
    (gen_random_uuid(), '22222222-2222-2222-2222-222222222222', (SELECT id FROM users WHERE phone = '9000000055'), NULL, 'APPROVED', 'ALL_ROUNDER',   NOW(), NOW()),
    (gen_random_uuid(), '22222222-2222-2222-2222-222222222222', (SELECT id FROM users WHERE phone = '9000000056'), NULL, 'APPROVED', 'ALL_ROUNDER',   NOW(), NOW()),
    (gen_random_uuid(), '22222222-2222-2222-2222-222222222222', (SELECT id FROM users WHERE phone = '9000000057'), NULL, 'APPROVED', 'ALL_ROUNDER',   NOW(), NOW()),
    (gen_random_uuid(), '22222222-2222-2222-2222-222222222222', (SELECT id FROM users WHERE phone = '9000000070'), NULL, 'APPROVED', 'ALL_ROUNDER',   NOW(), NOW()),
    (gen_random_uuid(), '22222222-2222-2222-2222-222222222222', (SELECT id FROM users WHERE phone = '9000000076'), NULL, 'APPROVED', 'WICKET_KEEPER', NOW(), NOW()),
    (gen_random_uuid(), '22222222-2222-2222-2222-222222222222', (SELECT id FROM users WHERE phone = '9000000086'), NULL, 'APPROVED', 'WICKET_KEEPER', NOW(), NOW());

-- League 3: All India Club Championship — pan-India mix
INSERT INTO league_players (id, league_id, user_id, base_price_override, status, category, created_at, updated_at)
VALUES
    (gen_random_uuid(), '33333333-3333-3333-3333-333333333333', (SELECT id FROM users WHERE phone = '7293318484'), NULL, 'APPROVED', 'BATTER',        NOW(), NOW()),
    (gen_random_uuid(), '33333333-3333-3333-3333-333333333333', (SELECT id FROM users WHERE phone = '9000000009'), NULL, 'APPROVED', 'BATTER',        NOW(), NOW()),
    (gen_random_uuid(), '33333333-3333-3333-3333-333333333333', (SELECT id FROM users WHERE phone = '9000000010'), NULL, 'APPROVED', 'BATTER',        NOW(), NOW()),
    (gen_random_uuid(), '33333333-3333-3333-3333-333333333333', (SELECT id FROM users WHERE phone = '9000000013'), NULL, 'APPROVED', 'BATTER',        NOW(), NOW()),
    (gen_random_uuid(), '33333333-3333-3333-3333-333333333333', (SELECT id FROM users WHERE phone = '9000000017'), NULL, 'APPROVED', 'BATTER',        NOW(), NOW()),
    (gen_random_uuid(), '33333333-3333-3333-3333-333333333333', (SELECT id FROM users WHERE phone = '9000000018'), NULL, 'APPROVED', 'BATTER',        NOW(), NOW()),
    (gen_random_uuid(), '33333333-3333-3333-3333-333333333333', (SELECT id FROM users WHERE phone = '9000000034'), NULL, 'APPROVED', 'BOWLER',        NOW(), NOW()),
    (gen_random_uuid(), '33333333-3333-3333-3333-333333333333', (SELECT id FROM users WHERE phone = '9000000037'), NULL, 'APPROVED', 'BOWLER',        NOW(), NOW()),
    (gen_random_uuid(), '33333333-3333-3333-3333-333333333333', (SELECT id FROM users WHERE phone = '9000000038'), NULL, 'APPROVED', 'BOWLER',        NOW(), NOW()),
    (gen_random_uuid(), '33333333-3333-3333-3333-333333333333', (SELECT id FROM users WHERE phone = '9000000039'), NULL, 'APPROVED', 'BOWLER',        NOW(), NOW()),
    (gen_random_uuid(), '33333333-3333-3333-3333-333333333333', (SELECT id FROM users WHERE phone = '9000000040'), NULL, 'APPROVED', 'BOWLER',        NOW(), NOW()),
    (gen_random_uuid(), '33333333-3333-3333-3333-333333333333', (SELECT id FROM users WHERE phone = '9000000042'), NULL, 'APPROVED', 'BOWLER',        NOW(), NOW()),
    (gen_random_uuid(), '33333333-3333-3333-3333-333333333333', (SELECT id FROM users WHERE phone = '9000000050'), NULL, 'APPROVED', 'ALL_ROUNDER',   NOW(), NOW()),
    (gen_random_uuid(), '33333333-3333-3333-3333-333333333333', (SELECT id FROM users WHERE phone = '9000000051'), NULL, 'APPROVED', 'ALL_ROUNDER',   NOW(), NOW()),
    (gen_random_uuid(), '33333333-3333-3333-3333-333333333333', (SELECT id FROM users WHERE phone = '9000000058'), NULL, 'APPROVED', 'ALL_ROUNDER',   NOW(), NOW()),
    (gen_random_uuid(), '33333333-3333-3333-3333-333333333333', (SELECT id FROM users WHERE phone = '9000000059'), NULL, 'APPROVED', 'ALL_ROUNDER',   NOW(), NOW()),
    (gen_random_uuid(), '33333333-3333-3333-3333-333333333333', (SELECT id FROM users WHERE phone = '9000000060'), NULL, 'APPROVED', 'ALL_ROUNDER',   NOW(), NOW()),
    (gen_random_uuid(), '33333333-3333-3333-3333-333333333333', (SELECT id FROM users WHERE phone = '9000000065'), NULL, 'APPROVED', 'ALL_ROUNDER',   NOW(), NOW()),
    (gen_random_uuid(), '33333333-3333-3333-3333-333333333333', (SELECT id FROM users WHERE phone = '9000000075'), NULL, 'APPROVED', 'WICKET_KEEPER', NOW(), NOW()),
    (gen_random_uuid(), '33333333-3333-3333-3333-333333333333', (SELECT id FROM users WHERE phone = '9000000078'), NULL, 'APPROVED', 'WICKET_KEEPER', NOW(), NOW()),
    (gen_random_uuid(), '33333333-3333-3333-3333-333333333333', (SELECT id FROM users WHERE phone = '9000000082'), NULL, 'APPROVED', 'WICKET_KEEPER', NOW(), NOW());
