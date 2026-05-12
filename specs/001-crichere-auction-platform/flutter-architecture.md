# Flutter App Specification & API Mapping

**Document:** Flutter UI/UX & API Integration Plan
**Feature Branch**: `001-crichere-auction-platform`

This document details the screen-by-screen architecture of the Crichere Flutter application, mapping the required functionality to the specific backend APIs defined in the API contract.

## Architectural Principles

*   **Framework:** Flutter (Mobile + Web).
*   **State Management:** Riverpod (`AsyncNotifier` / `StreamProvider` for SSE).
*   **Networking:** Dio + Retrofit (Code generated).
*   **Caching:** Drift (SQLite) for offline-read caching (invalidated when auction goes live).
*   **Navigation:** `auto_route` with `AutoRouteGuard` for role-based access control.

---

## Screen & Flow Definitions

### 1. Onboarding & Authentication Flow

**Goal:** Secure, phone-based login and profile initialization.

*   **Login / OTP Request Screen**
    *   **UI:** Phone number input field, "Send OTP" button.
    *   **Functionality:** Validates Indian phone number format. Requests OTP.
    *   **API:** `POST /api/v1/auth/otp/send`

*   **OTP Verification Screen**
    *   **UI:** 6-digit OTP input, countdown timer for resend.
    *   **Functionality:** Verifies OTP. On success, stores JWT securely and redirects based on profile completeness.
    *   **API:** `POST /api/v1/auth/otp/verify`

*   **Profile Completion / Claim Screen**
    *   **UI:** Forms for Name, Role, Batting/Bowling style, Avatar upload.
    *   **Functionality:** If the user was added via bulk import as a "Ghost", they claim their profile here. Otherwise, they set up a new profile.
    *   **APIs:**
        *   `POST /api/v1/auth/claim-profile` (If claiming)
        *   `PUT /api/v1/users/{id}/basic`
        *   `PUT /api/v1/users/{id}/cricket-profile`
        *   `POST /api/v1/storage/presigned-url` & `PUT /api/v1/users/{id}/photo` (Avatar)

---

### 2. Main Dashboard (Home)

**Goal:** Central hub for the user to view their active leagues, notifications, and navigation.

*   **Dashboard Screen**
    *   **UI:** User summary banner, list of active leagues (joined or managing), floating action button to "Create League", notification bell.
    *   **Functionality:** Fetches user details, league memberships, and unread notification count.
    *   **APIs:**
        *   `GET /api/v1/auth/me`
        *   `GET /api/v1/leagues`
        *   `GET /api/v1/notifications`

*   **Notifications Screen**
    *   **UI:** List of in-app notifications.
    *   **Functionality:** Displays alerts (e.g., "You were sold to Team X!"). Marks as read on tap.
    *   **APIs:**
        *   `GET /api/v1/notifications`
        *   `PATCH /api/v1/notifications/{id}/read`

---

### 3. League Organization & Administration

**Goal:** Tools for League Admins to set up and manage their tournament.

*   **Create / Edit League Screen**
    *   **UI:** Forms for League Name, Format (T20, etc.), Dates, Rules upload (PDF).
    *   **APIs:**
        *   `POST /api/v1/leagues` (Create)
        *   `PATCH /api/v1/leagues/{id}/status` (Update status)
        *   `POST /api/v1/storage/presigned-url` (For Rules PDF/Logo)

*   **League Admin Dashboard**
    *   **UI:** Tabs for Players, Franchises, Finances, Waitlist.
    *   **APIs:** `GET /api/v1/leagues/{id}`

*   **Player Import Screen (Admin View)**
    *   **UI:** Bulk upload CSV/JSON interface.
    *   **Functionality:** Fast-tracks player onboarding into the league.
    *   **API:** `POST /api/v1/leagues/{id}/players/bulk-import`

*   **Financials & Fees Screen (Admin View)**
    *   **UI:** List of players/franchises and their payment status. "Record Payment" modal.
    *   **APIs:**
        *   `GET /api/v1/leagues/{leagueId}/fee-obligations`
        *   `POST /api/v1/leagues/{leagueId}/fee-obligations/{id}/payments`
        *   `GET /api/v1/leagues/{leagueId}/fees/summary`

*   **Waitlist & Forfeit Management**
    *   **UI:** Approve/Reject forfeit requests. Promote users from the waitlist.
    *   **APIs:**
        *   `GET /api/v1/leagues/{leagueId}/forfeit-requests`
        *   `PATCH /api/v1/leagues/{leagueId}/forfeit-requests/{id}/approve`
        *   `GET /api/v1/leagues/{leagueId}/waiting-list`

---

### 4. Player & Franchise Engagement

**Goal:** Interfaces for users to interact with leagues.

*   **Join League / Register Screen**
    *   **UI:** League details, "Register as Player" button.
    *   **APIs:**
        *   `POST /api/v1/players/register`
        *   `POST /api/v1/leagues/{leagueId}/waiting-list` (If full)

*   **Franchise Squad Screen**
    *   **UI:** List of players in a specific franchise. "Invite Co-owner" button (for franchise owners).
    *   **APIs:**
        *   `GET /api/v1/franchises/{id}`
        *   `POST /api/v1/franchises/{id}/invites`

---

### 5. Live Auction Room (Core Experience)

**Goal:** Real-time, synchronized auction experience for all participants.

