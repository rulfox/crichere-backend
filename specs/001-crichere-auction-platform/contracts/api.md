# API Contract: Crichere Auction Platform

## Standard Response Envelope
```json
{
  "success": true,
  "message": "User registered successfully",
  "messageKey": "success.user_registered",
  "data": { ... },
  "error": null,
  "timestamp": "2026-04-24T10:00:00Z"
}
```

## Critical Endpoints

### Authentication
- `POST /api/v1/auth/otp/send`: Request a 6-digit OTP.
- `POST /api/v1/auth/otp/verify`: Verify OTP and return JWT + Refresh Token.
- `POST /api/v1/auth/profile/claim`: Claim a ghost profile using OTP.

### Auction Control (Auctioneer Only)
- `PATCH /api/v1/auctions/{id}/start`: Begin the auction.
- `POST /api/v1/auctions/{id}/player/put`: Put a player up for bid (Random or Manual).
- `POST /api/v1/auctions/{id}/bid`: Record a verbal bid from a franchise.
- `POST /api/v1/auctions/{id}/player/sold`: Finalize a player sale.
- `PATCH /api/v1/auctions/{id}/bid/undo`: Undo the last recorded bid.

### Real-Time Updates
- `GET /api/v1/auctions/{id}/events`: SSE stream endpoint (Content-Type: `text/event-stream`).
- `GET /api/v1/auctions/{id}/state`: Get complete current state snapshot.

### League Management
- `POST /api/v1/leagues`: Create a new league with full config.
- `POST /api/v1/leagues/{id}/players/import`: Bulk CSV import of player profiles.
- `POST /api/v1/leagues/{id}/franchises/invite`: Generate SMS invite deep link.

### Fees & Forfeits
- `POST /api/v1/leagues/{id}/fees/record`: Record a cash payment.
- `POST /api/v1/leagues/{id}/forfeit`: Submit an exit request.
