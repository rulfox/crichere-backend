# Quickstart: Crichere Auction Platform

## Backend Setup (crichere-backend)

### Prerequisites
- Java 21
- Docker & Docker Compose (for local PostgreSQL + Redis)

### Local Development

1. **Start infrastructure**
   ```bash
   docker compose up -d
   ```
   This starts PostgreSQL 16 on `:5432` and Redis 7 on `:6379`.

2. **Configure environment** (optional for local — defaults are pre-set)
   ```bash
   cp .env.example .env
   # Edit .env only if overriding defaults
   ```
   Required variables for production: see `.env.example` — variables marked `REQUIRED in prod` have no defaults and will fail startup if unset.

3. **Run the application**
   ```bash
   ./gradlew :crichere-backend:bootRun
   ```

4. **Access Swagger UI** (dev only — disabled in prod)
   ```
   http://localhost:8080/api/v1/swagger-ui.html
   ```

5. **Health check**
   ```
   http://localhost:8080/api/v1/actuator/health
   ```

### Running with Docker

Build and run the full backend image:
```bash
docker build -t crichere-backend .
docker run -p 8080:8080 \
  -e SPRING_DATASOURCE_URL=jdbc:postgresql://host.docker.internal:5432/crichere \
  -e SPRING_DATA_REDIS_HOST=host.docker.internal \
  -e JWT_SECRET=<your-secret> \
  -e CORS_ALLOWED_ORIGINS=http://localhost:3000 \
  crichere-backend
```

### Production Deployment

Set all variables from `.env.example` as environment variables in your deployment platform (Railway, Render, Fly.io, AWS ECS, etc.). The application refuses to start if required secrets are missing.

Spring profile must be set to `prod`:
```
SPRING_PROFILES_ACTIVE=prod
```

In prod: Swagger UI is disabled, Actuator health is public, all other actuator endpoints require `PLATFORM_ADMIN` role.

---

## Frontend Setup (crichere-flutter)

1. **Prerequisites**: Flutter Stable, Android/iOS SDKs.
2. **Generate Code**: `flutter pub run build_runner build --delete-conflicting-outputs`.
3. **Run Application**: `flutter run`.

---

## CI/CD

Every push to `main` that touches `crichere-backend/` automatically:
1. Runs the full test suite (TestContainers spins up its own DB)
2. Builds a Docker image tagged with the commit SHA

Pipeline defined in `.github/workflows/ci.yml`.

---

## Core Workflows

### Real-Time Auction
1. Ensure Redis is running for pub/sub.
2. Auctioneer starts auction via `PATCH /auctions/{id}/start`.
3. Clients connect to `GET /auctions/{id}/events`.
4. Every bid recorded by the auctioneer publishes to Redis and is pushed via `SseEmitter`.

### File Upload
1. Frontend requests presigned URL: `POST /api/v1/assets/presigned-url`.
2. Frontend PUTs directly to S3: `dio.put(presignedUrl, data: bytes)`.
3. Frontend sends key to backend: `PUT /api/v1/users/{id}/photo { "s3Key": "..." }`.

### Authentication
1. Send OTP: `POST /auth/otp/send { "phone": "9XXXXXXXXX" }`.
2. Verify OTP and receive tokens: `POST /auth/otp/verify`.
3. Use `Authorization: Bearer <accessToken>` on all protected endpoints.
4. Refresh: `POST /auth/token/refresh { "refreshToken": "..." }`.
5. Logout: `POST /auth/logout` — invalidates both the access token (Redis blacklist) and all refresh tokens.

### Metrics & Observability
- Prometheus metrics: `GET /api/v1/actuator/prometheus` (requires PLATFORM_ADMIN role in prod)
- Key custom metrics: `crichere.otp.sent`, `crichere.otp.verified`, `crichere.auction.bids.placed`, `crichere.auction.started`, `crichere.auction.players.sold`
- Every request receives and returns an `X-Request-ID` header for tracing across logs
