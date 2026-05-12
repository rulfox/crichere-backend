# UI/UX Design Specification: Crichere Auction Platform

**Purpose:** This document serves as a comprehensive design directive for generating high-fidelity UI mockups and prototypes. It is optimized for use with AI design tools (like Claude) to ensure a consistent, premium, and functional user experience.

---

## 1. Visual Identity & Design System

### Color Palette
- **Backgrounds:** 
  - Base: `#0F172A` (Midnight Navy)
  - Surface: `#1E293B` (Slate Navy)
- **Accents:**
  - **Cricket Green:** `#22C55E` (Used for "Active", "Success", and Brand Identity)
  - **Auction Gold:** `#F59E0B` (Used for "Premium", "Winning Bids", and "VIP")
  - **Live Red:** `#EF4444` (Used for "Live" status and "Critical Alerts")
- **Typography:**
  - Font: `Montserrat` or `Inter`
  - Style: High-contrast, bold for numbers/amounts, clean sans-serif for labels.

### Visual Style
- **Aesthetic:** Modern, Sporty, and High-Impact.
- **Glassmorphism:** Use subtle blurring and semi-transparent layers for modal windows and overlays.
- **Micro-interactions:** 
  - Pulsing "LIVE" indicators.
  - Number counting animations for bid price updates.
  - Haptic-feedback-inspired button states.

---

## 2. Core Screen Specifications

### Screen A: Live Auction Room (Participant View - Mobile)
- **Hero Element:** A dynamic Player Card showing photo, name, and role-based color coding (e.g., Red border for Bowlers, Blue for Batsmen).
- **Price Indicator:** A large, centered "CURRENT BID" amount in **Auction Gold** that updates in real-time.
- **Bid History:** A compact, bottom-aligned scrolling list showing the last 5 bids (Franchise Name + Amount).
- **Franchise Context:** A small "Your Team" widget showing remaining purse and slots filled.

### Screen B: Auctioneer Command Center (Organizer View - Web/Tablet)
- **Main Action Zone:** Central "Hammer" area with massive **SOLD**, **UNSOLD**, and **RECORD BID** buttons.
- **Player Queue:** A sidebar showing the current, previous, and next 5 players in the pool.
- **Purse Leaderboard:** A live-updating table of all franchises showing:
  - Remaining Purse (with a visual bar).
  - Slots filled (e.g., 5/11).
  - Current leading bid flag.

### Screen C: League Discovery Dashboard
- **League Cards:** Image-heavy cards showing league logo, format (T20), and status.
- **"Live Now" Section:** A dedicated carousel for leagues currently holding an auction, with a prominent "ENTER ROOM" button.

---

## 3. High-Impact Components

### The "Sold" Gavel Slam (Animation Concept)
- When a player is marked SOLD, the screen should momentarily blur.
- A golden gavel slams down in the center.
- The winning franchise logo explodes into view with "PURCHASED FOR [PRICE]" text.
- Confetti particles in the team's colors.

### The "Purse Meter"
- A horizontal progress bar that turns from Green to Yellow to Red as the franchise's purse depletes.
- Shows "Reserved" amount (for minimum base prices of remaining slots) in a hashed pattern.

---

## 4. Error & Connectivity States
- **Disconnected:** The UI desaturates (turns grayscale) with a "CONNECTION LOST" banner.
- **Insufficient Funds:** The bid button should physically "shake" (haptic-like) and turn gray if the franchise cannot afford the next bid increment.
