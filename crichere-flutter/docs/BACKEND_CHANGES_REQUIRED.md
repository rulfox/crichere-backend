# Backend Changes Required

> **Status:** Tracking document — produced during the Flutter ⇄ Backend API alignment pass.
> The backend (`crichere-backend`) is treated as the **source of truth** for that pass, so
> none of the items below were applied to the backend. They are recorded here so a later
> backend pass can address them. Each item notes the file, the problem, the client-side
> workaround already applied (if any), and the recommended backend fix.

Last updated: 2026-05-29

---

## 1. CORS — production configuration (✅ RESOLVED 2026-05-29)

**File:** `crichere-backend/.../config/CorsConfig.kt`

**Problem (was):** With `allowCredentials = true`, an `addAllowedOriginPattern("*")` reflects
*any* request origin back as allowed — i.e. any website could make credentialed calls. The
config warned but did not prevent this in production.

**Resolution:** `CorsConfig` now injects `Environment` and **fails fast** if the
`allowed-origins` list contains `*` while the `prod` profile is active — forcing operators to
set `CORS_ALLOWED_ORIGINS` to the explicit deployed web origin(s) (e.g.
`https://app.crichere.live`). Dev (`application-dev.yml` → `*`) is unchanged for ergonomics.
`allowedHeaders`/`allowedMethods` remain `*` (so `Authorization`, `Last-Event-ID`,
`Cache-Control` and the SSE `GET` are permitted), and a 1h preflight `maxAge` was added.

**Remaining operational step:** ensure `CORS_ALLOWED_ORIGINS` is set in the prod environment
to the real web origin(s). With the new guard, a prod deploy with `*` (or unset) will refuse
to start rather than silently shipping an open credentialed policy.

---

## 2. Auth response shape inconsistency — `/auth/me` vs OTP verify (🟡 consistency)

**File:** `crichere-backend/.../auth/controller/AuthController.kt`

**Problem:** `/auth/me` returns a typed `UserResponse` (with `id`), while OTP verify / claim
return a loose `Map` whose user identifier is `userId`. The client must special-case two
different shapes for "the current user".

**Client workaround:** Flutter has a typed `UserProfile` (from `UserResponse`) for `/auth/me`
and `/users/{id}`, and a separate `AuthResponse` that reads only the token fields
(`accessToken`, `refreshToken`, expiry) from the verify/refresh payloads. The `userId` vs `id`
divergence is tolerated in the auth-token model.

**Recommended backend fix:** Return a single canonical envelope from verify/refresh, e.g.
`AuthTokenResponse { accessToken, refreshToken, expiresIn, user: UserResponse }`, so the user
object is always `UserResponse` with `id`. Drop the ad-hoc `Map` with `userId`.

---

## 3. `LeagueResponse.auctionIds: List<UUID>` — no convenience current-auction field (🟢 minor)

**File:** `crichere-backend/.../league/dto/LeagueDtos.kt` (`LeagueResponse`)

**Problem:** A league exposes `auctionIds: List<UUID>` but no direct "current/active auction".
The previous Flutter model assumed a single `auctionId: String`.

**Client workaround:** `League` model now holds `auctionIds: List<String>` with a computed
`currentAuctionId => auctionIds.firstOrNull`. Acceptable for now.

**Recommended backend fix (optional):** Consider exposing `currentAuctionId` (or ordering
`auctionIds` so index 0 is canonical) if the product needs an unambiguous active auction.

---

## 4. `@JsonKey` field-name remaps — candidates for rename (🟢 consistency)

**Files:** `auction/dto/AuctionDtos.kt` (`AuctionSummaryResponse`, `FranchiseSummary`)

**Problem:** The client historically remapped several fields. They are now aligned to the
**backend** names (the client adapts), but the names are slightly inconsistent across DTOs:
- `AuctionSummaryResponse.totalSpent` is `Long`; most monetary fields elsewhere are `Long`
  too, but a few summaries use plain numbers — verify all monetary fields are consistently
  `Long` (the client reads them all as `int`).
- `FranchiseSummary.squadCount`, `SaleSummary.amount`, etc. are fine; just flagged for a
  future naming audit.

**Client workaround:** Client reads the backend names directly (legacy remaps removed).

**Recommended backend fix:** Optional naming audit only; no functional change required.

---

## 5. `/admin/metrics` + `PlatformMetrics` do not exist server-side (🟡 dead client feature)

**Problem:** The Flutter client referenced an `/admin/metrics` endpoint and `PlatformMetrics`
/ `DailyActivity` models that have **no server implementation**.

**Client workaround:** The dead endpoint reference and the `PlatformMetrics`/`DailyActivity`
models are removed from the client.

**Recommended backend fix:** Decide product direction — either implement a metrics endpoint
(`GET /admin/metrics` → `{ totalUsers, totalLeagues, activeAuctions, dailyActivity[] }`) or
leave the feature out. Re-add the client models only if/when the endpoint exists.

---

## 6. SSE — confirm headers and replay semantics survive a proxy (🟡 ops)

**Files:** `auction/controller/AuctionSseController.kt`, `auction/sse/SseBroadcaster.kt`

**Notes (not necessarily a bug):**
- Server already sets `Cache-Control: no-cache, no-transform`, `X-Accel-Buffering: no`,
  `Connection: keep-alive`, `reconnectTime(3000)`, 15s keep-alive comments, and supports
  `Last-Event-ID` header / `lastEventId` query for replay from `lastSequenceNumber`.
- **Live** frames are emitted with only a `data:` line (no `id:`/`event:` SSE fields), while
  **snapshot/replay** frames include `id:`/`event:`. The JSON envelope inside `data:` always
  carries `event` (and `id` for action frames), so the client dispatches on the JSON envelope,
  not the SSE `event:` field. This is handled client-side but is worth documenting.

**Recommended backend fix (optional):** For consistency, also set the SSE-level `id:` and
`event:` fields on **live** frames (not just replay). This would let standard `EventSource`
clients (and any future non-custom client) track `Last-Event-ID` automatically without
parsing the JSON body. Not required for the current Flutter client.

---

## 7. Public spectator view — `error.auction_not_live` (🟢 UX contract)

**Files:** `public/controller/PublicAuctionController.kt`

**Note:** Public endpoints return `error.auction_not_live` (in the `ApiError.code` field) when
a token/auction is valid but not currently live. The client handles this as a "waiting to go
live" state. Confirm the error code string is stable; the client matches on it exactly.

---

## How to use this doc

When the backend pass begins, work top-down. For each item, either (a) implement the
recommended fix and remove the client workaround note in a follow-up Flutter pass, or
(b) explicitly decline and record the decision here.
