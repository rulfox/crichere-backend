# Backend Audit — Tasks TODO

Tracking implementation of fixes from the architectural audit (2026-05-29).

Legend: `[ ]` pending · `[~]` in progress · `[x]` done

---

## Phase 1 — Critical SSE & Scheduling Fixes  ✅ DONE

- [x] **P1.1** Add `@EnableScheduling` and `@EnableAsync` to `CrichereApplication`
- [x] **P1.2** Fix SSE first-byte race: send snapshot → replay → register emitter (AuctionSseController + DisplayController)
- [x] **P1.3** Add SSE response headers: `Cache-Control: no-cache, no-transform`, `X-Accel-Buffering: no`, `retry:` directive
- [x] **P1.4** Accept `lastEventId` as both header and query param (mobile clients)
- [x] **P1.5** Push SSE broadcast loop off the Redis-listener thread via a dedicated executor
- [x] **P1.6** Harden `sendKeepAlive` to catch `Throwable` (not just `IOException`)
- [x] **P1.7** Defensive UUID parsing in Redis message listener
- [x] **P1.8** Tune `spring.mvc.async.request-timeout: -1` + raise Tomcat threads in `application.yml`

## Phase 2 — Data Integrity & Race Conditions  ✅ DONE

- [x] **P2.1** Add per-auction `next_sequence_number` column on `auctions` (V028); atomic `UPDATE…RETURNING` in `logAndBroadcast` via EntityManager
- [x] **P2.2** Timer-expiry scheduler `TimerExpiryScheduler` (ShedLock-gated, V029 backing table); auto-sells to top bidder or marks UNSOLD
- [x] **P2.3** Fix `undoSold` payload comparison (UUID `.toString()` on both sides)
- [x] **P2.4** `completeAuction` rejects non-LIVE/PAUSED entry states
- [x] **P2.5** Carry-over purse fallback now uses `totalPurse` not `remainingPurse`
- [x] **P2.6** `undoSold` now finds last `PLAYER_SOLD` event (skipping TIMER_* entries) rather than relying on log tail ordering

## Phase 3 — Authorization Hardening  ✅ DONE

- [x] **P3.1** `AuctionAuthorization` bean (`@auctionAuth`) with `canManage` + `canView`
- [x] **P3.2** `UserDetailsServiceImpl` emits scoped `ROLE_AUCTIONEER_<auctionId>` for league auctioneers
- [x] **P3.3** All 26 mutation endpoints in `AuctionController` now use `@auctionAuth.canManage(#id, authentication)`
- [x] **P3.4** `/public/**` restricted to `HttpMethod.GET` only
- [x] **P3.5** `AuctionSseController.streamEvents` requires `@auctionAuth.canView`
- [x] **P3.6** Kept UUID-direct public events for projector use (entropy-equivalent to token); other mutating public paths blocked by GET-only restriction
- [x] **P3.7** `WaitingListController` admin endpoints scoped to `LEAGUE_ADMIN_<leagueId>`
- [x] **P3.8** `CorsConfig` validates `allowed-origins` at startup — empty rejected, `*` warned (pattern form is legal with `allowCredentials=true` in `application-dev.yml`)

## Phase 4 — Missing Endpoints & Frontend Data Gaps  ✅ DONE

- [x] **P4.1** `getRounds` / `getRound` now return real `bidIncrementSlabs` via `getRoundSlabs`
- [x] **P4.2** `FranchisePurseStateResponse` carries `franchiseName` + `franchiseLogoUrl`; `getStateSnapshot` populates both
- [x] **P4.3** `GET /leagues/{id}/auctions` returning auction summaries
- [x] **P4.4** `PATCH /auctions/{id}/cancel` (+ `AuctionStatus.CANCELLED`, `AuctionAction.AUCTION_CANCELLED`)
- [x] **P4.5** `PATCH /auctions/{id}/timer/extend` (+ `AuctionAction.TIMER_EXTENDED`, `TimerExtendRequest` DTO)
- [x] **P4.6** `GET /users/{id}/franchises` returns owned + member-of franchises
- [x] **P4.7** `GET /notifications/unread-count`
- [x] **P4.8** `GET /public/auctions/view/{token}/status` (added during Phase 1 SSE rework)
- [x] **P4.9** `exportFranchiseSquadPdf` — proper per-franchise squad PDF
- [x] **P4.10** Typed DTOs for auction mutations: `PauseAuctionRequest`, `CancelAuctionRequest`, `PutPlayerRequest`, `UndoBidRequest`, `UnsoldPlayerRequest`, `WithdrawPlayerRequest`, `UpdatePlayerPoolRequest`. Remaining low-traffic admin Maps (suspend, role, photo, waive, reject) deferred to Phase 5.

## Phase 5 — Code Quality & Bug Sweep  ✅ DONE