*   **Auction Initialization (Admin)**
    *   **API:** `POST /api/v1/auctions/leagues/{leagueId}`

*   **Live Auction Screen (Shared View - Viewer/Owner)**
    *   **UI:** Live player card (currently under hammer), current highest bid, recent activity feed.
    *   **Functionality:** **CRITICAL:** Listens to SSE stream. Re-fetches full state on reconnect.
    *   **APIs:**
        *   `GET /api/v1/auctions/{id}/state` (Initial load snapshot)
        *   `GET /api/v1/auctions/{id}/events` (SSE Stream - `StreamProvider`)

*   **Auctioneer Control Panel (Web/Tablet Optimized)**
    *   **UI:** "Next Player" selector, "Hammer/Bid" buttons for each franchise, "Sold/Unsold" actions, "Undo" actions.
    *   **APIs:**
        *   `PATCH /api/v1/auctions/{id}/start` (or pause/resume)
        *   `POST /api/v1/auctions/{id}/player/put`
        *   `POST /api/v1/auctions/{id}/bid`
        *   `POST /api/v1/auctions/{id}/player/sold` (or unsold/withdraw)
        *   `PATCH /api/v1/auctions/{id}/bid/undo`
        *   `PATCH /api/v1/auctions/{id}/player/undo-sold`

---

### 6. Post-Auction Summaries & Exports

**Goal:** Review and share auction results.

*   **Auction Summary Dashboard**
    *   **UI:** Top buys, total spent, remaining purses, list of unsold players.
    *   **APIs:**
        *   `GET /api/v1/auctions/{id}/summary`
        *   `GET /api/v1/auctions/{id}/summary/unsold`

*   **Export & Sharing Module**
    *   **UI:** "Export to PDF" and "Share Squad to WhatsApp" buttons.
    *   **Functionality:** Generates high-quality assets for social sharing.
    *   **APIs:**
        *   `GET /api/v1/auctions/{id}/summary/export/pdf`
        *   `GET /api/v1/auctions/{id}/summary/franchises/{franchiseId}/export/image`

---

## Technical Integration Notes for Flutter

1.  **SSE Management:** Use the `eventsource` package. The Riverpod `StreamProvider` must cleanly handle connection drops, employing exponential backoff. Upon reconnecting, the client MUST fetch `/auctions/{id}/state` before re-attaching to the SSE stream to prevent missing intermediate `AuditLog` events.
2.  **Network State:** The Live Auction screen must immediately block the UI (using a SnackBar or Overlay) if the device loses network connectivity, preventing stale bids.
3.  **Authentication Resilience:** If a 401 occurs and token refresh (`POST /auth/token/refresh`) fails, a global Dio Interceptor must wipe `flutter_secure_storage`, clear the Drift database, and route the user back to the OTP screen using `auto_route`'s `replaceAll`.
---

## UI/UX Design Specification (Claude Design Prompt)

**Visual Identity & Aesthetic:**
- **Primary Theme:** "Midnight Stadium" (Dark mode). Deep navy/charcoal backgrounds (#0F172A) with vibrant accents.
- **Accent Colors:** 
    - **Cricket Green:** #22C55E (Success, Active states, Cricket theme).
    - **Auction Gold:** #F59E0B (Premium feel, Hammer price, VIP features).
    - **Live Red:** #EF4444 (Live indicators, Urgent alerts).
- **Typography:** Modern Sans-serif (e.g., Inter or Montserrat). Bold, high-contrast headings. Monospace for bid amounts to ensure numerical alignment.
- **Style:** Clean, high-impact, "Sporty-Premium". Use subtle glassmorphism for overlays and cards.

**Key Screen Design Directives:**

### 1. The "Live Auction Room" (The Hero Screen)
- **Layout (Mobile):** 
    - Top: Sticky "Live" indicator and current Round name.
    - Center: High-impact Player Card (Photo, Name, Role, Base Price).
    - Bottom: Real-time "Bid Log" (auto-scrolling) and current leading Franchise/Price.
- **Layout (Web/Auctioneer):** 
    - Left Column: Searchable Player Pool.
    - Center: "Under the Hammer" player with massive "SOLD" and "UNSOLD" buttons.
    - Right Column: Franchise Purse leaderboard with progress bars (spent vs. total).

### 2. Player Card Component
- **Visuals:** Stylized background based on player role (Batsman = Blue, Bowler = Red, All-rounder = Purple).
- **Data Points:** Batting/Bowling styles presented as clean icons. High-visibility "Current Bid" badge in Auction Gold.

### 3. Dashboard / League List
- **Visuals:** Card-based layout for leagues. Use "Live" pulse animations for leagues currently holding an auction.
- **Interaction:** Shimmer loading states for league lists.

### 4. Auctioneer "Command Center" (Web Only)
- **Controls:** Tactile, large buttons for recording bids (+500, +1000, etc.). 
- **Safety:** "Undo" button with a distinct "caution" visual style.

**Interactive States:**
- **Bid Animation:** When a new bid arrives, the price should "tick" upwards with a subtle scale-up animation.
- **Sold Celebration:** Full-screen overlay with confetti and the winning franchise's logo when "SOLD" is triggered.
- **SSE Offline:** A frosted-glass overlay that dims the UI with a "Reconnecting..." spinner and a clear message.
