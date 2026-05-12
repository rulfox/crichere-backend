# Crichere — Flutter Screen Specification
## For Android Studio Gemini Code Generation

> **Purpose**: CSS-free specification of all 11 prototype screens.
> Gemini should use this file + `crichere_design_tokens.dart` to generate Flutter widgets.
> No CSS in this file. All styling references Flutter constants from `CricColor`, `CricTextStyle`, `CricRadius`, `CricButtonStyle`.

---

## Project Overview

**App**: Crichere — India's cricket league management & live auction platform
**Platforms**: Flutter (Android, iOS, Web/Responsive)
**Theme**: Always dark. Background `CricColor.appBg` (#060C1A).
**Fonts**: Rajdhani (display/logo), DM Sans (body/UI), JetBrains Mono (code/mono)
**Primary CTA color**: `CricColor.gold` (#F59E0B)

### Navigation Pattern
- **Mobile**: Bottom navigation bar with 4 tabs: Home, Discover, Alerts, Profile
- **Web**: Top persistent nav bar with section links
- **Auth**: Separate flow, no nav bars

### Shared Reusable Widgets (build these first)

| Widget Name | Description |
|---|---|
| `CricAppBar` | Sticky top bar with `🏏 CRICHERE` logo (gold, Rajdhani), section title, pill navigation |
| `CricPhoneFrame` | 375×812 phone container (prototype only, skip in production) |
| `CricCard` | `Container` with `CricDecoration.card` (slate2 bg, border, 12dp radius) |
| `CricBadge` | Colored pill badge: `b-gold`, `b-green`, `b-red`, `b-blue`, `b-gray` variants |
| `LiveDot` | Animated pulsing red dot (`CricColor.red`) for LIVE status |
| `PurseBar` | Horizontal progress bar showing franchise purse used vs total |
| `AvatarCircle` | Circular avatar with initials fallback, `CricColor.slate3` bg |
| `CricBottomNav` | Bottom nav: Home, Discover, Alerts, Profile icons |
| `StatusChip` | Rounded chip with text: LIVE (red), Upcoming (blue), T20/T10 (gold) |
| `SectionHeader` | Row with bold label left + 'See all →' link right |

---

## S1 — Auth (Mobile + Web)

**Route**: `/auth`  
**Widget class**: `AuthScreen`  
**Sub-screens / states**: `SplashScreen`, `PhoneEntryScreen`, `OtpVerifyScreen`, `ProfileClaimScreen`, `NewProfileSetupScreen`, `WebAuthScreen`

**Purpose**: Authentication flow. OTP-only, no passwords. Indian mobile numbers (+91).

**UI Content:**
- `TEXT` — Crichere · S1 Auth — Mobile + Web
- `TEXT` — CRICHERE
- `TEXT` — Your league. Your auction. Live.
- `TEXT` — India's #1 cricket auction platform
- `TEXT` — 500+ leagues · 50k+ players
- `TEXT` — v1.0.0 · ap-south-1

**Badges/Chips:** `Android` · `iOS` · `Web`

**Actions / Buttons:**
- `[Button]` GET STARTED →

### Frame: `S1-A · SPLASH · MOBILE 375×812`

**UI Content:**
- `TEXT` — 9:41
- `TEXT` — Sign In
- `TEXT` — Enter your Indian mobile number
- `LABEL` — MOBILE NUMBER
- `TEXT` — +91
- `TEXT` — 98765 43210
- `TEXT` — Format: ^[6-9]\d{9}$ · 6-digit OTP · Valid 5 min · Max 5 req/hr
- `TEXT` — ✓ OTP-only authentication
- `TEXT` — No passwords. JWT 1h access + 30d refresh tokens.
- `TEXT` — Stored securely in Keychain (iOS) / Keystore (Android).
- `TEXT` — POST /api/v1/auth/otp/send
- `TEXT` — New to cricket leagues?
- `TEXT` — Browse leagues first →

**Actions / Buttons:**
- `[Button]` 🔒 Send OTP

### Frame: `S1-B · PHONE ENTRY · MOBILE 375×812`

**UI Content:**
- `TEXT` — 55123
- `TEXT` — ⚠ Invalid format. Enter a 10-digit Indian mobile number starting with 6–9.
- `TEXT` — Rate limited: 5 OTPs per hour per phone number

### Frame: `S1-B² · PHONE ENTRY (Error State)`

**UI Content:**
- `TEXT` — ← Back
- `TEXT` — Enter OTP
- `TEXT` — Sent via SMS to
- `TEXT` — +91 98765 43210
- `TEXT` — via MSG91 · 6 digits · Valid 5 min
- `TEXT` — ⏱ 04:23
- `TEXT` — Attempt
- `TEXT` — of 3
- `TEXT` — Didn't receive it?
- `TEXT` — Resend OTP
- `TEXT` — POST /api/v1/auth/otp/verify
- `TEXT` — On success: JWT stored in flutter_secure_storage

**Actions / Buttons:**
- `[Button]` Verify & Continue →

### Frame: `S1-C · OTP VERIFY · Mobile`

**UI Content:**
- `TEXT` — Sent to
- `TEXT` — ⚠ Incorrect OTP
- `TEXT` — 2 attempts remaining before this OTP is invalidated.
- `TEXT` — ⏱ 03:47

**Actions / Buttons:**
- `[Button]` Try Again

### Frame: `S1-C² · OTP ERROR STATE`

**UI Content:**
- `TEXT` — OTP Expired
- `TEXT` — Your OTP has timed out after 5 minutes
- `TEXT` — ⏱ 00:00 — Expired
- `TEXT` — Previous OTP invalidated. New OTP valid for 5 minutes.

**Actions / Buttons:**
- `[Button]` 📲 Resend New OTP

### Frame: `S1-C³ · OTP EXPIRED`

**UI Content:**
- `TEXT` — Ghost profile found!
- `TEXT` — Pre-added to TechCup 2026 by Rahul Kumar
- `TEXT` — Claim Your Profile
- `TEXT` — Verify your identity and complete your cricket profile
- `TEXT` — Tap to upload · JPEG/PNG/WebP · Max 5MB · S3 presigned URL
- `LABEL` — FULL NAME
- `LABEL` — PLAYING ROLE
- `LABEL` — BATTING
- `TEXT` — Right-hand bat
- `TEXT` — Left-hand bat
- `LABEL` — BOWLING
- `TEXT` — Off spin
- `TEXT` — Fast
- `TEXT` — Leg spin
- `TEXT` — Medium pace
- `TEXT` — Left-arm spin
- `LABEL` — EXPERIENCE LEVEL
- `TEXT` — User entity · /cricket-profile
- `LABEL` — CITY
- `LABEL` — JERSEY NUMBER (optional)

**Badges/Chips:** `🏏 Batter` · `🎳 Bowler` · `⭐ All-rounder ✓` · `🧤 Keeper` · `Beginner` · `Intermediate ✓` · `Advanced` · `Pro`

**Actions / Buttons:**
- `[Button]` ✓ Confirm & Activate Profile

### Frame: `S1-D · GHOST PROFILE CLAIM · Mobile`

**UI Content:**
- `TEXT` — Phone ✓
- `TEXT` — Profile
- `TEXT` — Cricket
- `TEXT` — Create Your Profile
- `TEXT` — No existing profile found. Set one up!
- `TEXT` — Profile photo · 5MB max · JPEG/PNG/WebP
- `LABEL` — DATE OF BIRTH
- `TEXT` — PUT /users/{id}/basic · Redirects based on profileStatus

**Badges/Chips:** `⭐ All-rounder`

**Actions / Buttons:**
- `[Button]` Continue to Cricket Profile →

### Frame: `S1-E · NEW PROFILE SETUP · Mobile`

**UI Content:**
- `TEXT` — crichere.app/auth
- `TEXT` — India's #1 cricket auction platform.
- `TEXT` — Real-time live auctions for every league.
- `TEXT` — 500+
- `TEXT` — Leagues
- `TEXT` — 50k+
- `TEXT` — Players
- `TEXT` — Concurrent viewers
- `TEXT` — No password needed — just your phone number
- `TEXT` — Format: starts with 6–9, 10 digits · POST /api/v1/auth/otp/send
- `TEXT` — New here?
- `TEXT` — Browse leagues without signing in →
- `TEXT` — AFTER OTP — YOU'LL ALSO GET
- `TEXT` — Claim your pre-created ghost profile if added by admin
- `TEXT` — Full access to live auctions, squad management, and stats
- `TEXT` — JWT secured · Keychain/Keystore · No passwords stored

**Badges/Chips:** `Web · 1440px`

### Frame: `S1-F · WEB AUTH · 1440×700 · Split layout`

**UI Content:**
- `TEXT` — crichere.app/auth/verify
- `TEXT` — Check your SMS
- `TEXT` — We sent a 6-digit OTP to
- `TEXT` — Via MSG91 · Valid for 5 minutes
- `TEXT` — 6-digit code sent to your mobile
- `TEXT` — ⏱ 04:23 remaining
- `TEXT` — ← Change number

**Actions / Buttons:**
- `[Button]` Verify & Enter →

### Flutter Widget Structure

```dart
// AuthScreen — rough widget tree
Scaffold(
  backgroundColor: CricColor.appBg,
  body: SafeArea(
    child: SingleChildScrollView(
      padding: EdgeInsets.all(CricSpacing.page),
      child: Column(
        children: [
          // Logo / hero section
          // Form fields
          // Primary CTA button (CricButtonStyle.primary)
        ],
      ),
    ),
  ),
);
```

---

## S2 — Home & Discover

**Route**: `/home`  
**Widget class**: `HomeScreen`  
**Sub-screens / states**: `PlayerHomeScreen`, `AdminHomeScreen`, `DiscoverScreen`, `WebDashboardScreen`, `NotificationsScreen`

**Purpose**: Main hub. Shows active leagues, live auction banner, bottom nav.

**UI Content:**
- `TEXT` — Crichere · S2 — Home & Discover
- `TEXT` — 9:41
- `TEXT` — Good evening,
- `TEXT` — Anjali Sharma
- `TEXT` — LIVE NOW
- `TEXT` — TechCup 2026
- `TEXT` — Round 1 · Player 23 of 120 · 47 viewers
- `TEXT` — ₹2k
- `TEXT` — Top sale
- `TEXT` — Leagues
- `TEXT` — Live
- `LABEL` — MY LEAGUES
- `TEXT` — See all →
- `TEXT` — 8 franchises · 120 players
- `TEXT` — ✓ Sold to Thunder Strikers · ₹2,000
- `TEXT` — Auction 23% complete
- `TEXT` — Premier Office League
- `TEXT` — 6 franchises · 90 players
- `TEXT` — ⏱ Auction in 7 days · Purse ₹40,000
- `LABEL` — Home

**Badges/Chips:** `T20` · `T10` · `Upcoming`

**Actions / Buttons:**
- `[Button]` 🚪 Enter Auction Room

### Frame: `S2-A · PLAYER HOME · Mobile`

**UI Content:**
- `TEXT` — League Admin
- `TEXT` — Rahul Kumar
- `TEXT` — Franchises
- `TEXT` — 120
- `TEXT` — Players
- `TEXT` — ⚠ 4 fee payments due
- `TEXT` — ₹2,000 pending across TechCup 2026
- `TEXT` — View →
- `TEXT` — 8 franchises · 120 players · Round 1/3
- `TEXT` — 0/6 franchises · 45 players
- `TEXT` — Society Cup 2025
- `TEXT` — Final results available · PDF exported
- `LABEL` — Admin

**Badges/Chips:** `4 fees due` · `Draft` · `Completed`

**Actions / Buttons:**
- `[Button]` + Create
- `[Button]` ⚙ Manage
- `[Button]` 🔨 Auction
- `[Button]` ✎ Edit
- `[Button]` ↑ Publish

### Frame: `S2-B · ADMIN HOME · Mobile (standalone screen)`

**UI Content:**
- `TEXT` — Discover Leagues
- `TEXT` — 🔍 Search leagues, cities, formats...
- `LABEL` — 🔴 LIVE NOW (2)
- `TEXT` — Mumbai · 47 watching
- `TEXT` — Corporate Premier
- `TEXT` — Bangalore · 22 watching
- `LABEL` — UPCOMING AUCTIONS
- `TEXT` — Mumbai · 6 franchises · 90 players
- `TEXT` — ⏱ Jun 15 · Purse ₹40k
- `TEXT` — Society Cup 2026
- `TEXT` — Pune · 4 franchises · 48 players
- `TEXT` — ✓ Registration open
- `TEXT` — University League 2026
- `TEXT` — Chennai · Results available

**Badges/Chips:** `All` · `Live Now` · `Open`

**Actions / Buttons:**
- `[Button]` 🚪 Enter Room
- `[Button]` Register →
- `[Button]` Join

### Frame: `S2-C · DISCOVER LEAGUES · Mobile`

**UI Content:**
- `TEXT` — crichere.app/dashboard
- `TEXT` — MAIN
- `TEXT` — Dashboard
- `TEXT` — My Leagues
- `TEXT` — MANAGEMENT
- `TEXT` — Fees & Payments
- `TEXT` — Forfeits
- `TEXT` — Waitlist
- `TEXT` — Notifications
- `TEXT` — Settings
- `TEXT` — Sign Out
- `TEXT` — Good evening, Rahul 👋
- `TEXT` — Here's what's happening across your leagues
- `TEXT` — LEAGUES
- `TEXT` — LIVE
- `TEXT` — FRANCHISES
- `TEXT` — PLAYERS
- `TEXT` — FEES DUE
- `TEXT` — LEAGUE
- `TEXT` — FORMAT

**Badges/Chips:** `Unpaid` · `Partial`

**Actions / Buttons:**
- `[Button]` + Create League
- `[Button]` Manage
- `[Button]` Auction
- `[Button]` Edit
- `[Button]` Summary
- `[Button]` View All Fees →
- `[Button]` 📥 Bulk Import Players
- `[Button]` 🏟️ Create Franchise

### Frame: `S2-D · ADMIN DASHBOARD · Web 1440px (sidebar + content)`

**UI Content:**
- `TEXT` — Mark all read
- `TEXT` — You were sold!
- `TEXT` — Thunder Strikers bought you for ₹2,000 in TechCup 2026.
- `TEXT` — PLAYER_SOLD · 2 min ago
- `TEXT` — Auction started
- `TEXT` — TechCup 2026 Round 1 has begun. 120 players up for bid.
- `TEXT` — AUCTION_STARTED · 18 min ago
- `TEXT` — Fee recorded
- `TEXT` — ₹500 player fee recorded for TechCup 2026.
- `TEXT` — FEE_PAYMENT_RECORDED · Yesterday
- `TEXT` — Profile activated
- `TEXT` — Ghost profile claimed successfully.
- `TEXT` — 3 days ago
- `TEXT` — Waitlist position updated
- `TEXT` — You are #3 on Premier Office League waitlist.
- `TEXT` — 1 week ago · PATCH /notifications/{id}/read

### Flutter Widget Structure

```dart
// HomeScreen — rough widget tree
Scaffold(
  backgroundColor: CricColor.appBg,
  appBar: CricAppBar(title: 'S2 — Home & Discover'),
  body: SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Content sections
      ],
    ),
  ),
  bottomNavigationBar: CricBottomNav(),
);
```

---

## S3 — League Detail

**Route**: `/league/:id`  
**Widget class**: `LeagueDetailScreen`  
**Sub-screens / states**: `LeagueOverviewTab`, `PlayersTab`, `FranchisesTab`, `ScheduleTab`

**Purpose**: Full league info: franchises, player list, auction schedule, purse tracker.

**UI Content:**
- `TEXT` — Crichere · S3 — League Detail
- `TEXT` — 9:41
- `TEXT` — ← Back
- `TEXT` — TechCup 2026
- `TEXT` — By Rahul Kumar · Mumbai · Auction Live
- `TEXT` — Franchises
- `TEXT` — 120
- `TEXT` — Players
- `TEXT` — ₹50k
- `TEXT` — Purse
- `TEXT` — Overview
- `TEXT` — Rules
- `TEXT` — League Details
- `TEXT` — Format
- `TEXT` — Order mode
- `TEXT` — 🎲 Random
- `TEXT` — Players/team
- `TEXT` — Waitlist
- `TEXT` — ⚡ Auto-promote
- `TEXT` — Your Status

**Badges/Chips:** `Live` · `T20` · `▲ Up for bid` · `AR` · `Available` · `BAT` · `✓ Sold ₹1,800` · `WK`

**Actions / Buttons:**
- `[Button]` 🚪 Enter Auction Room

### Frame: `S3-A · LEAGUE DETAIL · Player View (Registered) · Mobile`

**UI Content:**
- `TEXT` — Premier Office League
- `TEXT` — By Kiran Joshi · Pune · Registration Open
- `TEXT` — 72/90
- `TEXT` — ₹40k
- `TEXT` — ✓ Registration Open · 18 slots remaining
- `TEXT` — Player fee: ₹500 · Min to register: ₹500 · Cash only (V1)
- `TEXT` — League nearly full?
- `TEXT` — Join the waitlist · 3 people waiting
- `TEXT` — Registration Details
- `TEXT` — Player fee
- `TEXT` — ₹500
- `TEXT` — Min to play
- `TEXT` — Payment
- `TEXT` — Cash (V1)
- `TEXT` — Auction date
- `TEXT` — Jun 15, 2026
- `TEXT` — Waitlist Info
- `TEXT` — Mode:
- `TEXT` — AUTO_PROMOTE
- `TEXT` — 3 people waiting · If someone forfeits, you get promoted automatically.

**Actions / Buttons:**
- `[Button]` 🏏 Register as Player  ·  POST /players/register
- `[Button]` Join Waitlist

### Frame: `S3-B · LEAGUE DETAIL (Unregistered) + Join CTA · Mobile`

**UI Content:**
- `TEXT` — Register as Player
- `TEXT` — Premier Office League · POST /api/v1/players/register
- `TEXT` — Your profile
- `TEXT` — All-rounder · Right-hand bat · Off spin
- `TEXT` — PLAYER CATEGORY (for base price)
- `TEXT` — Cat A ✓
- `TEXT` — ₹1,000
- `TEXT` — Cat B
- `TEXT` — Cat C
- `TEXT` — ₹250
- `TEXT` — Registration fee
- `TEXT` — Cash payment · Admin will record · FeeObligation created

**Badges/Chips:** `Active`

**Actions / Buttons:**
- `[Button]` ✓ Confirm Registration
- `[Button]` Cancel

### Frame: `S3-C · REGISTER MODAL (Bottom sheet) · POST /players/register`

**UI Content:**
- `TEXT` — Join Waiting List
- `TEXT` — Premier Office League · POST /leagues/{id}/waiting-list
- `TEXT` — Queue Status
- `TEXT` — Current position
- `TEXT` — Promotion mode
- `TEXT` — You'll be automatically promoted when a slot opens. We'll notify you via push notification.

**Actions / Buttons:**
- `[Button]` Join Waitlist at #4

### Frame: `S3-D · JOIN WAITLIST MODAL · POST /leagues/{id}/waiting-list`

**UI Content:**
- `TEXT` — Fees ⚡
- `TEXT` — Rounds
- `TEXT` — Forfeits
- `TEXT` — Paid
- `TEXT` — Unpaid
- `TEXT` — ₹1k
- `TEXT` — Rohit Verma
- `TEXT` — Partial
- `TEXT` — Vikram Mehta
- `TEXT` — 4/15 slots
- `TEXT` — 📋 See full Fees tab →
- `TEXT` — Switch to "Admin Fees Tab" for complete fee management
- `TEXT` — Round 1
- `TEXT` — All · RANDOM · 120 players
- `TEXT` — Round 2
- `TEXT` — Unsold players only
- `TEXT` — "Medical emergency. Requesting full refund of ₹500."
- `TEXT` — Full refund · ₹500
- `TEXT` — Partial refund
- `TEXT` — No refund

**Badges/Chips:** `Auction Live` · `Up` · `BOWL` · `Pending`

**Actions / Buttons:**
- `[Button]` 🔨 Auction
- `[Button]` ↑ CSV
- `[Button]` + Add
- `[Button]` Pay
- `[Button]` Squad
- `[Button]` Invite
- `[Button]` Pre-assign
- `[Button]` ⏸ Pause

### Frame: `S3-E · LEAGUE ADMIN (Players / Franchises / Fees / Rounds / Forfeits)`

**UI Content:**
- `TEXT` — Fee Management
- `TEXT` — TechCup 2026 · PLAYER_FEE + FRANCHISE_FEE · Cash V1
- `TEXT` — ₹32.5k
- `TEXT` — Collected
- `TEXT` — ₹7.5k
- `TEXT` — 81%
- `TEXT` — Collection rate
- `TEXT` — Player Fees (4)
- `TEXT` — Franchise Fees (2)
- `TEXT` — FeeObligation · feeType=PLAYER_FEE
- `TEXT` — GET /leagues/{id}/fee-obligations · POST /leagues/{id}/fee-obligations/{id}/payments
- `TEXT` — All-rounder
- `TEXT` — ✓ Paid
- `TEXT` — ₹500 of ₹500 · Cash
- `TEXT` — auctionEligible ✓
- `TEXT` — Batter
- `TEXT` — ₹0 of ₹500 · auctionEligible: NO
- `TEXT` — Bowler
- `TEXT` — ₹500 of ₹1,000 · min met ✓
- `TEXT` — Priya Gupta

**Actions / Buttons:**
- `[Button]` 💰 Record
- `[Button]` +₹500
- `[Button]` Waive
- `[Button]` 💰 Record Payment

### Frame: `S3-F · FEE MANAGEMENT (Player + Franchise fees) ★ KEY SCREEN`

**UI Content:**
- `TEXT` — Record Payment
- `TEXT` — PLAYER / FRANCHISE
- `TEXT` — Sam Patel — Player fee ₹500 due
- `TEXT` — Sky Raiders — Franchise fee ₹10k due
- `TEXT` — Rohit Verma — ₹500 remaining
- `TEXT` — AMOUNT (₹) — Whole INR integers only
- `TEXT` — PAYMENT MODE
- `TEXT` — 💵 Cash ✓
- `TEXT` — 💳 Online
- `TEXT` — V1: Cash only · Razorpay in V2
- `TEXT` — NOTES (optional)
- `TEXT` — Creates FeePayment record · Updates paidAmount · Checks minimumToRegister

**Actions / Buttons:**
- `[Button]` ✓ Record ₹500 Payment

### Frame: `S3-G · RECORD PAYMENT MODAL · FeePayment entity`

**UI Content:**
- `TEXT` — crichere.app/leagues/techcup-2026/admin
- `TEXT` — 👥 Players
- `TEXT` — 🏟️ Franchises
- `TEXT` — 💰 Fees ★
- `TEXT` — 🔄 Rounds
- `TEXT` — 📋 Forfeits
- `TEXT` — ⏳ Waitlist
- `TEXT` — 📊 Audit Log
- `TEXT` — PLAYERS · 120 total
- `TEXT` — All fees
- `TEXT` — PLAYER
- `TEXT` — ROLE
- `TEXT` — CATEGORY
- `TEXT` — BASE PRICE
- `TEXT` — AUCTION STATE
- `TEXT` — FEE STATUS
- `TEXT` — ACTIONS
- `TEXT` — +91 98765 43210
- `TEXT` — +91 98765 43211
- `TEXT` — +91 98765 43212

**Badges/Chips:** `Cat A` · `Pre-assigned`

**Actions / Buttons:**
- `[Button]` 🔨 Open Auctioneer
- `[Button]` ↑ Bulk Import
- `[Button]` Edit
- `[Button]` ⭐ Pre-assign
- `[Button]` 💰 Pay

### Frame: `S3-H · LEAGUE ADMIN (Players + Fee Status inline) · Web 1440px`

**UI Content:**
- `TEXT` — crichere.app/leagues/techcup-2026/admin/fees
- `TEXT` — TOTAL EXPECTED
- `TEXT` — ₹40,000
- `TEXT` — COLLECTED
- `TEXT` — ₹32,500
- `TEXT` — PENDING
- `TEXT` — ₹7,500
- `TEXT` — COLLECTION RATE
- `TEXT` — WAIVED
- `TEXT` — PLAYER FEES · feeType=PLAYER_FEE
- `TEXT` — AMOUNT
- `TEXT` — PAID
- `TEXT` — STATUS
- `TEXT` — auctionEligible: NO
- `TEXT` — ₹500↵
- `TEXT` — minimumToRegister checked on each payment · WAIVED = terminal state
- `TEXT` — FRANCHISE FEES · feeType=FRANCHISE_FEE
- `TEXT` — FRANCHISE
- `TEXT` — ₹10,000
- `TEXT` — Suspended until min paid

**Badges/Chips:** `Fee Management ★`

**Actions / Buttons:**
- `[Button]` + Record Payment

### Frame: `S3-I · FEE MANAGEMENT (Player + Franchise) ★ Web 1440px — KEY MISSING FEATURE`

**UI Content:**
- `TEXT` — OBLIGATION
- `TEXT` — AMOUNT (₹)
- `TEXT` — 💳 Online (V2)
- `TEXT` — NOTES
- `TEXT` — All-rounder · Active profile
- `TEXT` — Cash · Admin will record · FeeObligation created automatically
- `TEXT` — Position
- `TEXT` — Mode
- `TEXT` — Auto-promoted when a forfeit is approved. Push notification sent.

**Actions / Buttons:**
- `[Button]` ✓ Record ₹500
- `[Button]` ✓ Confirm
- `[Button]` Join at #4

### Flutter Widget Structure

```dart
// LeagueDetailScreen — rough widget tree
Scaffold(
  backgroundColor: CricColor.appBg,
  appBar: CricAppBar(title: 'S3 — League Detail'),
  body: SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Content sections
      ],
    ),
  ),
);
```

---

## S4 — Live Auction Room

**Route**: `/auction/:id/room`  
**Widget class**: `AuctionRoomScreen`  
**Sub-screens / states**: `TimerNormalState`, `TimerWarningState`, `TimerExpiredState`, `DynamicBidButtons`, `AllRolesView`

**Purpose**: Real-time auction room. Countdown timer (3 states), dynamic bid increment buttons, role-based views (player/franchise/spectator).

**Sections:**
- S4 — Live Auction Room
- 📱 Mobile — Countdown Timer: All 3 States

**UI Content:**
- `TEXT` — Crichere — S4: Live Auction Room (Updated)
- `TEXT` — Updated
- `HEADING` — Countdown timer (3 states) · Dynamic bid increment buttons · All role cards · SOLD/UNSOLD/Round overlays · Web 3-col viewer

### Frame: `Timer — State A · Normal (42s)`

**UI Content:**
- `TEXT` — 9:41 AM
- `TEXT` — Round 1
- `TEXT` — Anjali Kumar
- `TEXT` — All-rounder · Tag A · Base ₹500
- `TEXT` — SECS
- `TEXT` — Timer Running
- `TEXT` — 60s round · Anti-snipe: 10s
- `TEXT` — POST /auctions/{id}/timer/start
- `LABEL` — CURRENT BID
- `TEXT` — ₹9,500
- `TEXT` — Thunder Strikers leading
- `TEXT` — Min bid
- `TEXT` — ₹11,500
- `TEXT` — Increment: +₹2,000
- `TEXT` — GET /auctions/{id}/state → minimumNextBid: 11500, bidIncrement: 2000

**Badges/Chips:** `● LIVE` · `UP`

**Actions / Buttons:**
- `[Button]` +₹2,000
- `[Button]` +₹4,000
- `[Button]` +₹6,000
- `[Button]` Custom
- `[Button]` 🔨 BID ₹11,500

**Dev Notes (annotations from prototype):**
> Increment from: AuctionRoundBidIncrement → Tag A overrides category default

### Frame: `Timer — State B · Warning ≤10s (anti-snipe active)`

**UI Content:**
- `TEXT` — All-rounder · Tag A
- `TEXT` — ⚡ Anti-snipe Zone!
- `TEXT` — Bid now → timer resets to 10s
- `TEXT` — antiSnipeSeconds: 10 · still running
- `TEXT` — 🔁 If a bid lands within ≤10s remaining, the timer resets to antiSnipeSeconds (10s) and ring flashes gold → red
- `LABEL` — CURRENT BID — BID NOW!
- `TEXT` — Thunder Strikers · Last chance

### Frame: `Timer — State C · Expired (0s) — auctioneer decides`

**Sections:**
- 📱 Mobile — Dynamic Bid Buttons: Category-Specific Increments

**UI Content:**
- `TEXT` — Time's Up
- `TEXT` — Auctioneer must click SOLD manually
- `TEXT` — No auto-sell · Auctioneer is sole writer
- `TEXT` — Timer expired. Bidding remains open. Waiting for auctioneer to call SOLD or UNSOLD.
- `LABEL` — FINAL BID (pending decision)
- `TEXT` — Thunder Strikers
- `TEXT` — Min bid still valid

### Frame: `Tag B Batter — Increment +₹1,000`

**UI Content:**
- `TEXT` — Sam Patel
- `TEXT` — Batter
- `TEXT` — 60s total
- `TEXT` — ₹5,500
- `TEXT` — Phoenix XI leading
- `TEXT` — ₹6,500
- `TEXT` — Tag B · +₹1,000
- `TEXT` — minimumNextBid = 5500 + 1000 = 6500

**Badges/Chips:** `Tag B`

**Actions / Buttons:**
- `[Button]` +₹1,000
- `[Button]` +₹3,000
- `[Button]` 🔨 BID ₹6,500

**Dev Notes (annotations from prototype):**
> Tag B → bidIncrement: 1000

### Frame: `Tag A Star All-rounder — Increment +₹2,000`

**Sections:**
- 📱 Mobile — Viewer: Player Role Cards (All Types)

**UI Content:**
- `TEXT` — All-rounder
- `TEXT` — ⚡ Anti-snipe
- `TEXT` — Thunder Strikers · Anti-snipe zone!
- `TEXT` — ★ Tag A · +₹2,000
- `TEXT` — bidIncrement: 2000 (from AuctionRoundBidIncrement)

**Badges/Chips:** `★ Tag A`

**Dev Notes (annotations from prototype):**
> Tag A overrides ALL_ROUNDER category rule

### Frame: `All-rounder (purple) + Timer normal`

**UI Content:**
- `TEXT` — #142
- `TEXT` — BASE PRICE
- `TEXT` — ₹500
- `TEXT` — 60s
- `TEXT` — ⚡ Thunder Strikers leading
- `HEADING` — Bid History
- `TEXT` — Lightning Kings
- `TEXT` — ₹8,500
- `TEXT` — Royal Blazers
- `TEXT` — ₹7,000

**Badges/Chips:** `ALL-ROUNDER` · `RHB`

### Frame: `Batter (blue) + My purse widget`

**UI Content:**
- `TEXT` — ₹1,000
- `TEXT` — MY TEAM — Thunder Strikers
- `TEXT` — Purse remaining
- `TEXT` — ₹25,800
- `TEXT` — 8/15 slots · 7 remaining

**Badges/Chips:** `BATTER` · `LHB`

### Frame: `Bowler (red) — No bids, timer normal`

**Sections:**
- 📱 Mobile — SOLD, UNSOLD, Round & SSE Overlays

**UI Content:**
- `TEXT` — Mohan Kumar
- `TEXT` — OPENING BID
- `TEXT` — Waiting for first bid…
- `TEXT` — Opening / Min bid
- `TEXT` — Default +₹500

**Badges/Chips:** `BOWLER` · `RA Fast`

### Frame: `SOLD! Overlay with confetti`

**UI Content:**
- `TEXT` — SOLD!
- `TEXT` — All-rounder · ★ Tag A
- `TEXT` — PURCHASED BY
- `TEXT` — FINAL PRICE
- `TEXT` — ₹12,500
- `TEXT` — Purse: ₹50K → ₹37.5K · POST /auctions/{id}/player/sold

### Frame: `UNSOLD Overlay`

**UI Content:**
- `TEXT` — UNSOLD
- `TEXT` — Kiran Chandran
- `TEXT` — Batter · Base ₹500
- `TEXT` — NO BIDS RECEIVED
- `TEXT` — Goes to Round 2 pool
- `TEXT` — POST /auctions/{id}/player/unsold · State → UNSOLD

### Frame: `Round Complete overlay`

**UI Content:**
- `TEXT` — Round 1 Complete
- `TEXT` — Main auction round finished
- `TEXT` — Sold
- `TEXT` — Unsold→R2
- `TEXT` — Round 2 starts soon · Unsold players re-enter pool

**Actions / Buttons:**
- `[Button]` View Round Summary

### Frame: `SSE Disconnected — Reconnecting`

**Sections:**
- 🖥️ Web — Auction Viewer with Timer (3-Column)

**UI Content:**
- `TEXT` — Connection Lost
- `TEXT` — Reconnecting…
- `TEXT` — Attempt 2 · Next in 4s
- `TEXT` — Backoff: 2s→4s→8s→30s · Unlimited retries
- `TEXT` — Step 1: GET /auctions/{id}/state
- `TEXT` — → sync lastSequenceNumber + currentHighestBid + timer
- `TEXT` — Step 2: GET /auctions/{id}/events?after={seq}

**Actions / Buttons:**
- `[Button]` Retry now

### Frame: `Web — Full 3-col viewer with timer strip + dynamic increment badge`

**UI Content:**
- `TEXT` — 🏏 Crichere
- `TEXT` — SSE #142
- `TEXT` — 🟢 Connected
- `TEXT` — PLAYER POOL (92 remaining)
- `TEXT` — Batter · Tag B · ₹1,000
- `TEXT` — Bowler · ₹500
- `TEXT` — +89 more
- `TEXT` — Timer Running · 42s remaining
- `TEXT` — Anti-snipe: 10s
- `TEXT` — ⚡ Thunder Strikers
- `TEXT` — Increment
- `TEXT` — +₹2,000 (Tag A rule)
- `TEXT` — Min next:
- `TEXT` — BID HISTORY
- `TEXT` — GET /auctions/{id}/state → minimumNextBid, bidIncrement, timer
- `TEXT` — GET /auctions/{id}/events → SSE · seq-dedup · <500ms 4G
- `TEXT` — FRANCHISE PURSES
- `TEXT` — ⭐ Thunder Strikers
- `TEXT` — ₹43K
- `TEXT` — 4/15 · LEADING BID

**Badges/Chips:** `● LIVE — TechCup 2026 · Round 1` · `NOW` · `Right Hand`

### Flutter Widget Structure

```dart
// AuctionRoomScreen — rough widget tree
Scaffold(
  backgroundColor: CricColor.appBg,
  appBar: CricAppBar(title: 'S4 — Live Auction Room'),
  body: SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Content sections
      ],
    ),
  ),
);
```

---

## S5 — Auctioneer Command Center

**Route**: `/auction/:id/command`  
**Widget class**: `AuctioneerCommandScreen`  
**Sub-screens / states**: `AuctioneerMobileView`, `AuctioneerWebView`

**Purpose**: Auctioneer-only control panel. Start/pause/sell/unsell actions. Timer bar. Keyboard shortcuts on web.

**Sections:**
- S5 — Auctioneer Command Center
- 📱 Mobile — Auctioneer Panel: Timer Integration

**UI Content:**
- `TEXT` — Crichere — S5: Auctioneer Command Center (Updated)
- `TEXT` — Updated
- `HEADING` — Timer controls (start/stop/anti-snipe) · Dynamic increment badge · Round management · Full web command center · Undo/Force-assign modals

### Frame: `Auctioneer Mobile — Timer running (normal)`

**UI Content:**
- `TEXT` — 9:41 AM
- `TEXT` — Auctioneer
- `TEXT` — ● LIVE
- `TEXT` — Anjali Kumar
- `TEXT` — AR · Base ₹500
- `TEXT` — 60s
- `TEXT` — LEADING BID · Min next: ₹11,500
- `TEXT` — ₹9,500
- `TEXT` — Thunder Strikers · Increment: +₹2,000 (Tag A)
- `TEXT` — RECORD BID FOR FRANCHISE
- `TEXT` — ⭐ Thunder
- `TEXT` — ₹43K left
- `TEXT` — Lightning
- `TEXT` — ₹31K left
- `TEXT` — Blazers
- `TEXT` — ₹22K left
- `TEXT` — Phoenix
- `TEXT` — ₹18K left
- `TEXT` — Ctrl+Z
- `TEXT` — bidIncrement resolved from AuctionRoundBidIncrement (Tag A → ₹2,000)

**Badges/Chips:** `★ Tag A` · `UP`

**Actions / Buttons:**
- `[Button]` ⏸ Pause
- `[Button]` ⏹ Stop
- `[Button]` Record
- `[Button]` 🔨 SOLD
- `[Button]` UNSOLD
- `[Button]` Undo Last Bid

**Dev Notes (annotations from prototype):**
> POST /auctions/{id}/timer/stop · POST /auctions/{id}/bid

### Frame: `Auctioneer Mobile — Anti-snipe zone (≤10s)`

**UI Content:**
- `TEXT` — AR · ★ Tag A
- `TEXT` — ⚡ Anti-snipe
- `TEXT` — ⚡ Anti-snipe active — any bid now resets timer to 10s
- `TEXT` — LEADING BID — CALL IT!
- `TEXT` — Thunder Strikers
- `TEXT` — ₹43K
- `TEXT` — ₹31K
- `TEXT` — ₹22K
- `TEXT` — ₹18K

### Frame: `Round management + Timer config per round`

**Sections:**
- 🖥️ Web — Full Auctioneer Command Center

**UI Content:**
- `TEXT` — Round Control
- `TEXT` — Round 1 — Main
- `TEXT` — 82 sold · 38 remaining · All categories
- `TEXT` — Countdown:
- `TEXT` — Anti-snipe:
- `TEXT` — 10s
- `TEXT` — Increment:
- `TEXT` — Tag A ₹2K
- `TEXT` — Round 2 — Unsold
- `TEXT` — 38 players · Reduced increment · 45s timer
- `TEXT` — Round 3 — Accelerated
- `TEXT` — 30s timer · Open increment
- `TEXT` — Round timer config: POST .../rounds/{id}/bid-increments
- `TEXT` — countdownSeconds + antiSnipeSeconds in AuctionRound

**Badges/Chips:** `LIVE` · `PENDING`

**Actions / Buttons:**
- `[Button]` Settings
- `[Button]` Complete Round 1
- `[Button]` Configure Increments & Timer
- `[Button]` Skip

**Dev Notes (annotations from prototype):**
> PATCH /auctions/{id}/pause · /resume

### Frame: `Web — 3-column with timer ring + increment badge + audit log`

**Sections:**
- 🖥️ Web — Undo Sold Modal + Force Assign Modal

**UI Content:**
- `TEXT` — 🏏 Crichere
- `TEXT` — ● AUCTIONEER — TechCup 2026 · Round 1
- `TEXT` — PLAYER POOL
- `TEXT` — Browse = READ only · No SSE until PUT
- `TEXT` — Sam Patel
- `TEXT` — BAT · Tag B · ₹1,000
- `TEXT` — Mohan Kumar
- `TEXT` — BOWL · ₹500
- `TEXT` — Priya Nair
- `TEXT` — +87 more
- `TEXT` — SECS
- `TEXT` — Timer Running · 42s remaining
- `TEXT` — Round 1 · 60s countdown · Anti-snipe: 10s
- `TEXT` — POST /auctions/{id}/timer/start · /stop · GET /timer/state
- `TEXT` — CURRENT BID
- `TEXT` — ⭐ Thunder Strikers leading
- `TEXT` — Increment
- `TEXT` — +₹2,000
- `TEXT` — Tag A rule
- `TEXT` — Min next:

**Badges/Chips:** `All` · `BAT` · `BOWL` · `AR` · `NOW` · `ALL-ROUNDER` · `Right Hand` · `Advanced`

**Actions / Buttons:**
- `[Button]` Undo
- `[Button]` Put Up
- `[Button]` Reset
- `[Button]` Override
- `[Button]` SKIP
- `[Button]` Force Assign →
- `[Button]` Complete Round
- `[Button]` Full Log →

### Frame: `Undo Sold — Confirmation (last action only)`

**UI Content:**
- `TEXT` — ↩ Undo Sold
- `TEXT` — Only valid if PLAYER_SOLD was absolute last audit action
- `TEXT` — Anjali Kumar → Thunder Strikers
- `TEXT` — Final price: ₹12,500 · Seq #141
- `TEXT` — Restoring: purse += ₹12,500 (deterministic)
- `TEXT` — PlayerState → UP_FOR_BIDDING
- `TEXT` — REASON (required)
- `TEXT` — PATCH /auctions/{id}/player/undo-sold

**Actions / Buttons:**
- `[Button]` Cancel
- `[Button]` Undo Sold — Restore

### Frame: `Force Assign — Admin override`

**UI Content:**
- `TEXT` — Force Assign Player
- `TEXT` — LEAGUE_ADMIN only · Bypasses purse validation · Price = ₹0
- `TEXT` — Kiran Chandran — UNSOLD
- `TEXT` — Batter · Tag C · Base ₹500
- `TEXT` — ASSIGN TO FRANCHISE
- `TEXT` — Select franchise…
- `TEXT` — Thunder Strikers (11 remaining slots)
- `TEXT` — Lightning Kings (10 remaining)
- `TEXT` — ⚠ Force-assign records ₹0 final price. Purse NOT deducted. Reason required.
- `TEXT` — POST /auctions/{id}/player/force-assign · State → FORCE_ASSIGNED

**Actions / Buttons:**
- `[Button]` Force Assign

### Flutter Widget Structure

```dart
// AuctioneerCommandScreen — rough widget tree
Scaffold(
  backgroundColor: CricColor.appBg,
  appBar: CricAppBar(title: 'S5 — Auctioneer Command Center'),
  body: ResponsiveLayout(
    mobile: _MobileCommandView(),
    web: _WebCommandView(),   // wider layout, keyboard shortcuts
  ),
);
```

---

## S6 — League Admin & Setup

**Route**: `/league/:id/setup`  
**Widget class**: `LeagueSetupScreen`  
**Sub-screens / states**: `LeagueBasicInfoForm`, `AuctionRulesForm`, `PlayerPoolForm`

**Purpose**: Admin creates/edits a league. Upload banner, set rules (purse, format, rounds), manage player pool.

**Sections:**
- S6 — League Admin & Setup
- 📱 Mobile — Create League Flow

**UI Content:**
- `TEXT` — Crichere — S6: League Admin & Setup
- `HEADING` — Create/Edit league · Bulk CSV import · Auction initialize · Franchise management · Pre-assignment · Mobile + Web

### Frame: `Create League — Step 1 (Basic Info)`

**UI Content:**
- `TEXT` — 9:41 AM
- `HEADING` — Create League
- `TEXT` — Step 1 of 3 · Basic Info
- `TEXT` — Upload banner (10MB max · JPG/PNG)
- `LABEL` — LEAGUE LOGO
- `TEXT` — Tap to upload · PNG/JPG · 10MB
- `LABEL` — LEAGUE NAME
- `LABEL` — FORMAT
- `TEXT` — T20
- `TEXT` — T10
- `TEXT` — ODI
- `LABEL` — DESCRIPTION
- `INPUT` — Annual tech company cricket league
- `TEXT` — POST /leagues · POST /storage/presigned-url for logo/banner

**Actions / Buttons:**
- `[Button]` Next: Auction Rules →

### Frame: `Create League — Step 2 (Auction Rules)`

**UI Content:**
- `HEADING` — Auction Rules
- `TEXT` — Step 2 of 3
- `LABEL` — FRANCHISES
- `LABEL` — PLAYERS/TEAM
- `LABEL` — STARTING PURSE (₹ INR)
- `LABEL` — PLAYER ORDER MODE
- `TEXT` — RANDOM
- `TEXT` — FREE PICK
- `TEXT` — HYBRID
- `LABEL` — WAITING LIST MODE
- `TEXT` — AUTO_PROMOTE
- `TEXT` — ADMIN_PICKS
- `TEXT` — Must sell all players
- `TEXT` — Auction continues until all players sold
- `LABEL` — RULES PDF (optional)
- `TEXT` — 📄 Upload rules PDF · Max 50MB

**Actions / Buttons:**
- `[Button]` Next: Review & Publish →

### Frame: `Create League — Step 3 (Review)`

**Sections:**
- 📱 Mobile — Bulk CSV Import + Pre-assignment

**UI Content:**
- `HEADING` — Review & Publish
- `TEXT` — Step 3 of 3
- `TEXT` — TechCup 2026
- `TEXT` — Format
- `TEXT` — Franchises
- `TEXT` — Players/Team
- `TEXT` — Purse
- `TEXT` — ₹50,000
- `TEXT` — Order
- `TEXT` — Waitlist
- `TEXT` — AUTO
- `TEXT` — PATCH /leagues/{id}/status → OPEN · Status: DRAFT→OPEN→AUCTION_INITIALIZED

**Actions / Buttons:**
- `[Button]` Save as Draft
- `[Button]` 🚀 Publish League

### Frame: `Bulk Import — Upload & Preview`

**UI Content:**
- `HEADING` — Import Players
- `TEXT` — TechCup 2026 · CSV/JSON
- `TEXT` — Drop CSV here
- `TEXT` — Phone, Name, Category, BattingStyle, BowlingStyle, BasePrice
- `TEXT` — IMPORT RESULTS (120 rows)
- `TEXT` — ✓ Linked to ACTIVE users
- `TEXT` — Phone matched existing account
- `TEXT` — ↻ Reused GHOST + updated name
- `TEXT` — Ghost existed, name updated
- `TEXT` — + New GHOST created
- `TEXT` — No match — ghost profile made
- `TEXT` — ⚠ Already in league
- `TEXT` — already_in_league — skipped
- `TEXT` — POST /leagues/{id}/players/bulk-import · Exact match order: ACTIVE→GHOST→CREATE

**Actions / Buttons:**
- `[Button]` Confirm Import (118 players)

### Frame: `Pre-assignment (Captain + Icon)`

**UI Content:**
- `HEADING` — Pre-assign Players
- `TEXT` — Captain: deducted from purse at base price. Icon: FREE — no purse deduction.
- `TEXT` — Thunder Strikers
- `TEXT` — ₹50,000 purse
- `TEXT` — ★ CAPTAIN (purse deduction)
- `TEXT` — Anjali Kumar
- `TEXT` — ₹500
- `TEXT` — ★ ICON (FREE)
- `TEXT` — Ravi Sharma
- `TEXT` — FREE
- `TEXT` — POST /franchises/{id}/pre-assign · assignmentType: CAPTAIN or ICON

**Actions / Buttons:**
- `[Button]` Remove
- `[Button]` + Add Pre-assignment

### Frame: `Auction Initialize Checklist`

**Sections:**
- 🖥️ Web — League Admin Dashboard (Full)

**UI Content:**
- `HEADING` — Start Auction
- `TEXT` — TechCup 2026 · Pre-launch check
- `TEXT` — Players imported
- `TEXT` — 120 players ready
- `TEXT` — 8 franchises created
- `TEXT` — All have owners
- `TEXT` — Purses configured
- `TEXT` — ₹50,000 each
- `TEXT` — Auctioneer assigned
- `TEXT` — Priya (auctioneer@…)
- `TEXT` — 3 rounds configured
- `TEXT` — R1 Main · R2 Unsold · R3 Accel
- `TEXT` — Pre-assignments pending
- `TEXT` — 3 icon slots unfilled (optional)
- `TEXT` — POST /auctions/leagues/{id} → create auction
- `TEXT` — PATCH /auctions/{id}/start → status DRAFT→LIVE
- `TEXT` — League status: OPEN→AUCTION_INITIALIZED→AUCTION_LIVE

**Actions / Buttons:**
- `[Button]` 🏏 GO LIVE — Start Auction

### Frame: `Web — Admin Dashboard with all tabs`

**Sections:**
- 📱 Mobile — Base Price Configuration (New Screens)

**UI Content:**
- `TEXT` — 🏏 Crichere
- `TEXT` — / TechCup 2026 / Admin
- `TEXT` — 📊 Overview
- `TEXT` — 👥 Players
- `TEXT` — 🏟️ Franchises
- `TEXT` — 💰 Fees
- `TEXT` — ⚠️ Forfeits
- `TEXT` — 📋 Waitlist
- `TEXT` — 🔨 Auction
- `TEXT` — PLAYERS
- `TEXT` — 120
- `TEXT` — 8/8
- `TEXT` — FEES COLLECTED
- `TEXT` — 71%
- `TEXT` — PENDING FORFEITS
- `TEXT` — STATUS
- `TEXT` — OPEN
- `TEXT` — DRAFT→OPEN→AUCTION_INITIALIZED→AUCTION_LIVE
- `TEXT` — Players (120)
- `TEXT` — Name

**Badges/Chips:** `ACTIVE` · `PENDING`

**Actions / Buttons:**
- `[Button]` Edit League
- `[Button]` 🚀 Start Auction
- `[Button]` Import CSV
- `[Button]` + Add
- `[Button]` + Create

### Frame: `Category Prices — POST /leagues/{id}/category-prices`

**UI Content:**
- `HEADING` — Category Prices
- `TEXT` — TechCup 2026 · Base prices by role
- `TEXT` — BATTER
- `TEXT` — Category fallback price
- `TEXT` — BOWLER
- `TEXT` — ALL-ROUNDER
- `TEXT` — Editing…
- `TEXT` — WICKET-KEEPER
- `TEXT` — ⓘ 3-level resolution order:
- `TEXT` — 1. Player override (basePriceOverride)
- `TEXT` — 2. Tag price (A/B/C/D)
- `TEXT` — 3. Category price ← these fields
- `TEXT` — 4. Global player basePrice (fallback)
- `TEXT` — POST /leagues/{id}/category-prices · Upsert · Whole INR only

**Actions / Buttons:**
- `[Button]` Save

### Frame: `Tag Prices — POST /leagues/{id}/tag-prices`

**UI Content:**
- `HEADING` — Tag Prices
- `TEXT` — TechCup 2026 · Tier pricing A–D
- `TEXT` — Star
- `TEXT` — Premium tier · Overrides category
- `TEXT` — Premium
- `TEXT` — High tier · Overrides category
- `TEXT` — Standard
- `TEXT` — Mid tier
- `TEXT` — Budget
- `TEXT` — Entry tier
- `TEXT` — Players without a tag use category prices. Tag prices override category prices when both exist.
- `TEXT` — POST /leagues/{id}/tag-prices · Upsert all 4 tags

**Actions / Buttons:**
- `[Button]` Save All Tag Prices

### Frame: `Round Bid Increment Config — Per-round`

**Sections:**
- 📱 Mobile — Pre-assignment Manager (Full Flow)

**UI Content:**
- `HEADING` — Round 1 Increments
- `TEXT` — Bid step config · countdownSeconds
- `TEXT` — TIMER SETTINGS
- `TEXT` — Countdown (sec)
- `TEXT` — Anti-snipe (sec)
- `TEXT` — DEFAULT INCREMENT (fallback)
- `TEXT` — All untagged / unmatched players
- `TEXT` — TAG OVERRIDES (priority over category)
- `TEXT` — Star · Tag A
- `TEXT` — Premium · Tag B
- `TEXT` — CATEGORY OVERRIDES
- `TEXT` — Preview: Tag A → ₹2,000 · Tag B Batter → ₹1,000
- `TEXT` — Untagged Batter → ₹1,000 · Untagged Bowler → ₹500
- `TEXT` — POST /auctions/{id}/rounds/{roundId}/bid-increments
- `TEXT` — Only allowed when round status = PENDING

**Actions / Buttons:**
- `[Button]` + Add Tag Override
- `[Button]` + Add Category Override
- `[Button]` Save Increment Config

### Frame: `Step 1 — Player Search`

**UI Content:**
- `HEADING` — Assign Captain
- `TEXT` — AR · ★ Tag A · Base ₹500
- `TEXT` — BAT · Tag B · Base ₹1,000
- `TEXT` — Priya Nair
- `TEXT` — ⚠ Already assigned to Lightning Kings
- `TEXT` — BOWL · Base ₹500
- `TEXT` — POST /franchises/{id}/pre-assign · Only AVAILABLE players

**Actions / Buttons:**
- `[Button]` Assign
- `[Button]` Taken

### Frame: `Step 2A — Captain Confirmation (purse deduction)`

**UI Content:**
- `HEADING` — Assign as Captain
- `TEXT` — Confirmation
- `TEXT` — ALL-ROUNDER · ★ Tag A
- `TEXT` — Team: Thunder Strikers
- `TEXT` — ⚠ PURSE DEDUCTION
- `TEXT` — Captains are assigned at base price. This amount is immediately deducted from the starting purse.
- `TEXT` — Deduction (base price)
- `TEXT` — Starting purse
- `TEXT` — After assignment
- `TEXT` — ₹49,500
- `TEXT` — assignmentType: CAPTAIN · purse deducted immediately

**Actions / Buttons:**
- `[Button]` Cancel
- `[Button]` Confirm Captain

### Frame: `Step 2B — Icon Confirmation (FREE)`

**UI Content:**
- `HEADING` — Assign as Icon
- `TEXT` — Free assignment
- `TEXT` — BATTER · Tag B
- `TEXT` — ✅ FREE ASSIGNMENT
- `TEXT` — Icon players are marquee players assigned at ₹0. No purse deduction.
- `TEXT` — Deduction
- `TEXT` — ₹0 (FREE)
- `TEXT` — Purse unchanged
- `TEXT` — assignmentType: ICON · finalPrice = 0 · No purse deduction

**Actions / Buttons:**
- `[Button]` Confirm Icon ★

### Frame: `Current Pre-assignments (with remove + cross-team validation)`

**Sections:**
- 📱 Mobile + 🖥️ Web — Public Viewer Share Link

**UI Content:**
- `HEADING` — Pre-assignments
- `TEXT` — ★ CAPTAIN — ₹500 deducted
- `TEXT` — ALL-ROUNDER · Tag A
- `TEXT` — Removing restores ₹500 to purse
- `TEXT` — ★ ICON — FREE
- `TEXT` — Cannot pre-assign — this player is already pre-assigned to another franchise. Remove them there first.

### Frame: `Mobile — Public viewer link (admin)`

**UI Content:**
- `HEADING` — Share Auction
- `TEXT` — TechCup 2026 · AUCTION_LIVE
- `TEXT` — Public Viewer Link
- `TEXT` — Anyone can watch without logging in
- `TEXT` — https://app.crichere.in/view/a1b2c3d4e5f6...
- `TEXT` — GET /public/auctions/view/{token}
- `TEXT` — POST /auctions/{id}/regenerate-view-token

**Badges/Chips:** `LIVE`

**Actions / Buttons:**
- `[Button]` 📋 Copy
- `[Button]` 📱 WhatsApp
- `[Button]` 🖥️ Projector Display
- `[Button]` 🔄 Regen

### Frame: `Web — Public Viewer Card (Admin Dashboard)`

**UI Content:**
- `TEXT` — 📡 Live Public Viewer
- `TEXT` — Share this link for anyone to watch the auction without logging in
- `TEXT` — https://app.crichere.in/view/a1b2c3d4e5f6789abcdef
- `TEXT` — Code
- `TEXT` — Projector / venue QR
- `TEXT` — Print or display — audience scans to watch live
- `TEXT` — 🔒 Regenerate invalidates the old link immediately
- `TEXT` — GET /public/auctions/view/{token} · No auth · Read-only · Active only when AUCTION_LIVE

**Badges/Chips:** `AUCTION_LIVE`

**Actions / Buttons:**
- `[Button]` 📋 Copy Link
- `[Button]` 🖥️ Launch Projector
- `[Button]` 🔄 Regenerate

### Flutter Widget Structure

```dart
// LeagueSetupScreen — rough widget tree
Scaffold(
  backgroundColor: CricColor.appBg,
  appBar: CricAppBar(title: 'S6 — League Admin & Setup'),
  body: SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Content sections
      ],
    ),
  ),
);
```

---

## S7 — Fees, Forfeits & Waitlist

**Route**: `/league/:id/fees`  
**Widget class**: `FeesAndWaitlistScreen`  
**Sub-screens / states**: `FeeSummaryView`, `ForfeitRulesView`, `WaitlistView`

**Purpose**: Fee tracking per franchise. Forfeit rules configuration. Waitlist management.

**Sections:**
- S7 — Fees, Forfeits & Waitlist
- 📱 Mobile — Fee Obligations (Player view)

**UI Content:**
- `TEXT` — Crichere — S7: Fees, Forfeits & Waitlist
- `HEADING` — Mobile + Web · Full screens for fee collection, forfeit management, waitlist administration

### Frame: `My Fee — PARTIALLY_PAID`

**UI Content:**
- `TEXT` — 9:41 AM
- `HEADING` — My Fee Obligation
- `TEXT` — TechCup 2026 · Player Fee
- `TEXT` — ₹750
- `TEXT` — of ₹1,500 total · ₹750 remaining
- `TEXT` — Paid: ₹750
- `TEXT` — Min to register: ₹500 ✓
- `TEXT` — Due: ₹750
- `TEXT` — ✓ Minimum ₹500 paid — you're auction eligible
- `HEADING` — Payment History
- `TEXT` — Cash payment
- `TEXT` — Recorded by Rahul · 3 days ago
- `TEXT` — +₹750
- `TEXT` — Need to pay remaining ₹750?
- `TEXT` — Contact league admin to record payment.
- `TEXT` — V1 cash payments only.

**Badges/Chips:** `PARTIALLY PAID`

### Frame: `My Fee — PAID`

**UI Content:**
- `TEXT` — ₹1,500
- `TEXT` — Fully settled · Auction eligible
- `TEXT` — Cash — Final payment
- `TEXT` — May 8, 2026
- `TEXT` — Cash — First payment
- `TEXT` — May 5, 2026

**Badges/Chips:** `FULLY PAID`

### Frame: `My Fee — UNPAID (blocked)`

**Sections:**
- 📱 Mobile — Admin: Record Payment Modal + Waive

**UI Content:**
- `TEXT` — ₹0 / ₹1,500
- `TEXT` — ⚠️ Not auction-eligible until ₹500 is paid
- `TEXT` — You won't appear in the auction until minimum ₹500 is paid. Contact the league admin to record your payment.

**Badges/Chips:** `UNPAID`

**Actions / Buttons:**
- `[Button]` 📞 Contact Admin

### Frame: `Record Payment Modal`

**UI Content:**
- `HEADING` — Fee Management
- `TEXT` — TechCup 2026
- `TEXT` — ₹12,000
- `LABEL` — Collected
- `TEXT` — ₹9,000
- `LABEL` — Pending
- `TEXT` — 72%
- `LABEL` — Rate
- `HEADING` — 💳 Record Payment
- `LABEL` — PLAYER / FRANCHISE
- `TEXT` — Anjali Kumar
- `LABEL` — AMOUNT (₹)
- `LABEL` — OBLIGATION STATUS
- `TEXT` — ₹750 remaining
- `LABEL` — PAYMENT MODE
- `TEXT` — 💵 Cash
- `TEXT` — 🌐 Online (V2)
- `LABEL` — NOTES (optional)
- `TEXT` — POST /leagues/{id}/fee-obligations/{id}/payments

**Actions / Buttons:**
- `[Button]` Cancel
- `[Button]` Record ₹750

### Frame: `Waive Fee (with refund)`

**Sections:**
- 📱 Mobile — Forfeit Request Flow (Player + Admin)

**UI Content:**
- `HEADING` — Waive Fee
- `TEXT` — Irreversible · Terminal state
- `TEXT` — ⚠️ Waiving is permanent. Status will become WAIVED and cannot be changed.
- `TEXT` — Total: ₹1,500 · Paid: ₹750
- `LABEL` — REFUND DECISION
- `TEXT` — FULL REFUND — Return ₹750
- `TEXT` — PARTIAL REFUND — Custom amount
- `TEXT` — NO REFUND
- `LABEL` — REFUND AMOUNT (whole INR)
- `TEXT` — Fixed rupee amount · 0 ≤ refund ≤ paid amount (₹750)
- `LABEL` — ADMIN NOTES
- `TEXT` — PATCH /leagues/{id}/fee-obligations/{id}/waive

**Actions / Buttons:**
- `[Button]` Waive & Record Refund

### Frame: `Player — Submit Forfeit Request`

**UI Content:**
- `HEADING` — Forfeit League
- `TEXT` — ⚠️ Submitting a forfeit request will mark you as leaving this league. Refund decisions are made by the admin.
- `TEXT` — YOUR FEE STATUS
- `TEXT` — Player Fee
- `TEXT` — Paid: ₹750 of ₹1,500
- `LABEL` — FORFEIT TYPE
- `TEXT` — 🧍 Player
- `TEXT` — 🏟️ Franchise
- `LABEL` — REASON
- `INPUT` — Medical emergency — unable to participate
- `TEXT` — You can cancel this request before admin approves it.
- `TEXT` — POST /leagues/{id}/forfeit

**Badges/Chips:** `PARTIAL`

**Actions / Buttons:**
- `[Button]` Submit Forfeit Request

### Frame: `Admin — Forfeit Requests List`

**UI Content:**
- `HEADING` — Forfeit Requests
- `TEXT` — TechCup 2026 · 3 pending
- `TEXT` — Pending (3)
- `TEXT` — Approved
- `TEXT` — Rejected
- `TEXT` — PLAYER forfeit · Submitted 2 days ago
- `TEXT` — Medical emergency — unable to participate in TechCup 2026
- `TEXT` — Paid: ₹750 · Thunder Strikers slot
- `TEXT` — Ravi Sharma
- `TEXT` — PLAYER forfeit · 1 day ago
- `TEXT` — Relocated to another city
- `TEXT` — Paid: ₹0 · No refund needed
- `TEXT` — Lightning Kings
- `TEXT` — FRANCHISE forfeit · 3 days ago
- `TEXT` — Owner unable to manage team this season
- `TEXT` — Franchise fee: ₹10,000 · Paid: ₹10,000

**Badges/Chips:** `PENDING`

**Actions / Buttons:**
- `[Button]` Review & Approve
- `[Button]` Reject

### Frame: `Admin — Approve Forfeit + Refund Decision`

**Sections:**
- 📱 Mobile — Waiting List (Player view + Admin view)

**UI Content:**
- `HEADING` — Approve Forfeit
- `TEXT` — Terminal action
- `TEXT` — Reason: Medical emergency
- `TEXT` — Paid: ₹750 | Total: ₹1,500
- `TEXT` — FULL — Return all ₹750 paid
- `TEXT` — PARTIAL — Custom fixed amount
- `LABEL` — REFUND AMOUNT (₹)
- `TEXT` — Always whole INR integers · Never percentages
- `LABEL` — WAITING LIST ACTION
- `TEXT` — Auto-promote next
- `TEXT` — Admin picks
- `TEXT` — PATCH /leagues/{id}/forfeit-requests/{id}/approve

**Actions / Buttons:**
- `[Button]` Approve — Status → WAIVED

### Frame: `Player — My Waitlist Position`

**UI Content:**
- `HEADING` — Waiting List
- `TEXT` — TechCup 2026 · League full
- `TEXT` — YOUR POSITION
- `TEXT` — 2 people ahead of you
- `TEXT` — Mode:
- `TEXT` — AUTO_PROMOTE
- `TEXT` — You'll be notified when promoted
- `TEXT` — When someone forfeits, you'll automatically move up. You'll be promoted once you reach position #1.
- `HEADING` — Queue Preview
- `TEXT` — Suresh Patel
- `TEXT` — Joined May 7
- `TEXT` — Priya Nair
- `TEXT` — Joined May 8
- `TEXT` — You
- `TEXT` — Joined May 9
- `TEXT` — ← YOU
- `TEXT` — DELETE /leagues/{id}/waiting-list/{entryId}

**Badges/Chips:** `Next up`

**Actions / Buttons:**
- `[Button]` Withdraw from Queue

### Frame: `Admin — Waitlist (AUTO_PROMOTE)`

**UI Content:**
- `TEXT` — TechCup 2026 · AUTO_PROMOTE
- `TEXT` — AUTO_PROMOTE mode: next person in queue is automatically promoted when a spot opens up.
- `TEXT` — 5 in queue · Positions by createdAt ASC
- `TEXT` — Joined May 7 · Player
- `TEXT` — May 8 · Player
- `TEXT` — Vikram Das
- `TEXT` — May 9 · Player
- `TEXT` — Anita Singh

**Actions / Buttons:**
- `[Button]` Remove

### Frame: `Admin — Waitlist (ADMIN_PICKS)`

**Sections:**
- 🖥️ Web — Fee Management Dashboard

**UI Content:**
- `TEXT` — TechCup 2026 · ADMIN_PICKS
- `TEXT` — ADMIN_PICKS mode: you manually promote any entry (not just #1). Positions recalculate automatically.
- `TEXT` — 5 in queue · Tap "Promote" on any entry
- `TEXT` — Bat · Level B · May 7
- `TEXT` — Bowl · Level A · May 8
- `TEXT` — AR · Level A · May 9
- `TEXT` — Positions recalculate (1,2,3…) after each promotion · PESSIMISTIC_WRITE lock
- `TEXT` — PATCH /leagues/{id}/waiting-list/{entryId}/promote

**Actions / Buttons:**
- `[Button]` Promote

### Frame: `Admin Web — Full Fee Dashboard`

**Sections:**
- 🖥️ Web — Forfeit Requests + Waitlist Management

**UI Content:**
- `TEXT` — 🏏 Crichere
- `TEXT` — / TechCup 2026 / Fees
- `TEXT` — 🏠 Dashboard
- `TEXT` — 👥 Players
- `TEXT` — 🏟️ Franchises
- `TEXT` — 💰 Fees
- `TEXT` — ⚠️ Forfeits
- `TEXT` — 📋 Waitlist
- `TEXT` — 🔨 Auction
- `TEXT` — EXPECTED
- `TEXT` — ₹2.1L
- `TEXT` — COLLECTED
- `TEXT` — ₹1.5L
- `TEXT` — ₹60K
- `TEXT` — COLLECTION RATE
- `TEXT` — 71.4%
- `TEXT` — WAIVED
- `TEXT` — Player Fees
- `TEXT` — Franchise Fees
- `TEXT` — Player Fee Obligations

**Badges/Chips:** `PAID`

**Actions / Buttons:**
- `[Button]` Export CSV
- `[Button]` + Record Payment
- `[Button]` History
- `[Button]` Pay
- `[Button]` Waive

### Frame: `Admin Web — Forfeit + Waitlist`

**UI Content:**
- `TEXT` — / TechCup 2026 / Forfeits
- `TEXT` — PLAYER · 2d ago · Paid ₹750
- `TEXT` — Medical emergency
- `TEXT` — Karan Mehta
- `TEXT` — PLAYER · 1w ago · No refund
- `TEXT` — Relocation — no refund decision
- `TEXT` — Resolved by Rahul · Fee status → WAIVED
- `TEXT` — Sneha Rao
- `TEXT` — PLAYER · 5d ago
- `TEXT` — Insufficient reason per league rules
- `TEXT` — Resolved by Rahul
- `TEXT` — ADMIN_PICKS mode
- `TEXT` — After promoting, positions auto-recalculate (1,2,3…) by createdAt ASC. Row locking prevents concurrent collisions.

**Badges/Chips:** `3 Pending` · `APPROVED` · `REJECTED`

**Actions / Buttons:**
- `[Button]` Approve
- `[Button]` Details

### Flutter Widget Structure

```dart
// FeesAndWaitlistScreen — rough widget tree
Scaffold(
  backgroundColor: CricColor.appBg,
  appBar: CricAppBar(title: 'S7 — Fees, Forfeits & Waitlist'),
  body: SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Content sections
      ],
    ),
  ),
);
```

---

## S8 — Post-Auction & Exports

**Route**: `/auction/:id/results`  
**Widget class**: `PostAuctionScreen`  
**Sub-screens / states**: `ResultsSummaryTab`, `FranchiseSquadsTab`, `UnsoldPlayersTab`, `ExportOptionsTab`

**Purpose**: Auction results: stats, franchise squad view, unsold list, export to PDF/CSV/WhatsApp.

**Sections:**
- S8 — Post-Auction Summary & Exports
- 📱 Mobile — Post-Auction Summary Tabs

**UI Content:**
- `TEXT` — Crichere — S8: Post-Auction & Exports
- `HEADING` — Mobile + Web · Summary dashboards, audit log, PDF/image exports

### Frame: `Summary — Overview`

**UI Content:**
- `TEXT` — 9:41 AM
- `HEADING` — Auction Summary
- `TEXT` — TechCup 2026 · Completed
- `TEXT` — Overview
- `TEXT` — Squads
- `TEXT` — Unsold
- `TEXT` — Share
- `LABEL` — Players Sold
- `TEXT` — ₹8.4L
- `LABEL` — Total Spent
- `LABEL` — Franchises
- `HEADING` — Top Buys 🏆
- `TEXT` — Anjali Kumar
- `TEXT` — Thunder Strikers
- `TEXT` — ₹12,500
- `TEXT` — Sam Patel
- `TEXT` — Lightning Kings
- `TEXT` — ₹10,000
- `TEXT` — Rahul Das
- `TEXT` — Royal Blazers

### Frame: `Summary — Unsold Players`

**UI Content:**
- `TEXT` — Unsold (24)
- `TEXT` — 24 players went unsold across all rounds
- `TEXT` — All (24)
- `TEXT` — BAT (8)
- `TEXT` — BOWL (10)
- `TEXT` — AR (4)
- `TEXT` — WK (2)
- `TEXT` — Kiran Chandran
- `TEXT` — Batter · Base ₹500
- `TEXT` — Mohan Kumar
- `TEXT` — Bowler · Base ₹500
- `TEXT` — Arjun Pillai
- `TEXT` — All-rounder · Base ₹1,000
- `TEXT` — GET /auctions/{id}/summary/unsold

**Badges/Chips:** `UNSOLD`

**Actions / Buttons:**
- `[Button]` View all 24 unsold →

### Frame: `Summary — Share & Export`

**Sections:**
- 📱 Mobile — Auction Audit Log

**UI Content:**
- `TEXT` — TechCup 2026
- `TEXT` — 1. Anjali Kumar (C)
- `TEXT` — 2. Ravi Sharma
- `TEXT` — ₹7,000
- `TEXT` — 3. Priya Nair
- `TEXT` — ₹5,500
- `TEXT` — ...+12 more
- `TEXT` — crichere.app
- `TEXT` — Remaining: ₹6,800
- `TEXT` — 1080×1080 PNG — optimized for WhatsApp
- `TEXT` — GET .../franchises/{id}/export/image
- `TEXT` — GET .../franchises/{id}/export/pdf
- `TEXT` — GET .../summary/export/pdf

**Actions / Buttons:**
- `[Button]` 📱 Share Squad Image (WhatsApp)
- `[Button]` 📄 Download Squad PDF
- `[Button]` 📊 Full Auction PDF Report

### Frame: `Audit Log — Timeline View`

**UI Content:**
- `HEADING` — Audit Log
- `TEXT` — TechCup 2026 · 284 events
- `TEXT` — All
- `TEXT` — BID_PLACED
- `TEXT` — PLAYER_SOLD
- `TEXT` — UNDO
- `TEXT` — Anjali Kumar sold
- `TEXT` — #284
- `TEXT` — Thunder Strikers · Priya (auctioneer) · 7:42 PM
- `TEXT` — Bid ₹12,500 — Thunder Strikers
- `TEXT` — #283
- `TEXT` — Recorded by Priya · 7:41 PM
- `TEXT` — Bid ₹11,000 — Lightning Kings
- `TEXT` — #282
- `TEXT` — 7:41 PM
- `TEXT` — BID UNDONE — ₹9,500 Royal Blazers
- `TEXT` — #281
- `TEXT` — Reason: "Wrong franchise selected" · 7:40 PM
- `TEXT` — Anjali Kumar put up for bidding
- `TEXT` — #280

### Frame: `Franchise Squad Summary`

**Sections:**
- 🖥️ Web — Post-Auction Summary Dashboard

**UI Content:**
- `TEXT` — Final Squad · TechCup 2026
- `TEXT` — STARTING PURSE
- `TEXT` — ₹50,000
- `TEXT` — SPENT
- `TEXT` — ₹43,200
- `TEXT` — REMAINING
- `TEXT` — ₹6,800
- `TEXT` — 15/15 slots filled
- `TEXT` — 86% purse used
- `HEADING` — Squad (15)
- `TEXT` — ★ C
- `TEXT` — All-rounder
- `TEXT` — Ravi Sharma
- `TEXT` — ★ ICON
- `TEXT` — Batter · Pre-assigned
- `TEXT` — FREE
- `TEXT` — Pradeep Das
- `TEXT` — Bowler
- `TEXT` — ₹3,500
- `TEXT` — +12 more players

**Actions / Buttons:**
- `[Button]` 📱 WhatsApp Image
- `[Button]` 📄 PDF

### Frame: `Web — Full Summary Dashboard`

**Sections:**
- 🖥️ Web — Audit Log Full View

**UI Content:**
- `TEXT` — 🏏 Crichere
- `TEXT` — / TechCup 2026 / Post-Auction
- `TEXT` — 🔨 Auction
- `TEXT` — 📊 Summary
- `TEXT` — 📋 Audit Log
- `TEXT` — 📤 Exports
- `TEXT` — 284
- `LABEL` — Audit Events
- `TEXT` — Franchise Results
- `TEXT` — Team
- `TEXT` — Spent
- `TEXT` — Players
- `TEXT` — Remaining
- `TEXT` — 15/15
- `TEXT` — ₹38,500
- `TEXT` — ₹11,500
- `TEXT` — ₹45,000
- `TEXT` — ₹5,000
- `TEXT` — Phoenix XI
- `TEXT` — ₹30,000

**Actions / Buttons:**
- `[Button]` 📄 Export PDF
- `[Button]` Squad

### Frame: `Web — Auction Audit Log`

**Sections:**
- 📱 Mobile — Share Tab: Public Replay Link

**UI Content:**
- `TEXT` — / TechCup 2026 / Audit Log
- `TEXT` — Seq #
- `TEXT` — Action
- `TEXT` — Player
- `TEXT` — Franchise
- `TEXT` — Amount
- `TEXT` — Actor
- `TEXT` — Time
- `TEXT` — Payload
- `TEXT` — Priya
- `TEXT` — 7:42 PM
- `TEXT` — ₹9,500
- `TEXT` — 7:40 PM
- `TEXT` — Rahul (admin)
- `TEXT` — 7:35 PM
- `TEXT` — 284 total events · All 15+ action types · SSE replay uses sequenceNumber > Last-Event-ID

**Actions / Buttons:**
- `[Button]` All Actions
- `[Button]` PLAYER_UP
- `[Button]` BID_UNDONE
- `[Button]` FORCE_ASSIGNED
- `[Button]` JSON

### Frame: `Share tab — with public replay URL (updated)`

**UI Content:**
- `HEADING` — Squad Image
- `HEADING` — Public Auction Replay
- `TEXT` — Anyone can view the full auction replay without logging in
- `TEXT` — https://app.crichere.in/view/a1b2c3d4e5f6...
- `TEXT` — Replay is read-only. Bidding is closed.
- `HEADING` — Reports
- `TEXT` — GET .../franchises/{id}/export/image (1080×1080)
- `TEXT` — GET /public/auctions/view/{token} — replay link
- `TEXT` — GET .../summary/export/pdf · GET .../franchises/{id}/export/pdf

**Actions / Buttons:**
- `[Button]` 📱 Share Squad Image
- `[Button]` 📋 Copy Link
- `[Button]` 📱 WhatsApp

### Flutter Widget Structure

```dart
// PostAuctionScreen — rough widget tree
Scaffold(
  backgroundColor: CricColor.appBg,
  appBar: CricAppBar(title: 'S8 — Post-Auction & Exports'),
  body: SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Content sections
      ],
    ),
  ),
);
```

---

## S9 — Profile, Squad & Settings

**Route**: `/profile`  
**Widget class**: `ProfileScreen`  
**Sub-screens / states**: `MyProfileTab`, `MySquadTab`, `SettingsTab`

**Purpose**: User profile, registered squad/franchise info, app settings.

**Sections:**
- S9 — Profile, Franchise Squad & Settings
- 📱 Mobile — Player Profile (Own + Public)

**UI Content:**
- `TEXT` — Crichere — S9: Profile, Squad & Settings
- `HEADING` — Mobile + Web · Player profile, cricket stats, franchise squad, app settings

### Frame: `My Profile — View`

**UI Content:**
- `TEXT` — 9:41 AM
- `TEXT` — My Profile
- `TEXT` — Anjali Kumar
- `TEXT` — BATTING
- `TEXT` — Right Hand
- `TEXT` — BOWLING
- `TEXT` — Off Spin
- `TEXT` — EXPERIENCE
- `TEXT` — Advanced
- `TEXT` — JERSEY
- `TEXT` — CITY
- `TEXT` — Kochi, Kerala
- `TEXT` — Leagues
- `TEXT` — Auction History
- `TEXT` — TechCup 2026
- `TEXT` — Thunder Strikers · Sold ₹12,500
- `TEXT` — CorpLeague 2025
- `TEXT` — Storm Riders · Sold ₹8,000

**Badges/Chips:** `ALL-ROUNDER` · `ACTIVE` · `LIVE` · `COMPLETED`

**Actions / Buttons:**
- `[Button]` Edit

### Frame: `Edit Profile`

**UI Content:**
- `TEXT` — PUT /users/{id}/cricket-profile
- `TEXT` — Max 5MB · JPEG/PNG/WebP
- `LABEL` — FULL NAME
- `LABEL` — PLAYING ROLE
- `TEXT` — 🏏 Batter
- `TEXT` — 🎯 Bowler
- `TEXT` — ⚡ All-rounder ✓
- `TEXT` — 🧤 WK
- `LABEL` — BATTING STYLE
- `TEXT` — Left Hand
- `LABEL` — EXPERIENCE LEVEL
- `TEXT` — Beginner
- `TEXT` — Intermediate
- `TEXT` — Advanced ✓
- `TEXT` — Pro

**Actions / Buttons:**
- `[Button]` ✏️
- `[Button]` Save Profile

### Frame: `Public Player Profile`

**Sections:**
- 📱 Mobile — Franchise Squad (Owner view)

**UI Content:**
- `HEADING` — Player Profile
- `TEXT` — PUBLIC view
- `TEXT` — Sam Patel
- `TEXT` — Professional
- `TEXT` — League History
- `TEXT` — ₹10,000
- `TEXT` — Lightning Kings
- `TEXT` — profileVisibility: PUBLIC · GET /users/{id}

**Badges/Chips:** `BATTER`

### Frame: `My Franchise Squad`

**UI Content:**
- `HEADING` — Thunder Strikers
- `TEXT` — TechCup 2026 · Owner
- `TEXT` — PURSE REMAINING
- `TEXT` — ₹6,800
- `TEXT` — SLOTS
- `TEXT` — /15
- `TEXT` — All (15)
- `TEXT` — Auctioned
- `TEXT` — Pre-set
- `TEXT` — ★ CAPTAIN
- `TEXT` — AR · Adv
- `TEXT` — ₹12,500
- `TEXT` — Ravi Sharma
- `TEXT` — ★ ICON
- `TEXT` — BAT · Pro
- `TEXT` — FREE
- `TEXT` — Pradeep Das
- `TEXT` — BOWL · Inter
- `TEXT` — ₹3,500
- `TEXT` — +12 more players

**Actions / Buttons:**
- `[Button]` 📱 Share
- `[Button]` 📄 PDF
- `[Button]` Invite

### Frame: `Invite Co-owner`

**Sections:**
- 📱 Mobile — App Settings

**UI Content:**
- `TEXT` — Share this invite link
- `TEXT` — crichere.app/invite/TS-2026-abc123xyz
- `TEXT` — Link expires in 7 days · Anyone with this link can join as co-owner
- `HEADING` — Team Members
- `TEXT` — Vikram Kumar
- `TEXT` — Primary Owner
- `TEXT` — Nisha Rao
- `TEXT` — Co-owner

**Badges/Chips:** `YOU`

**Actions / Buttons:**
- `[Button]` 📋 Copy
- `[Button]` 📱 WhatsApp
- `[Button]` Remove

### Frame: `Settings — Notifications`

**UI Content:**
- `HEADING` — Settings
- `TEXT` — ACCOUNT
- `TEXT` — Phone number
- `TEXT` — +91 98765 43210
- `TEXT` — Verified ✓
- `TEXT` — NOTIFICATIONS
- `TEXT` — Auction events
- `TEXT` — Player sold, bid updates
- `TEXT` — League updates
- `TEXT` — League status changes
- `TEXT` — Fee reminders
- `TEXT` — Payment due alerts
- `TEXT` — Push platform
- `TEXT` — FCM (Android) / APNs (iOS)
- `TEXT` — DEVICES
- `TEXT` — Registered Devices
- `TEXT` — 📱 Pixel 7 Pro
- `TEXT` — FCM · Added May 1
- `TEXT` — This device
- `TEXT` — 📱 iPhone 14

### Frame: `Notification History`

**Sections:**
- 🖥️ Web — Player Profile & Account (Self)

**UI Content:**
- `HEADING` — Notifications
- `TEXT` — UNREAD
- `TEXT` — You were SOLD! ₹12,500
- `TEXT` — Anjali Kumar sold to Thunder Strikers for ₹12,500 in TechCup 2026
- `TEXT` — 7:42 PM · Tap to view
- `TEXT` — Auction started — TechCup 2026
- `TEXT` — The auction is now live. Connect to watch
- `TEXT` — 7:00 PM
- `TEXT` — EARLIER
- `TEXT` — Fee payment recorded
- `TEXT` — ₹750 recorded by admin Rahul for TechCup 2026
- `TEXT` — May 8 · Read
- `TEXT` — GET /notifications · PATCH /notifications/{id}/read

### Frame: `Web — Profile Page`

**UI Content:**
- `TEXT` — 🏏 Crichere
- `TEXT` — 🏠 Home
- `TEXT` — 🏆 My Leagues
- `TEXT` — 👤 Profile
- `TEXT` — 🔔 Notifications
- `TEXT` — ⚙️ Settings
- `TEXT` — EXP LEVEL
- `TEXT` — League
- `TEXT` — Team
- `TEXT` — Status
- `TEXT` — Sold For
- `TEXT` — Date
- `TEXT` — May 2026
- `TEXT` — Storm Riders
- `TEXT` — ₹8,000
- `TEXT` — Dec 2025
- `HEADING` — Notification Preferences
- `TEXT` — Auction events (sold, started)
- `TEXT` — FCM HIGH priority

### Flutter Widget Structure

```dart
// ProfileScreen — rough widget tree
Scaffold(
  backgroundColor: CricColor.appBg,
  appBar: CricAppBar(title: 'S9 — Profile, Squad & Settings'),
  body: SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Content sections
      ],
    ),
  ),
  bottomNavigationBar: CricBottomNav(),
);
```

---

## S10 — UI States & Platform Admin

**Route**: `/admin`  
**Widget class**: `PlatformAdminScreen`  
**Sub-screens / states**: `LoadingShimmerState`, `EmptyState`, `ErrorState`, `PlatformAdminDashboard`

**Purpose**: Skeleton shimmer loaders, empty/error states, and super-admin panel.

**Sections:**
- S10 — UI States & Platform Admin
- 📱 Mobile — Shimmer Loading States

**UI Content:**
- `TEXT` — Crichere — S10: UI States & Platform Admin
- `HEADING` — Loading states, error states, connectivity loss, empty states · Platform admin web dashboard

### Frame: `Shimmer — League list`

**UI Content:**
- `TEXT` — 9:41 AM
- `TEXT` — Shows if data > 300ms · max 10 items · 10s timeout → error

### Frame: `Shimmer — Auction player card`

**Sections:**
- 📱 Mobile — Connectivity & SSE Disconnect States

### Frame: `SSE Disconnected (auction room)`

**UI Content:**
- `TEXT` — Round 1
- `TEXT` — ● LIVE
- `TEXT` — Connection Lost
- `TEXT` — Reconnecting with exponential backoff
- `TEXT` — 2s → 4s → 8s → 30s cap
- `TEXT` — Attempt 2/∞ · Next in 4s
- `TEXT` — On reconnect: GET /auctions/{id}/state
- `TEXT` — then re-attach SSE with Last-Event-ID

**Actions / Buttons:**
- `[Button]` Retry now

### Frame: `Offline — Bid blocked (SnackBar)`

**UI Content:**
- `TEXT` — Anjali Kumar
- `TEXT` — All-rounder
- `TEXT` — ₹9,500
- `TEXT` — Thunder Strikers leading
- `TEXT` — ⚠️ You're offline
- `TEXT` — No internet connection
- `TEXT` — Bidding blocked
- `TEXT` — connectivity_plus offline · No auto-queue · Manual retry required

**Actions / Buttons:**
- `[Button]` +500
- `[Button]` +1K
- `[Button]` +2K
- `[Button]` BID

### Frame: `Purse Depleted / Insufficient Funds`

**Sections:**
- 📱 Mobile — Empty States & Errors

**UI Content:**
- `TEXT` — Sam Patel
- `TEXT` — ₹7,500
- `TEXT` — Purse remaining
- `TEXT` — ₹1,200
- `TEXT` — ⚠️ Next bid ₹8,000 exceeds your purse
- `TEXT` — InsufficientPurseException · Bid buttons shake + turn gray

**Actions / Buttons:**
- `[Button]` 🔒 Insufficient Purse

### Frame: `Empty — No leagues yet`

**UI Content:**
- `TEXT` — My Leagues
- `TEXT` — No leagues yet
- `TEXT` — You haven't joined any leagues. Ask an admin to invite you or discover public leagues.

**Actions / Buttons:**
- `[Button]` Discover Leagues →

### Frame: `Error state — 10s timeout + Retry`

**UI Content:**
- `TEXT` — Discover
- `TEXT` — Failed to load
- `TEXT` — Shimmer timeout after 10s. Check your connection and try again.

**Actions / Buttons:**
- `[Button]` ↺ Retry

### Frame: `Auction ended / round complete`

**Sections:**
- 🖥️ Web — Platform Admin Dashboard

**UI Content:**
- `TEXT` — Auction Complete!
- `TEXT` — TechCup 2026 auction has ended.
- `TEXT` — 96 players sold · ₹8.4L total

**Actions / Buttons:**
- `[Button]` View Summary
- `[Button]` Share

### Frame: `Platform Admin — Users & Leagues`

**Sections:**
- 🖥️ Web — Platform Metrics (Prometheus)

**UI Content:**
- `TEXT` — 🏏 Crichere Admin
- `TEXT` — PLATFORM ADMIN
- `TEXT` — PLATFORM_ADMIN role required
- `TEXT` — 👥 Users
- `TEXT` — 🏆 Leagues
- `TEXT` — 📊 Metrics
- `TEXT` — 💳 Subscriptions
- `TEXT` — TOTAL USERS
- `TEXT` — 2,841
- `TEXT` — ACTIVE
- `TEXT` — 1,203
- `TEXT` — GHOST
- `TEXT` — 1,528
- `TEXT` — LIVE AUCTIONS
- `TEXT` — TOTAL LEAGUES
- `TEXT` — 148
- `TEXT` — User Management
- `TEXT` — User
- `TEXT` — Phone
- `TEXT` — Status

**Badges/Chips:** `SUSPENDED` · `● AUCTION LIVE` · `COMPLETED`

**Actions / Buttons:**
- `[Button]` Manage
- `[Button]` Unsuspend

### Frame: `Metrics Dashboard — Prometheus key metrics`

**Sections:**
- 📱 Mobile — SSE Reconnection Guard: Exact 2-Step Sequence

**UI Content:**
- `TEXT` — / Metrics
- `TEXT` — GET /actuator/prometheus · PLATFORM_ADMIN role
- `TEXT` — crichere.otp.sent
- `TEXT` — 14,382
- `TEXT` — Total OTP sends
- `TEXT` — crichere.otp.verified
- `TEXT` — 11,203
- `TEXT` — Verification rate: 77.9%
- `TEXT` — crichere.auction.started
- `TEXT` — Total auctions started
- `TEXT` — crichere.auction.bids.placed
- `TEXT` — 42,817
- `TEXT` — Total bids recorded
- `TEXT` — crichere.auction.players.sold
- `TEXT` — 9,240
- `TEXT` — Total players auctioned
- `TEXT` — SSE connections (live)
- `TEXT` — 3,842
- `TEXT` — Target: 5,000/auction max
- `TEXT` — Every request receives and returns an

### Frame: `Mobile — Reconnect sequence (spec-accurate)`

**UI Content:**
- `TEXT` — Reconnect Initiated
- `TEXT` — Connection restored — syncing state…
- `TEXT` — GET /auctions/{'{'}id{'}'}/state
- `TEXT` — Updates on completion:
- `TEXT` — lastSequenceNumber
- `TEXT` — → #283
- `TEXT` — currentHighestBid
- `TEXT` — → ₹11,500
- `TEXT` — timerStartedAt
- `TEXT` — + remainingSeconds
- `TEXT` — playerAuctionState
- `TEXT` — + soldToFranchise
- `TEXT` — franchisePurseStates
- `TEXT` — for all teams
- `TEXT` — → "State snapshot fetched. Seq: #283"
- `TEXT` — GET /auctions/{'{'}id{'}'}/events
- `TEXT` — Header:
- `TEXT` — Last-Event-ID: 283
- `TEXT` — Server replays events #284 onwards
- `TEXT` — Client discards any seq ≤ 283

### Frame: `Web — Horizontal reconnect flow diagram`

**UI Content:**
- `TEXT` — SSE Reconnection Guard — Web Flow
- `TEXT` — OFFLINE
- `TEXT` — UI dimmed
- `TEXT` — GET /state
- `TEXT` — snapshot sync
- `TEXT` — Sync seq #283
- `TEXT` — update local state
- `TEXT` — GET /events
- `TEXT` — after=283
- `TEXT` — LIVE ✓
- `TEXT` — streaming
- `TEXT` — State fields synced from /state
- `TEXT` — timerStartedAt + remainingSeconds
- `TEXT` — franchisePurseStates[*]
- `TEXT` — minimumNextBid
- `TEXT` — bidIncrement
- `TEXT` — SSE deduplication rule
- `TEXT` — On each incoming SSE event:
- `TEXT` — if (event.seq ≤ localSeq) DISCARD
- `TEXT` — else APPLY + update localSeq

### Flutter Widget Structure

```dart
// PlatformAdminScreen — rough widget tree
Scaffold(
  backgroundColor: CricColor.appBg,
  appBar: CricAppBar(title: 'S10 — UI States & Platform Admin'),
  body: ResponsiveLayout(
    mobile: _MobileCommandView(),
    web: _WebCommandView(),   // wider layout, keyboard shortcuts
  ),
);
```

---

## S11 — Franchise Invite Onboarding

**Route**: `/invite/:token`  
**Widget class**: `FranchiseInviteScreen`  
**Sub-screens / states**: `InviteLandingScreen`, `FranchiseDetailsForm`, `ConfirmJoinScreen`

**Purpose**: Deep-link invite flow. Franchise owner accepts invite, sets franchise name/logo, confirms join.

**Sections:**
- S11 — Franchise Invite Onboarding
- 📱 Mobile — Invite Acceptance Happy Path

**UI Content:**
- `TEXT` — Crichere — S11: Franchise Invite Onboarding
- `HEADING` — Receiver-side deep-link flow · No-auth landing → OTP login → Accept → Success · Error states

### Frame: `Screen 1 — Landing (no auth required)`

**UI Content:**
- `TEXT` — 9:41 AM
- `TEXT` — 🏏 Crichere
- `TEXT` — You've been invited to own
- `TEXT` — Thunder Strikers
- `TEXT` — TechCup 2026 · T20
- `TEXT` — ₹50,000
- `TEXT` — Starting purse
- `TEXT` — Player slots
- `TEXT` — Invited by
- `TEXT` — Rahul Kumar
- `TEXT` — Expires: May 17, 2026 · 6 days left
- `TEXT` — Already have an account? Log in
- `TEXT` — New to Crichere? We'll set you up
- `TEXT` — Returns: franchise, league, invitedBy, expiresAt
- `TEXT` — requiresAccount: true — no auth needed to VIEW this screen

**Actions / Buttons:**
- `[Button]` Log in to Accept →

**Dev Notes (annotations from prototype):**
> POST /invites/validate → called on deep-link open

### Frame: `Screen 2 — Accept (authenticated, FRANCHISE_OWNER role)`

**UI Content:**
- `TEXT` — Claim Your Team
- `TEXT` — TechCup 2026 · T20 · ₹50,000 purse
- `TEXT` — Invited by:
- `TEXT` — (LEAGUE_ADMIN)
- `TEXT` — BY ACCEPTING YOU BECOME
- `TEXT` — FRANCHISE_OWNER of Thunder Strikers
- `TEXT` — Eligible to bid in live auctions
- `TEXT` — Can invite co-owners to your team
- `TEXT` — Access to franchise squad + purse
- `TEXT` — Claiming as: Vikram Kumar
- `TEXT` — +91 98765 43210 · ACTIVE account
- `TEXT` — Creates UserFranchiseMembership · Franchise.status → ACTIVE
- `TEXT` — Notifies LEAGUE_ADMIN via FCM/APNs

**Actions / Buttons:**
- `[Button]` Claim Team — Thunder Strikers
- `[Button]` Decline

**Dev Notes (annotations from prototype):**
> POST /invites/accept · JWT required

### Frame: `Screen 3 — Success (ownership confirmed)`

**Sections:**
- 📱 Mobile — Invite Error States

**UI Content:**
- `TEXT` — Congratulations!
- `TEXT` — You now own
- `TEXT` — Starting Purse
- `TEXT` — /15
- `TEXT` — Squad Slots
- `TEXT` — Redirects to franchise squad dashboard
- `TEXT` — UserFranchiseMembership created
- `TEXT` — Push notification sent to LEAGUE_ADMIN

**Actions / Buttons:**
- `[Button]` Go to My Team →

**Dev Notes (annotations from prototype):**
> Franchise.status: PENDING → ACTIVE

### Frame: `Error — Invite Expired`

**UI Content:**
- `TEXT` — Invitation Expired
- `TEXT` — This invitation has expired. Contact the league admin for a new link.
- `TEXT` — Franchise
- `TEXT` — Thunder Strikers · TechCup 2026
- `TEXT` — Expired: May 17, 2026
- `TEXT` — messageKey: "error.invite_expired"

**Actions / Buttons:**
- `[Button]` Go to Home

**Dev Notes (annotations from prototype):**
> POST /invites/validate → 410 Gone

### Frame: `Error — Already Accepted`

**UI Content:**
- `TEXT` — Already Claimed
- `TEXT` — This team already has an owner. Contact the league admin if you believe this is an error.
- `TEXT` — Status: ACTIVE · Owner assigned
- `TEXT` — messageKey: "error.invite_already_used"

**Dev Notes (annotations from prototype):**
> POST /invites/validate → 409 Conflict

### Frame: `Error — Profile Not Active (Ghost user)`

**Sections:**
- 🖥️ Web — Admin: Invite Management Panel

**UI Content:**
- `TEXT` — ⚠ Complete your profile first
- `TEXT` — Your profile is still in GHOST status. Complete your cricket profile before claiming a franchise.
- `TEXT` — Signed in as
- `TEXT` — +91 98765 43210
- `TEXT` — Profile status: GHOST — not yet completed
- `TEXT` — messageKey: "error.profile_not_active"
- `TEXT` — profileStatus must be ACTIVE to accept

**Actions / Buttons:**
- `[Button]` Complete My Profile →

**Dev Notes (annotations from prototype):**
> POST /invites/accept → 422

### Frame: `Admin — Create & Manage Franchise Invites`

**UI Content:**
- `TEXT` — Franchise Invites — Thunder Strikers
- `TEXT` — Create New Invite
- `TEXT` — EXPIRES IN (DAYS)
- `TEXT` — MAX USES
- `TEXT` — NOTE (optional)
- `TEXT` — Active Invites
- `TEXT` — TS-2026-abc123xyz...
- `TEXT` — For Vikram · Expires May 17 · 1 use
- `TEXT` — TS-2026-def456...
- `TEXT` — For Nisha (co-owner) · Accepted May 3
- `TEXT` — POST /franchises/{id}/invites · GET /franchises/{id}/invites · DELETE /franchises/{id}/invites/{id}

**Badges/Chips:** `PENDING` · `ACCEPTED`

**Actions / Buttons:**
- `[Button]` Generate Invite Link
- `[Button]` 📋 Copy
- `[Button]` 📱 Share
- `[Button]` Revoke

### Flutter Widget Structure

```dart
// FranchiseInviteScreen — rough widget tree
Scaffold(
  backgroundColor: CricColor.appBg,
  body: SafeArea(
    child: SingleChildScrollView(
      padding: EdgeInsets.all(CricSpacing.page),
      child: Column(
        children: [
          // Logo / hero section
          // Form fields
          // Primary CTA button (CricButtonStyle.primary)
        ],
      ),
    ),
  ),
);
```

---

## Design System Quick Reference

### Colors

| Token | Hex | Usage |
|---|---|---|
| `CricColor.appBg` | #060C1A | Scaffold background |
| `CricColor.navy` | #0A0F1E | Phone/screen bg |
| `CricColor.slate2` | #1E293B | Card background |
| `CricColor.slate3` | #243047 | Input field background |
| `CricColor.gold` | #F59E0B | Primary CTA, logo, live bid |
| `CricColor.green` | #22C55E | Success, sold, active |
| `CricColor.red` | #EF4444 | LIVE badge, error, danger |
| `CricColor.blue` | #3B82F6 | Upcoming, info |
| `CricColor.textPrimary` | #F1F5F9 | Main text |
| `CricColor.textDim` | #94A3B8 | Secondary / meta text |
| `CricColor.textFaint` | #64748B | Placeholder / captions |

### Badge Variants

```dart
// Usage pattern for all status badges:
CricBadge(label: 'LIVE',     color: CricColor.red);
CricBadge(label: 'T20',      color: CricColor.gold);
CricBadge(label: 'Upcoming', color: CricColor.blue);
CricBadge(label: 'Android',  color: CricColor.green);
CricBadge(label: 'iOS',      color: CricColor.blue);
CricBadge(label: 'Web',      color: CricColor.textDim);
```

### Typography Rules

- **App name / Logo**: `CricTextStyle.logo` (Rajdhani 700, gold)
- **Player names / big headings**: `CricTextStyle.displayLg` (Rajdhani 700)
- **Section headings**: `CricTextStyle.headingMd` (DM Sans 600)
- **Body text**: `CricTextStyle.body` (DM Sans 400)
- **Captions / meta**: `CricTextStyle.caption` (DM Sans 400, textDim)
- **ALL CAPS overlines**: `CricTextStyle.overline` (Rajdhani 700, 10px, letterSpacing 1)
- **Bid amounts**: `CricTextStyle.bidNumber` (Rajdhani 700, 40px, gold)
- **API routes / mono**: `CricTextStyle.mono` (JetBrains Mono 500)

### Spacing Scale

```dart
CricSpacing.xs    // 4.0
CricSpacing.sm    // 8.0
CricSpacing.md    // 12.0
CricSpacing.base  // 16.0
CricSpacing.lg    // 20.0
CricSpacing.xl    // 24.0
CricSpacing.xxl   // 32.0
CricSpacing.page  // 24.0 — horizontal screen padding
```

### Responsive Breakpoints

| Breakpoint | Width | Layout |
|---|---|---|
| Mobile | < 600px | Single column, bottom nav |
| Tablet | 600–900px | Two-column where applicable |
| Web/Desktop | > 900px | Wide layout, top nav, side panels |

---
*Generated from Crichere HTML Prototype (S1–S11). Token file: `crichere_design_tokens.dart`*