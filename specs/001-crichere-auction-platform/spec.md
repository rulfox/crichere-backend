# Feature Specification: Crichere Auction Platform

**Feature Branch**: `001-crichere-auction-platform`  
**Created**: 2026-04-24  
**Status**: Draft  
**Input**: User description: "Build Crichere: a cricket league auction SaaS platform for India..."

## Clarifications

### Session 2026-04-24
- Q: Authentication details and entity field names? → A: OTP-only (6 digits, 5m expiry, 3 attempts), JWT (1h access, 30d opaque refresh tokens), specific field names for User, OTP, and RefreshToken entities, 3-table membership role model.
- Q: Response structure? → A: Standardized ResponseHelper with success/error signatures and specific HTTP statuses.
- Q: League and Player details? → A: Comprehensive field lists for League, LeaguePlayer, and Global Player entities. Strict status transitions for Leagues.
- Q: Auction Round and Pre-assignment? → A: Rounds are fully independent with specific config (purse, increments, eligibility). Pre-assignment rules for Captains (purse deduction) and Icons (free).
- Q: Base Price and Bulk Import? → A: 3-level priority resolution for base price. Bulk CSV import for players with ghost profile creation.
- Q: Auction State Machine and SSE? → A: Strict transitions for Auction, Round, and Player states. SSE using Redis pub/sub with `Last-Event-ID` replay. Detailed rules for Undo-Bid, Undo-Sold, and Force-Assign.
- Q: Fees, Forfeits, and Waiting List? → A: Specific entities for FeeObligations (PLAYER_FEE/FRANCHISE_FEE), ForfeitRequests (AUTO_PROMOTE vs ADMIN_PICKS), and WaitingList management with auto-shifting positions.
- Q: Notifications? → A: Push (FCM/APNs) and SMS events for all critical auction and administrative actions. Device token management for multi-platform delivery.
- Q: Flutter Architecture and Tech Stack? → A: Clean Architecture + Riverpod (AsyncNotifier). Dio/Retrofit for API, Drift for local cache. SSE via `eventsource`. Online-only auction bidding. Direct-to-S3 upload flow.
- Q: Scalability and Concurrent Auction Limits? → A: System targets 50 concurrently active auctions platform-wide for V1.
- Q: Undo-Sold rules? → A: Deterministic purse recovery (currentAmount += finalPrice), player reverts to UP_FOR_BIDDING, only allowed if PLAYER_SOLD was the absolute last action in the audit log.
- Q: Audit Log payloads? → A: Strict JSONB structures defined for all 15+ action types, including sequenceNumber, occurredAt, and actorId.
- Q: Stale SSE handling? → A: Backend filters by sequenceNumber; Flutter client discards events with sequenceNumber <= local state. Cold reconnect requires state snapshot first.
- Q: Undo-Last-Bid scope? → A: Only valid when player state is UP_FOR_BIDDING; cannot undo if sold/unsold/withdrawn; requires at least one active bid.
- Q: Auctioneer browsing? → A: Pure read operation, AUCTIONEER role required, no SSE fires until confirmed 'put' action.
- Q: Redis failure fallback? → A: PostgreSQL remains source of truth; SseBroadcaster logs error but backend continues; clients recover via AuditLog replay on reconnect.
- Q: Bulk CSV Import Matching? → A: Exact sequence: 1. Reuse ACTIVE user (link only), 2. Reuse GHOST user (link + update name), 3. Create GHOST (if no match). Handles duplicates (already_in_league).
- Q: ADMIN_PICKS Promotion? → A: League Admin can manually promote ANY entry (not just position 1). Positions recalculate (1, 2, 3...) based on createdAt ASC for remaining WAITING entries.
- Q: FeeObligation Forfeit Terminal State? → A: APPROVE forfeit sets status=WAIVED (terminal). Refunds (FULL/PARTIAL) recorded as negative FeePayment records. NO_REFUND also sets WAIVED.
- Q: Fixed-Rupee Refunds? → A: All refund decisions use fixed rupee integers, never percentages. Validated as 0 <= amount <= paidAmount.
- Q: Waiting List Concurrency? → A: Recalculation uses PESSIMISTIC_WRITE row-level locking (SELECT ... FOR UPDATE) and a partial unique index on (leagueId, position) WHERE status = WAITING.
- Q: UI Connectivity Feedback? → A: SnackBar blocks auction writes when connectivity_plus reports offline. No automatic retries; manual reconnect required for SSE connection error.
- Q: SSE Reconnection? → A: Exponential backoff (2s to 30s cap) with unlimited retries. Re-fetches state snapshot before re-opening SSE to ensure gapless sequence synchronization.
- Q: Drift Sync Rules? → A: Offline READ cache only; independent per device/tab. Auction state is never cached locally. Invalidate on league `AUCTION_LIVE` or foreground resume.
- Q: Push Notification Handling? → A: FCM HIGH priority for auction events. Background: system notification + deep link. Foreground: in-app banner/SnackBar only (no system notification).
- Q: Secure Storage on 401? → A: If token refresh fails on 401, clear flutter_secure_storage and Drift cache, then replace all routes with PhoneEntryScreen.
- Q: SSE Latency Measurement? → A: Measured from backend publish to client StreamProvider emission. Validated via JMeter/Gatling with Linux TC (3G/4G simulation). 95th percentile target < 500ms on 4G.
- Q: S3 Upload Restrictions? → A: Max sizes: Photo (5MB), Logo/Banner (10MB), PDF (50MB). Restricted to JPEG/PNG/WebP and PDF. Enforced via backend presigned URL and S3 bucket policy.
- Q: Shimmer Logic? → A: Show only if data > 300ms and no cache available. 1200ms duration, max 10 items. 10s timeout to error state.
- Q: Web Accessibility? → A: Live regions for bids/sales via Semantics. Keyboard focus moves to franchise selector on player up. Ctrl+Z for undo on web.

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

