# Feature Specification: Crichere Auction Platform

**Feature Branch**: `001-crichere-auction-platform`  
**Created**: 2026-04-24  
**Status**: Draft  
**Input**: User description: "Build Crichere: a cricket league auction SaaS platform for India..."

## User Scenarios & Testing *(mandatory)*

### User Story 1 - League Configuration (Priority: P1)

As a League Admin, I want to create and configure my cricket league so that I can manage players, franchises, and auction rules in one place.

**Why this priority**: Fundamental requirement to start any auction process.

**Independent Test**: Admin creates a league, uploads a logo, sets T20 format, and saves configuration. Verification: League details appear correctly in the admin dashboard.

**Acceptance Scenarios**:

1. **Given** I am a logged-in League Admin, **When** I enter league details (Name, Format: T20, Rules PDF), **Then** the league is created and the rules PDF is accessible via a presigned URL.
2. **Given** a league exists, **When** I configure auction rules (PlayerOrderMode: RANDOM, mustSellAll: true), **Then** these settings are persisted and will govern the live auction.

---

### User Story 2 - Real-Time Auction (Priority: P1)

As an Auctioneer, I want to conduct a live auction with real-time updates for all viewers so that bidding is transparent and recorded accurately.

**Why this priority**: Core value proposition of the platform.

**Independent Test**: Auctioneer puts a player up for bid. Viewers see "Waiting" then the player details. Auctioneer records a bid. Viewers see the bid update instantly.

**Acceptance Scenarios**:

1. **Given** an auction round is active, **When** the Auctioneer selects "Player Up", **Then** an SSE event is fired to all connected viewers with player details.
2. **Given** a player is up for bid, **When** the Auctioneer records a bid for "Franchise A", **Then** the leading franchise and bid amount update instantly for all viewers without page refresh.
3. **Given** a player is sold, **When** the Auctioneer marks "SOLD", **Then** the franchise purse is deducted and the AuctionAuditLog records the transaction.

---

### User Story 3 - Player Registration & Ghost Claiming (Priority: P1)

As a Player, I want to register and claim my profile so that my historical performance and auction status are linked to my account.

**Why this priority**: Ensures data integrity and user engagement.

**Independent Test**: Player enters phone number, receives OTP, and is presented with a pre-created ghost profile matching their name.

**Acceptance Scenarios**:

1. **Given** an Admin has created a ghost profile for "John Doe" with phone "9876543210", **When** John registers with that phone, **Then** his profile becomes ACTIVE and he sees his league history.
2. **Given** a player is registered, **When** they update their bowling style, **Then** the change is reflected globally across all leagues they participate in.

---

### User Story 4 - Franchise Management & Owner Invite (Priority: P2)

As a League Admin, I want to invite Franchise Owners via SMS links so that they can manage their squads and participate in the auction.

**Why this priority**: Necessary for multi-party participation.

**Independent Test**: Admin generates an invite link for a franchise. Owner clicks link, installs app, and is automatically linked to the franchise.

**Acceptance Scenarios**:

1. **Given** a franchise exists, **When** the Admin sends an SMS invite, **Then** a unique deep link is generated with a 7-day expiry.
2. **Given** an owner uses a valid invite link, **When** they complete OTP verification, **Then** they gain owner permissions for that specific franchise.

### Edge Cases

- **SSE Disconnection**: How does the viewer app handle a momentary loss of SSE connection? (Should automatically reconnect and sync with the latest `sequenceNumber`).
- **Undo Sold after Purse Change**: What happens if an "Undo Sold" is performed but the franchise no longer has the original purse state? (Principles mandate `FranchisePurseState` per round, so state restoration should be deterministic).
- **Simultaneous Bids**: Auctioneer records a bid just as another franchise claims they bid first verbally. (Human auctioneer model: Auctioneer is the sole writer; their recording is final).

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: System MUST support OTP-only authentication for Indian phone numbers (`^[6-9]\d{9}$`).
- **FR-002**: System MUST provide an append-only `AuctionAuditLog` with monotonically increasing sequence numbers.
- **FR-003**: System MUST use Server-Sent Events (SSE) for all live auction updates; WebSockets are prohibited.
- **FR-004**: System MUST store all money values as whole Indian Rupee (INR) integers.
- **FR-005**: System MUST support three player order modes: RANDOM, FREE_PICK, and HYBRID.
- **FR-006**: System MUST allow League Admins to pre-assign Captains (purse deduction) and Icon players (free).
- **FR-007**: System MUST provide "Undo last bid" and "Undo sold" actions with mandatory reason logging.
- **FR-008**: System MUST support bulk CSV import for player profiles.
- **FR-009**: System MUST generate shareable squad images (PNG/JPG) for Franchise Owners.
- **FR-010**: System MUST handle "mustSellAll" logic, allowing fallback manual assignment by the Auctioneer.

### Key Entities *(include if feature involves data)*

- **User**: Global entity, phone-based identity.
- **Player**: Global entity linked to User; contains cricket-specific stats and profile.
- **League**: Top-level container for an auction event; contains configuration and rules.
- **Franchise**: Belonging to a League; has a purse, owner(s), and a squad.
- **AuctionRound**: Specific phase of a league auction with its own bidding rules and purse states.
- **AuctionAuditLog**: Monotonic log of every bid, sale, and administrative action during an auction.
- **FranchisePurseState**: Snapshots of a franchise's available balance at specific points/rounds.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Auction updates (bid, player up, sold) reach all connected viewers in under 500ms via SSE.
- **SC-002**: 100% of auction actions are recorded in the `AuctionAuditLog` with correct sequence numbers.
- **SC-003**: 99.9% of players can register and claim ghost profiles using only their phone number and OTP.
- **SC-004**: System handles up to 5,000 concurrent viewers per active auction without degradation in message latency.

## Assumptions

- **SMS Provider**: MSG91 will be the primary provider for OTP and invite links.
- **Storage**: All media assets (logos, PDFs) will be stored in S3 via presigned URL uploads from the client.
- **Infrastructure**: Deployment will be in the AWS Mumbai (`ap-south-1`) region to minimize latency for Indian users.
- **Payment Scope**: V1 implementation handles cash/offline fee tracking only; Razorpay is V2.
- **Auction Environment**: High-speed internet is assumed for the Auctioneer's device to ensure real-time command delivery.
