# Requirement Quality Checklist: Platform Quality

**Purpose**: Validate specification completeness and quality for Crichere platform integrity
**Created**: 2026-04-24
**Updated**: 2026-04-26
**Feature**: [specs/001-crichere-auction-platform/spec.md](../spec.md)

## Real-Time Auction Integrity

- [x] CHK001 Are deterministic state restoration rules defined for "Undo Sold" when round purses have changed? [Consistency, Spec §Edge Cases]
- [x] CHK002 Is the payload structure for every `AuctionAuditLog` action explicitly defined to ensure SSE replay accuracy? [Completeness, Spec §FR-004]
- [x] CHK003 Are requirements defined for handling stale SSE events (sequenceNumber < current state) on the client? [Coverage, Spec §Edge Cases]
- [x] CHK004 Is the "Undo Last Bid" logic restricted to the *active* player-up session only? [Clarity, Spec §FR-009]
- [x] CHK005 Are requirements defined for auctioneer "browsing" state to ensure viewers do not receive premature SSE events? [Completeness, Spec §Clarifications]
- [x] CHK006 Is the fallback behavior specified for when the Redis pub/sub channel is momentarily unavailable? [Gap, Spec §Infrastructure]
- [x] CHK021 Are concurrent bid write conflicts handled with optimistic locking on `PlayerAuctionState` and `FranchisePurseState`? [Consistency] — resolved via `@Version` on auction entities + Flyway migration V015

## Administrative Workflows

- [x] CHK007 Are the specific data mapping rules defined for Bulk CSV import when a phone number is partially matched (e.g., ghost vs active)? [Clarity, Spec §FR-011]
- [x] CHK008 Is the promotion logic for `ADMIN_PICKS` mode quantified with manual override permissions? [Completeness, Spec §FR-014]
- [x] CHK009 Are requirements defined for the terminal state of a `FeeObligation` when a player is removed via Forfeit? [Consistency, Spec §FR-013/014]
- [x] CHK010 Are fee refund calculations (FULL/PARTIAL/NONE) defined as fixed values or percentage-based? [Clarity, Spec §FR-014]
- [x] CHK011 Is the position decrement logic for the `WaitingList` verified to handle concurrent withdrawals? [Consistency, Spec §Edge Cases]

## Mobile & Offline Resilience

- [x] CHK012 Are requirements defined for UI feedback when an "Online-Only" auction action is attempted without connectivity? [Completeness, Spec §FR-017]
- [x] CHK013 Is the auto-reconnection strategy for SSE quantified with specific retry intervals and backoff limits? [Clarity, Spec §Edge Cases]
- [x] CHK014 Are local cache (Drift) synchronization rules defined for when a user switches between mobile and web? [Coverage, Spec §Technical Constraints]
- [x] CHK015 Does the spec define behavior for foreground vs background push notification handling on mid-range Android devices? [Coverage, Spec §Regional Targets]
- [x] CHK016 Are requirements specified for clearing `flutter_secure_storage` when a session is invalidated by the backend (401 error)? [Completeness, Spec §Technical Constraints]

## Non-Functional & Regional Quality

- [x] CHK017 Are latency targets (500ms) measurable under simulated 3G/4G Indian network conditions? [Measurability, Spec §SC-001]
- [x] CHK018 Is the direct-to-S3 upload flow quantified with file size and type restrictions? [Clarity, Spec §FR-018]
- [x] CHK019 Are requirements defined for "Shimmer" loading states to handle varying latency across different Indian regions? [Consistency, Spec §Design Constraints]
- [x] CHK020 Are accessibility requirements specified for the Auctioneer Panel's web-specific layout (e.g., screen reader support for live bids)? [Gap]

## Production Readiness (added 2026-04-26)

- [x] CHK022 Is CORS configured with explicit allowed origins (not wildcard) when `allowCredentials=true`? — resolved: `CORS_ALLOWED_ORIGINS` env var, no wildcard
- [x] CHK023 Are all inbound request DTOs validated with bean constraints (`@NotBlank`, `@Positive`, `@Email`, etc.) at the controller boundary? — resolved: 25 `@Valid @RequestBody` bindings across all controllers; `GlobalExceptionHandler` returns structured 400 responses
- [x] CHK024 Is the application containerized with a reproducible Docker image? — resolved: multi-stage `Dockerfile` at repo root, non-root `spring` user, JVM container memory flags
- [x] CHK025 Is there a CI pipeline that runs tests automatically on every PR and push to main? — resolved: `.github/workflows/ci.yml` (test + Docker build jobs)
- [x] CHK026 Are Actuator management endpoints access-controlled in production? — resolved: `/actuator/health` public, all others require `PLATFORM_ADMIN` role; `show-details: when_authorized`
- [x] CHK027 Is Swagger UI disabled in the production profile? — resolved: `springdoc.swagger-ui.enabled: false` in `application-prod.yml`
- [x] CHK028 Does logout invalidate the active access token as well as refresh tokens? — resolved: access token is added to a Redis blacklist with TTL = remaining token validity; filter checks blacklist on every request
- [x] CHK029 Are all secrets required (no silent defaults) when running with the prod Spring profile? — resolved: sensitive vars in `application-prod.yml` have no `:default` fallback; app fails to start if unset
- [x] CHK030 Is structured logging with request ID tracing in place for production observability? — resolved: `logback-spring.xml` (JSON in prod, plain in dev); `RequestIdFilter` stamps `X-Request-ID` on every request/response and MDC
- [x] CHK031 Are Prometheus metrics exposed for key business events (OTPs, bids, auctions)? — resolved: `micrometer-registry-prometheus` added; five custom counters registered; `/actuator/prometheus` endpoint enabled
