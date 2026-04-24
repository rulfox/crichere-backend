# Data Model: Crichere Auction Platform

## Global Entities

### User
| Field | Type | Rules |
|-------|------|-------|
| id | UUID | PK, gen_random_uuid() |
| phone | VARCHAR(15) | UNIQUE, NOT NULL, ^[6-9]\d{9}$ |
| profileStatus | ENUM | GHOST, CLAIMED, ACTIVE |
| profilePhoto | VARCHAR(500) | S3 URL |
| playingRole | ENUM | BATTER, BOWLER, ALL_ROUNDER, WICKET_KEEPER |

### Player
| Field | Type | Rules |
|-------|------|-------|
| id | UUID | PK |
| userId | UUID | FK -> User (nullable) |
| phone | VARCHAR(15) | NOT NULL |
| name | VARCHAR(100) | NOT NULL |

## League Context

### League
| Field | Type | Rules |
|-------|------|-------|
| id | UUID | PK |
| status | ENUM | DRAFT -> PUBLISHED -> AUCTION_LIVE -> COMPLETED -> ARCHIVED |
| mustSellAll | BOOLEAN | Default false |
| playerOrderMode | ENUM | RANDOM, FREE_PICK, HYBRID |

### LeaguePlayer (Junction)
| Field | Type | Rules |
|-------|------|-------|
| id | UUID | PK |
| leagueId | UUID | FK -> League |
| playerId | UUID | FK -> Player |
| auctionEligible | BOOLEAN | Default true |
| assignmentType | ENUM | CAPTAIN, ICON (nullable) |

### Franchise
| Field | Type | Rules |
|-------|------|-------|
| id | UUID | PK |
| leagueId | UUID | FK -> League |
| name | VARCHAR(100) | NOT NULL |

## Auction Subsystem

### Auction
| Field | Type | Rules |
|-------|------|-------|
| id | UUID | PK |
| leagueId | UUID | FK -> League (UNIQUE) |
| status | ENUM | DRAFT, LIVE, PAUSED, COMPLETED |

### AuctionRoundConfig
| Field | Type | Rules |
|-------|------|-------|
| id | UUID | PK |
| auctionId | UUID | FK -> Auction |
| roundNumber | INT | NOT NULL |
| purseAmount | INT | Whole INR |

### FranchisePurseState
| Field | Type | Rules |
|-------|------|-------|
| id | UUID | PK |
| franchiseId | UUID | FK -> Franchise |
| roundId | UUID | FK -> AuctionRoundConfig |
| currentAmount | INT | Validated on every bid |

### AuctionAuditLog
| Field | Type | Rules |
|-------|------|-------|
| id | UUID | PK |
| auctionId | UUID | FK -> Auction |
| sequenceNumber | BIGINT | Monotonically increasing |
| action | ENUM | PLAYER_UP, BID_PLACED, PLAYER_SOLD, etc. |
| payload | JSONB | Event snapshot |

## Membership Tables
- **UserPlatformMembership**: `userId`
- **UserLeagueMembership**: `userId`, `leagueId`, `role` (LEAGUE_ADMIN, AUCTIONEER)
- **UserFranchiseMembership**: `userId`, `franchiseId` (Owner)

## Fee & Forfeit
- **FeeObligation**: Tracks `PLAYER_FEE` or `FRANCHISE_FEE`.
- **ForfeitRequest**: `status` (PENDING, APPROVED, REJECTED, CANCELLED).
- **WaitingList**: `position` auto-shifts on promotion/withdrawal.
