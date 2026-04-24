# Quickstart: Crichere Auction Platform

## Backend Setup (crichere-backend)
1. **Prerequisites**: Java 21, PostgreSQL 16, Redis.
2. **Configure Environment**: Set `SPRING_DATASOURCE_URL`, `SPRING_DATA_REDIS_HOST`, and `AWS_ACCESS_KEY_ID` / `AWS_SECRET_ACCESS_KEY`.
3. **Run Database Migrations**: `gradle flywayMigrate`.
4. **Start Application**: `gradle bootRun`.
5. **Access Swagger**: `http://localhost:8080/api/v1/swagger-ui.html`.

## Frontend Setup (crichere-flutter)
1. **Prerequisites**: Flutter Stable, Android/iOS SDKs.
2. **Generate Code**: `flutter pub run build_runner build --delete-conflicting-outputs`.
3. **Run Application**: `flutter run`.

## Core Workflows
### Real-Time Auction
1. Ensure Redis is running for pub/sub.
2. Auctioneer starts auction via `PATCH /auctions/{id}/start`.
3. Clients connect to `GET /auctions/{id}/events`.
4. Every bid recorded by the auctioneer publishes to Redis and is pushed via `SseEmitter`.

### File Upload
1. Frontend requests URL: `GET /api/v1/assets/presigned-url`.
2. Frontend PUTs to S3: `dio.put(presignedUrl, data: bytes)`.
3. Frontend sends key to Backend: `POST /api/v1/profile/photo { "s3Key": "..." }`.
