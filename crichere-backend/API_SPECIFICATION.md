# Crichere API Specification

This document provides a comprehensive list of all API endpoints available in the Crichere backend, categorized by Feature and Screen Workflow.

## Base URL
`https://api.crichere.com/api/v1` (Production)
`http://localhost:8080/api/v1` (Development)

## Standard Response Wrapper
All responses (except for binary exports and SSE) follow this standard structure:

```json
{
  "success": true,
  "message": "Operation successful",
  "messageKey": "success.operation",
  "data": { ... },
  "errors": null
}
```

---

## 1. Authentication & Onboarding (Auth Feature)

### S1: Login/Signup Screen
*   **Send OTP**
    *   `POST /auth/otp/send`
    *   **Request:** `{"phone": "9876543210"}`
    *   **Response:** `{"success": true, "message": "OTP sent successfully"}`

*   **Verify OTP**
    *   `POST /auth/otp/verify`
    *   **Request:** `{"phone": "9876543210", "code": "1234"}`
    *   **Response:** `{"success": true, "data": {"accessToken": "...", "refreshToken": "...", "userId": "..."}}`

*   **Refresh Token**
    *   `POST /auth/token/refresh`
    *   **Request:** `{"refreshToken": "..."}`
    *   **Response:** `{"success": true, "data": {"accessToken": "...", "refreshToken": "..."}}`

### S2: Profile Setup Screen
*   **Update Basic Info**
    *   `PUT /users/{id}/basic`
    *   **Request:** `{"name": "John Doe", "email": "john@example.com"}`

*   **Update Cricket Profile**
    *   `PUT /users/{id}/cricket-profile`
    *   **Request:** `{"playingRole": "BATSMAN", "battingStyle": "RIGHT_HAND", ...}`

*   **Upload Profile Photo** (Get Presigned URL)
    *   `POST /storage/presigned-url`
    *   **Request:** `{"fileName": "profile.jpg", "contentType": "image/jpeg"}`
    *   **Response:** `{"url": "https://s3...", "key": "users/..."}`

*   **Confirm Photo Upload**
    *   `PUT /users/{id}/photo`
    *   **Request:** `{"s3Key": "users/..."}`

---

## 2. League & Player Management

### S3: Home Screen (User's Leagues)
*   **Get My Leagues**
    *   `GET /users/{id}/leagues`
    *   **Response:** `{"data": [{"id": "...", "name": "IPL 2024", "status": "LIVE", ...}]}`

*   **Search Leagues**
    *   `GET /leagues?page=0&size=20`

### S4: League Detail Screen
*   **Get League Info**
    *   `GET /leagues/{id}`

*   **Register for League**
    *   `POST /players/register`
    *   **Request:** `{"leagueId": "...", "userId": "..."}`

*   **Get League Players**
    *   `GET /leagues/{id}/players?page=0&size=20`

*   **Get League Franchises**
    *   `GET /leagues/{id}/franchises`

---

## 3. Franchise & Team Management

### S5: Franchise Dashboard
*   **Get Franchise Details**
    *   `GET /franchises/{id}`

*   **Get Franchise Squad**
    *   `GET /franchises/{id}/squad`
    *   **Response:** `{"data": {"franchiseName": "...", "players": [...]}}`

*   **Invite Member** (Owner only)
    *   `POST /franchises/{id}/invites`
    *   **Request:** `{"email": "owner2@example.com"}`

*   **Accept Invite**
    *   `POST /franchises/accept`
    *   **Request:** `{"token": "..."}`

---

## 4. Live Auction (The Core Experience)

### S6: Live Auction Screen (Common View)
*   **Get Auction State (Full Snapshot)**
    *   `GET /auctions/{id}/state`
    *   **Response:** `AuctionStateSnapshot` (Includes current player, timer, purse states, and franchiseMap).

*   **Real-time Event Stream (SSE)**
    *   `GET /auctions/{id}/events`
    *   **Headers:** `Last-Event-ID` (optional, for replay)
    *   **Stream Events:** `BID_PLACED`, `PLAYER_UP`, `PLAYER_SOLD`, `TIMER_STARTED`, `AUCTION_PAUSED`, etc.

*   **Place Bid**
    *   `POST /auctions/{id}/bid`
    *   **Request:** `{"franchiseId": "...", "bidAmount": 150000}`

### S7: Auctioneer Console (Admin only)
*   **Start Auction**
    *   `PATCH /auctions/{id}/start`

*   **Put Player Up for Bidding**
    *   `POST /auctions/{id}/player/put`
    *   **Request:** `{"leaguePlayerId": "..."}` (Optional if league is in RANDOM mode)

*   **Start/Stop Timer**
    *   `POST /auctions/{id}/timer/start` | `POST /auctions/{id}/timer/stop`

*   **Record Sale**
    *   `POST /auctions/{id}/player/sold`
    *   **Request:** `{"leaguePlayerId": "...", "franchiseId": "...", "finalPrice": 500000}`

*   **Mark as Unsold**
    *   `POST /auctions/{id}/player/unsold`
    *   **Request:** `{"leaguePlayerId": "..."}`

*   **Undo Actions**
    *   `PATCH /auctions/{id}/bid/undo` | `PATCH /auctions/{id}/player/undo-sold`
    *   **Request:** `{"reason": "Wrong entry"}`

---

## 5. Post-Auction & Reports

### S8: Auction Summary Screen
*   **Get Overall Summary**
    *   `GET /auctions/{id}/summary`

*   **Export PDF Report**
    *   `GET /auctions/{id}/summary/export/pdf` (Returns `application/pdf`)

*   **Export Franchise Squad Image**
    *   `GET /auctions/{id}/summary/franchises/{fId}/export/image` (Returns `image/png`)

---

## 6. Utilities & Notifications

### S9: Notifications & Settings
*   **Register Device Token** (FCM/APNS)
    *   `POST /notifications/tokens`
    *   **Request:** `{"token": "...", "platform": "ANDROID"}`

*   **List My Notifications**
    *   `GET /notifications?page=0`

*   **Mark Read**
    *   `PATCH /notifications/{id}/read`

---

## API Categorization by Screen

| Screen ID | Screen Name | Required APIs |
| :--- | :--- | :--- |
| **S1** | **Auth / Login** | `POST /auth/otp/send`, `POST /auth/otp/verify` |
| **S2** | **Onboarding / Profile** | `PUT /users/{id}/basic`, `PUT /users/{id}/cricket-profile`, `POST /storage/presigned-url` |
| **S3** | **Player Home** | `GET /users/{id}/leagues`, `GET /notifications/unread-count` |
| **S4** | **League Detail** | `GET /leagues/{id}`, `GET /leagues/{id}/players`, `POST /players/register` |
| **S5** | **Franchise Detail** | `GET /franchises/{id}/squad`, `GET /franchises/{id}/invites` |
| **S6** | **Live Auction** | `GET /auctions/{id}/state`, `GET /auctions/{id}/events`, `POST /auctions/{id}/bid` |
| **S7** | **Auctioneer Console** | `POST /auctions/{id}/player/put`, `POST /auctions/{id}/player/sold`, `POST /auctions/{id}/timer/start` |
| **S8** | **Admin / Management** | `POST /leagues/{id}/players/bulk-import`, `POST /leagues/{id}/category-prices` |
| **S9** | **Public Display** | `GET /public/auctions/{id}/display` (HTML), `GET /public/auctions/{id}/state` |

---
*Note: All POST/PUT/PATCH/DELETE requests (except public endpoints) require a `Authorization: Bearer <token>` header.*