### User Story 4 - Fee and Forfeit Management (Priority: P2)

As a League Admin, I want to manage fee obligations and player forfeits so that the league's financial and participant records remain accurate.

**Why this priority**: Essential for operational management of semi-pro leagues.

**Independent Test**: Admin records a cash payment for a player's fee. Verification: Player's `paidAmount` updates and status moves toward `PAID`.

**Acceptance Scenarios**:

1. **Given** a player has a `FeeObligation`, **When** the Admin records a `FeePayment`, **Then** the player's `auctionEligible` status is updated if the `minimumToRegister` threshold is met.
2. **Given** a `ForfeitRequest` is APPROVED in an `AUTO_PROMOTE` league, **When** the resolution is processed, **Then** the next user on the `WaitingList` is automatically promoted and a `FeeObligation` is created for them.
3. **Given** a franchise has multiple members, **When** a `PLAYER_SOLD` event occurs, **Then** all registered members of that franchise receive a push notification.

### Edge Cases

- **OTP Expiry/Rate Limiting**: What happens if a user requests too many OTPs or uses an expired one? (System enforces 5 sends/hour and 3 verification attempts; previous OTPs expire immediately on new send).
- **SSE Disconnection & Replay**: How does the client recover missed events? (Client sends `Last-Event-ID` header; server replays all `AuditLog` entries with `sequenceNumber > Last-Event-ID`. Stale events with `sequenceNumber <= local state` are discarded by the client).
- **Undo Sold after Purse Change**: What happens if an "Undo Sold" is performed but the franchise no longer has the original purse state? (Restoration is deterministic: `currentAmount += finalPrice`. Only allowed if `PLAYER_SOLD` was the absolute last auction action).
- **Simultaneous Bids**: Auctioneer records a bid just as another franchise claims they bid first verbally. (Human auctioneer model: Auctioneer is the sole writer; their recording is final).
- **Pre-assignment Conflict**: What happens if an admin tries to pre-assign a player who is already sold? (System returns a 409 Conflict error; pre-assignment only allowed for AVAILABLE players).
- **Insufficient Purse**: What happens if a bid exceeds the current purse? (System throws `InsufficientPurseException` during validation).
- **Waiting List Promotion & Concurrency**: What happens to the waiting list when multiple people withdraw simultaneously? (Recalculation is serialized via pessimistic DB locking; positions auto-shift based on `createdAt ASC` to ensure gapless numbering).
- **Network Loss during Auction**: What happens if the Auctioneer loses connection while recording a bid? (Auction bidding is ALWAYS online-only; SnackBar blocks the call immediately if `connectivity_plus` reports offline. No automatic queuing; manual retry required for SSE connection errors).
- **SSE Auto-Reconnection**: How does the app handle unstable connections? (Uses exponential backoff: 2s, 4s, 8s, 16s, capped at 30s. Unlimited retries. Re-fetches full state snapshot before re-opening SSE with `after=currentSequenceNumber`).
- **Token Refresh & Storage Clearing**: What happens if a session is invalidated (401) and refresh fails? (Interceptor clears `flutter_secure_storage` and `Drift` cache, then redirects user to login using `auto_route` replaceAll).
- **Redis Infrastructure Failure**: What happens if Redis pub/sub is unavailable? (PostgreSQL remains source of truth; SseBroadcaster logs error but backend continues; clients recover via AuditLog replay on reconnect).

## Requirements *(mandatory)*

### Auction State Machine

- **Auction Status**: `DRAFT` → `LIVE` → `PAUSED` → `LIVE` (resume) → `COMPLETED`
- **Round Status**: `PENDING` → `LIVE` → `COMPLETED`
- **Player Auction State**: `AVAILABLE` → `UP_FOR_BIDDING` → `SOLD` / `UNSOLD` / `WITHDRAWN` / `FORCE_ASSIGNED`. Special state: `PRE_ASSIGNED`.

