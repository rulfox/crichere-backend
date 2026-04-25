ALTER TABLE league_players RENAME COLUMN base_price TO base_price_override;
ALTER TABLE league_players ALTER COLUMN base_price_override DROP NOT NULL;
ALTER TABLE league_players ALTER COLUMN base_price_override SET DEFAULT NULL;
ALTER TABLE league_players ADD COLUMN tag VARCHAR(50);

CREATE TABLE league_category_base_prices (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    league_id UUID NOT NULL REFERENCES leagues(id),
    category VARCHAR(50) NOT NULL,
    price INTEGER NOT NULL,
    UNIQUE(league_id, category)
);

CREATE TABLE league_tag_base_prices (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    league_id UUID NOT NULL REFERENCES leagues(id),
    tag VARCHAR(50) NOT NULL,
    price INTEGER NOT NULL,
    UNIQUE(league_id, tag)
);