- [x] **P5.1** `GlobalExceptionHandler` logs full stack at ERROR + returns generic message with `requestId` from MDC
- [x] **P5.2** `FranchiseService.getSquad` returns real `roundNumber` via `AuctionRoundConfigRepository.findAllById`
- [x] **P5.3** `acceptInvite` is now an idempotent membership add — no silent owner overwrite
- [x] **P5.4** New `notifyPlayerAcquired` template for franchise owners; `sellPlayer` uses it
- [x] **P5.5** `LeagueResponse.auctionId` → `auctionIds: List<UUID>`; all call sites updated
- [x] **P5.6** `DisplayController` HTML interpolation now uses `HtmlUtils.htmlEscape`
- [x] **P5.7** Providers were already `@Profile`-gated (dev vs prod) — no external SDK init at startup; verified

---

## Out of scope for this pass

- Adding `roundId` to `PlayerAuctionState` (data-model migration; needs business review)
- Allowing `FRANCHISE_OWNER` to self-place bids (requires bid-mode redesign)
- Replacing `DELETE /notifications/device-token` body with path param (breaking API change)
- Typing the remaining `Map<String,*>` request bodies on low-traffic admin endpoints (suspend, role, photo, waive, reject)

---

## Verification

- `./gradlew compileKotlin` — clean, only deprecation warnings.
- `./gradlew test --tests "*ServiceTest" --tests "*ControllerTest"` — **41 tests, 0 failures, 100% pass.**
- Integration tests requiring TestContainers (`FullAuctionLifecycleIntegrationTest`, `E2EAuctionFlowTest`, `AuthIntegrationTest`) not run in this session — depend on Docker.

## Files added

- `src/main/kotlin/com/crichere/security/AuctionAuthorization.kt`
- `src/main/kotlin/com/crichere/config/ShedLockConfig.kt`
- `src/main/kotlin/com/crichere/domain/auction/service/TimerExpiryScheduler.kt`
- `src/main/resources/db/migration/V028__add_auction_next_sequence_number.sql`
- `src/main/resources/db/migration/V029__create_shedlock_table.sql`

---

## Phase 6 — Production Hardening (skipping #2 Firebase/MSG91)  ✅ DONE

- [x] **P6.1** `JwtSecretGuard` — fails-fast in `prod` profile if secret is blank, shorter than 32 chars, or equals the published default. WARNs in non-prod.
- [x] **P6.3** UserDetails authority is recomputed each request; N+1 over leagues collapsed into a single batched `findAllByLeagueIdIn` query.
- [x] **P6.4** Redis-backed `OtpRateLimiter` — per-phone burst (1/30s) + daily cap (20/day) + per-IP throttle (10/min, 100/day) for `/auth/otp/send`; per-phone 5/5min + per-IP 20/min for `/auth/otp/verify`. Fails open if Redis is down (DB cap + entity attempts cap still apply).
- [x] **P6.5** Integration tests green: 66 total (41 unit + 25 integration) — `AuthIntegrationTest`, `FullAuctionLifecycleIntegrationTest`, `E2EAuctionFlowTest` all pass under TestContainers.
- [x] **P6.6** V030 adds `round_id` to `player_auction_states` (+ index); service tags it on every state transition; `UNSOLD_PREVIOUS_ROUND` now filters precisely.
- [x] **P6.7** Hikari tuned in `application.yml` (max 30, min idle 5, leak-detection 30s, named pool). `/actuator/prometheus` already exposed; counters `crichere.auction.*`, `crichere.auction.bids.placed`, `crichere.auction.players.sold`, `crichere.otp.sent/verified` available for scrape. Grafana boards left to operator.
- [x] **P6.8** `.github/workflows/ci.yml` — unit tests on every PR/push, integration tests as a follow-up job.
- [x] **P6.9** `AuditLogRetentionScheduler` — nightly cron (03:15) ShedLock-coordinated, deletes audit-log rows for COMPLETED/CANCELLED auctions older than `crichere.audit-log.retention-days` (default 90).
- [x] **P6.10** `load-test/sse-load-test.js` rewritten for the current API: optional JWT, correct `/public/auctions/{id}/events` endpoint, parses snapshot vs bid events, reports connect-latency percentiles.

### Files added in Phase 6

- `src/main/kotlin/com/crichere/config/JwtSecretGuard.kt`
- `src/main/kotlin/com/crichere/security/OtpRateLimiter.kt`
- `src/main/kotlin/com/crichere/domain/auction/service/AuditLogRetentionScheduler.kt`
- `src/main/resources/db/migration/V030__add_round_id_to_player_auction_states.sql`
- `.github/workflows/ci.yml`

### Operator notes

- **JWT secret**: must set `JWT_SECRET` env var to a strong random value ≥ 32 chars before deploying with `SPRING_PROFILES_ACTIVE=prod`. Otherwise startup fails.
- **Audit log retention**: tune `crichere.audit-log.retention-days` per data-retention policy.
- **Hikari**: scale `DB_POOL_MAX_SIZE` based on Postgres `max_connections` × replica count. 30 per replica is the default.
- **Rate limits**: per-phone/IP windows live in `OtpRateLimiter.kt`; tune if legitimate traffic gets blocked.

## Verification (final)

- `./gradlew compileKotlin compileTestKotlin` — clean, only deprecation warnings.
- `./gradlew test` — **66/66 tests pass** (unit + TestContainers integration).
- `./gradlew bootRun` — boots in ~4 s. `JwtSecretGuard` correctly WARNs in dev. `/actuator/health` → 200.