### Functional Requirements

- **FR-001**: System MUST support OTP-only authentication for Indian phone numbers (`^[6-9]\d{9}$`).
- **FR-002**: OTPs MUST be 6 digits, valid for 5 minutes, and allow max 3 verification attempts. Rate-limited to 5 sends per hour per phone.
- **FR-003**: JWT Access tokens valid for 1 hour; Refresh tokens are opaque UUIDs valid for 30 days, stored in `refresh_tokens` table.
- **FR-004**: System MUST provide an append-only `AuctionAuditLog` with monotonically increasing sequence numbers per auction. Every entry MUST include a specific JSONB payload (e.g., `leaguePlayerId`, `franchiseId`, `amount`, `sequenceNumber`, `occurredAt`, `actorId`) as defined in the technical documentation.
- **FR-005**: System MUST use Server-Sent Events (SSE) for all live auction updates via Spring `SseEmitter` and Redis pub/sub.
- **FR-006**: System MUST store all money values as whole Indian Rupee (INR) integers.
- **FR-007**: System MUST support three player order modes: RANDOM, FREE_PICK, and HYBRID (League level config).
- **FR-008**: System MUST allow League Admins to pre-assign Captains (purse deduction) and Icon players (free).
- **FR-009**: System MUST provide "Undo last bid" (only when player is `UP_FOR_BIDDING`) and "Undo sold" (only if it was the absolute last audit action) with mandatory reason logging and deterministic state restoration.
- **FR-010**: System MUST support Force-Assign by League Admin (bypasses purse validation, price defaults to 0).
- **FR-011**: System MUST support bulk CSV import for player profiles with phone-matching sequence (Reuse ACTIVE > Reuse GHOST > Create GHOST).
- **FR-012**: Base price resolution order: 1. `basePriceOverride` (LeaguePlayer) → 2. `LeagueTagBasePrice` → 3. `LeagueCategoryBasePrice`.
- **FR-013**: Fee management MUST track `PLAYER_FEE` and `FRANCHISE_FEE` obligations and record `CASH` payments. Forfeit approvals MUST set obligations to terminal `WAIVED` state with fixed-rupee refunds.
- **FR-014**: Forfeit system MUST support `AUTO_PROMOTE` logic (automatic next) and `ADMIN_PICKS` logic (manual override). Position recalculation MUST be gapless and createdAt-ordered.
- **FR-015**: System MUST deliver push notifications (FCM/APNs) for critical events like `AUCTION_STARTED`, `PLAYER_SOLD`, and `FEE_PAYMENT_RECORDED`.
- **FR-016**: API responses MUST use `ResponseHelper.success` or `ResponseHelper.error`.
- **FR-017**: Auction bidding operations MUST be online-only; no offline queuing for auction recording actions.
- **FR-018**: File uploads (photos, PDFs) MUST follow the direct-to-S3 flow using presigned URLs. Max sizes: Profile (5MB), Logo/Banner (10MB), PDF (50MB). Formats restricted to JPEG/PNG/WebP for images and PDF for documents. Enforced at both client (pre-validation) and backend (bucket policy).

### Key Entities *(include if feature involves data)*

- **User**: Global identity with `profilePhoto`, `playingRole`, and `profileStatus`.
- **Player (Global)**: `id`, `userId`, `phone`, `name`, `playingRole`, `battingStyle`, `bowlingStyle`, `basePrice`.
- **League**: Fields: `name`, `format`, `rulesUrl`, `status`, `mustSellAll`, `playerOrderMode`, `waitingListMode`.
- **Auction**: `id`, `leagueId` (unique), `auctioneerId`, `status`, `currentRoundId`, `currentLeaguePlayerId`.
- **PlayerAuctionState**: `id`, `auctionId`, `leaguePlayerId`, `state`, `currentHighestBid`, `finalPrice`.
- **FranchisePurseState**: `id`, `franchiseId`, `roundId`, `startingAmount`, `currentAmount`, `reservedAmount`.
- **FeeObligation**: `id`, `leagueId`, `userId`, `franchiseId`, `feeType`, `totalAmount`, `minimumToRegister`, `paidAmount`, `status` (UNPAID, PARTIALLY_PAID, PAID, WAIVED).
- **FeePayment**: `id`, `obligationId`, `amount`, `paymentMode` (CASH, ONLINE), `recordedBy`.
- **ForfeitRequest**: `id`, `leagueId`, `userId`, `type` (PLAYER, FRANCHISE), `status` (PENDING, APPROVED, REJECTED, CANCELLED), `feeRefundDecision`.
- **WaitingList**: `id`, `leagueId`, `userId`, `position`, `status` (WAITING, PROMOTED, REJECTED, WITHDRAWN).
- **AuctionAuditLog**: `id`, `auctionId`, `sequenceNumber`, `action`, `payload` (JSONB), `actorId`.
- **DeviceToken**: `id`, `userId`, `token`, `platform` (ANDROID, IOS, WEB).
- **InAppNotification**: `id`, `userId`, `type`, `title`, `body`, `payload`, `readAt`.
- **Membership Tables**: `UserPlatformMembership`, `UserLeagueMembership`, `UserFranchiseMembership`.

