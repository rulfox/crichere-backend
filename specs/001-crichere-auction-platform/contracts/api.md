# API Contract: Crichere Auction Platform

## Standard Response Envelope
```json
{
  "success": true,
  "message": "Operation successful",
  "messageKey": "success.operation_name",
  "data": { ... },
  "error": null,
  "timestamp": "2026-04-26T10:00:00Z"
}
```

## Endpoints

### Authentication (`/auth`)
- `POST /api/v1/auth/otp/send`: Request a 6-digit OTP.
- `POST /api/v1/auth/otp/verify`: Verify OTP and return JWT + Refresh Token.
- `POST /api/v1/auth/claim-profile`: Claim a ghost profile using OTP.
- `POST /api/v1/auth/token/refresh`: Refresh access token using refresh token.
- `POST /api/v1/auth/logout`: Blacklist tokens and logout.
- `GET /api/v1/auth/me`: Get current authenticated user details.

### Users (`/users`)
- `GET /api/v1/users/{id}`: Get user profile.
- `PUT /api/v1/users/{id}/basic`: Update basic profile info.
- `PUT /api/v1/users/{id}/cricket-profile`: Update cricket performance details.
- `PUT /api/v1/users/{id}/photo`: Update profile photo.
- `GET /api/v1/users/search`: Search users by phone or name.
- `POST /api/v1/users/ghost`: Create a ghost user (Admin only).

### Players (`/players`)
- `POST /api/v1/players/register`: Self-register as a player.
- `GET /api/v1/players/{id}`: Get player details.
- `GET /api/v1/players/league/{leagueId}`: Get players in a specific league.

### Leagues (`/leagues`)
- `POST /api/v1/leagues`: Create a new league.
- `GET /api/v1/leagues/{id}`: Get league details.
- `PATCH /api/v1/leagues/{id}/status`: Update league status (DRAFT, LIVE, etc.).
- `POST /api/v1/leagues/{id}/players/bulk-import`: Bulk import players via JSON list.

### Franchises (`/franchises`)
- `POST /api/v1/franchises`: Create a new franchise.
- `GET /api/v1/franchises/{id}`: Get franchise details.
- `POST /api/v1/franchises/{id}/invites`: Generate franchise invite link.

### Auction Control (`/auctions`)
- `POST /api/v1/auctions/leagues/{leagueId}`: Initialize auction for a league.
- `GET /api/v1/auctions/{id}`: Get auction details.
- `GET /api/v1/auctions/{id}/state`: Get complete real-time state snapshot.
- `PATCH /api/v1/auctions/{id}/start`: Begin the auction.
- `PATCH /api/v1/auctions/{id}/pause`: Pause the auction.
- `PATCH /api/v1/auctions/{id}/resume`: Resume the auction.
- `PATCH /api/v1/auctions/{id}/complete`: Mark auction as finished.
- `POST /api/v1/auctions/{id}/player/put`: Put a player up for bidding.
- `POST /api/v1/auctions/{id}/bid`: Record a verbal bid.
- `PATCH /api/v1/auctions/{id}/bid/undo`: Undo the last recorded bid.
- `POST /api/v1/auctions/{id}/player/sold`: Finalize player sale.
- `PATCH /api/v1/auctions/{id}/player/undo-sold`: Undo the last player sale.
- `POST /api/v1/auctions/{id}/player/unsold`: Mark player as unsold.
- `POST /api/v1/auctions/{id}/player/withdraw`: Withdraw player from auction.
- `POST /api/v1/auctions/{id}/player/pre-assign`: Pre-assign Captain/Icon.
- `POST /api/v1/auctions/{id}/player/force-assign`: Admin force-assign player to franchise.
- `GET /api/v1/auctions/{id}/audit-log`: Get append-only action log.
- `POST /api/v1/auctions/{id}/rounds`: Add a new round to the auction.
- `PUT /api/v1/auctions/{id}/rounds/{roundId}`: Update round configuration.
- `PATCH /api/v1/auctions/{id}/rounds/{roundId}/start`: Start a specific round.
- `PATCH /api/v1/auctions/{id}/rounds/{roundId}/complete`: Complete a specific round.
- `GET /api/v1/auctions/{id}/rounds/{roundId}/player-pool`: Get players eligible for this round.
- `GET /api/v1/auctions/{id}/bids/{leaguePlayerId}`: Get bid history for a player.
- `GET /api/v1/auctions/{id}/events`: SSE stream endpoint (text/event-stream).
- `DELETE /api/v1/auctions/{id}`: Delete an auction.

### Auction Summary & Export
- `GET /api/v1/auctions/{id}/summary`: Get overall auction summary.
- `GET /api/v1/auctions/{id}/summary/franchises/{franchiseId}`: Get summary for a franchise.
- `GET /api/v1/auctions/{id}/summary/unsold`: Get list of unsold players.
- `GET /api/v1/auctions/{id}/summary/export/pdf`: Export full summary as PDF.
- `GET /api/v1/auctions/{id}/summary/franchises/{franchiseId}/export/pdf`: Export franchise squad as PDF.
- `GET /api/v1/auctions/{id}/summary/franchises/{franchiseId}/export/image`: Export franchise squad as PNG image.

### Fees Management (`/leagues/{leagueId}/fee-obligations`)
- `POST /api/v1/leagues/{leagueId}/fee-obligations`: Create fee obligations.
- `GET /api/v1/leagues/{leagueId}/fee-obligations`: List all fee obligations.
- `GET /api/v1/leagues/{leagueId}/fee-obligations/{userId}`: Get fees for a user.
- `POST /api/v1/leagues/{leagueId}/fee-obligations/{obligationId}/payments`: Record a payment.
- `PATCH /api/v1/leagues/{leagueId}/fee-obligations/{obligationId}/waive`: Waive a fee obligation.
- `GET /api/v1/leagues/{leagueId}/fees/summary`: Get fee collection summary.

### Forfeit Management (`/leagues/{leagueId}/forfeit`)
- `POST /api/v1/leagues/{leagueId}/forfeit`: Submit a forfeit request.
- `GET /api/v1/leagues/{leagueId}/forfeit-requests`: List all forfeit requests.
- `PATCH /api/v1/leagues/{leagueId}/forfeit-requests/{requestId}/approve`: Approve forfeit.
- `PATCH /api/v1/leagues/{leagueId}/forfeit-requests/{requestId}/reject`: Reject forfeit.
- `PATCH /api/v1/leagues/{leagueId}/forfeit-requests/{requestId}/cancel`: Cancel forfeit.

### Waiting List (`/leagues/{leagueId}/waiting-list`)
- `POST /api/v1/leagues/{leagueId}/waiting-list`: Join waiting list.
- `GET /api/v1/leagues/{leagueId}/waiting-list`: Get waiting list.
- `GET /api/v1/leagues/{leagueId}/waiting-list/my-position`: Get current user's position.
- `DELETE /api/v1/leagues/{leagueId}/waiting-list/{entryId}`: Remove from waiting list.
- `PATCH /api/v1/leagues/{leagueId}/waiting-list/{entryId}/promote`: Manually promote an entry.

### Notifications (`/notifications`)
- `POST /api/v1/notifications/device-token`: Register FCM/APNs token.
- `DELETE /api/v1/notifications/device-token`: Unregister token.
- `GET /api/v1/notifications`: Get in-app notifications.
- `PATCH /api/v1/notifications/{id}/read`: Mark notification as read.

### Platform Administration (`/admin`)
- `GET /api/v1/admin/users`: List all platform users.
- `PATCH /api/v1/admin/users/{id}/roles`: Update user roles.
- `PATCH /api/v1/admin/users/{id}/suspend`: Suspend/Unsuspend user.
- `GET /api/v1/admin/leagues`: List all leagues.
- `PATCH /api/v1/admin/leagues/{id}/suspend`: Suspend/Unsuspend league.
- `GET /api/v1/admin/subscriptions`: List all platform subscriptions.

### Payments & Subscriptions (`/subscriptions`)
- `GET /api/v1/subscriptions/leagues/{leagueId}`: Get subscription status for a league.
- `POST /api/v1/subscriptions/leagues/{leagueId}/initiate`: Start subscription payment.
- `GET /api/v1/subscriptions/leagues/{leagueId}/invoices`: Get league invoices.
- `POST /api/v1/subscriptions/webhook`: External payment provider webhook.

### Storage (`/storage`)
- `POST /api/v1/storage/presigned-url`: Get AWS S3 presigned URL for upload.