## Constraints & Tradeoffs

### Technical Constraints
- **Framework**: Flutter (Single codebase for Android, iOS, and Web).
- **State Management**: Riverpod (AsyncNotifier/AsyncValue) for all async state; Freezed for immutable state classes.
- **API Client**: Dio + Retrofit (code-generated) with JWT interceptors and refresh token logic.
- **Local Storage**: Drift (SQLite) for offline READ caching (leagues, players, notifications); no bidirectional sync. Independent cache per device/tab. Invalidate on league `AUCTION_LIVE` or foreground resume.
- **Navigation**: `auto_route` with `AutoRouteGuard` for role-based access and deep linking.
- **Architecture**: Feature-first hybrid Clean Architecture (`core/`, `features/`, etc.).
- **Security**: `flutter_secure_storage` for JWTs; never expose AWS credentials to the client. All environment-specific values (API base URL, environment name) are injected at build time via `--dart-define-from-file=config/<env>.json` and read through `AppConfig` (`String.fromEnvironment`). `config/prod.json` and `config/staging.json` are gitignored and must be injected by CI/CD; `config/dev.json` (localhost) is committed. `LogInterceptor` is gated on `kDebugMode` to prevent token and request body leakage in production builds.
- **Real-time**: SSE via `eventsource` feeding into Riverpod `StreamProvider`. Redis channels MUST be partitioned per auctionId. SseEmitter pings sent every 15 seconds. Gzip compression MUST be disabled for SSE streams.
- **Assets**: Direct-to-S3 upload (Presigned URL) with no AWS SDK on the client.
- **Notifications**: FCM HIGH priority for auction events (PLAYER_SOLD, etc.). Background: system notification + deep link. Foreground: in-app banner/SnackBar only.
- **Accessibility (Web)**: Auctioneer panel MUST use Flutter Semantics for live region announcements (bids, sales). Full keyboard focus management required (tab order: Player -> Franchise -> Bid -> Record).

### Design Constraints
- **Regional Targets**: Optimized for mid-range Indian Android devices.
- **Auctioneer Panel**: Optimized for Web (wider desktop layout). Active bid indicators MUST use icons/labels, not color alone (WCAG AA).
- **Mobile Experience**: Portrait-first. Utilizes Lottie and Shimmer.
- **Shimmer Logic**: Display if data fetch > 300ms and no cache available. Max 10 items. Timeout to error state with "Retry" button after 10s. Show cached data immediately on resume/return (stale-while-revalidate).

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Auction updates reach all connected viewers in under 500ms (95th percentile on 4G) via SSE. Measurement: server publish timestamp to client emission. Validated with 5,000 simulated connections.
- **SC-002**: 100% of auction actions are recorded in the `AuctionAuditLog` with correct sequence numbers.
- **SC-003**: Waiting list positions are recalculated with 100% accuracy upon any promotion or withdrawal.
- **SC-004**: Notifications are dispatched by the backend to FCM/APNs gateways within 1 second of the triggering event.
- **SC-005**: Shareable squad images are generated at 1080x1080 pixels (PNG) for optimal WhatsApp sharing.
- **SC-006**: System handles up to 5,000 concurrent viewers per active auction without degradation in message latency.
- **SC-007**: System supports at least 50 concurrently active auctions across the entire platform.

## Assumptions

- **SMS Provider**: MSG91 will be the primary provider for OTP and invite links.
- **Push Provider**: FCM (Android) and APNs (iOS) will be used for mobile notifications.
- **Storage**: All media assets (logos, PDFs) will be stored in S3 via presigned URL uploads from the client.
- **Infrastructure**: Deployment will be in the AWS Mumbai (`ap-south-1`) region; Redis used for SSE broadcasting.
- **Payment Scope**: V1 implementation handles cash/offline fee tracking only; Razorpay is V2.
- **Auction Environment**: High-speed internet is assumed for the Auctioneer's device to ensure real-time command delivery.
- **Build Config**: All Flutter builds MUST pass `--dart-define-from-file=config/<env>.json`. Keys: `API_BASE_URL` (full base URL including `/api/v1`), `ENV` (`dev` | `staging` | `prod`). The `config/example.json` in the repo serves as the canonical key reference for CI/CD secret setup.


