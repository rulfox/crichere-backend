# Research: Crichere Auction Platform

## Technical Decisions

### Backend: SSE Broadcaster with Redis Pub/Sub
- **Decision**: Use Spring `SseEmitter` managed by an `SseBroadcaster` service that subscribes to a Redis channel.
- **Rationale**: `SseEmitter` provides the standard SSE protocol. Redis pub/sub ensures that events published from one backend instance reach emitters connected to all other instances in the cluster, ensuring platform-wide synchronization.
- **Alternatives considered**: WebSockets (rejected per constitution VI), Polling (rejected due to latency requirements).

### Frontend: Riverpod AsyncNotifier & StreamProvider
- **Decision**: Use `AsyncNotifier` for standard CRUD operations and `StreamProvider` to wrap the `eventsource` SSE connection.
- **Rationale**: Riverpod handles dependency injection and reactive state naturally. `StreamProvider` is the idiomatic way to handle continuous event streams in Flutter.
- **Alternatives considered**: Bloc/Cubit (rejected for simplicity and better DI integration with Riverpod).

### Security: JJWT & Secure Storage
- **Decision**: Use JJWT for backend token handling and `flutter_secure_storage` for client-side persistence.
- **Rationale**: JJWT is the industry standard for Java/Kotlin. `flutter_secure_storage` ensures tokens are stored in the iOS Keychain and Android Keystore, fulfilling security best practices for mobile apps.
- **Alternatives considered**: SharedPreferences (rejected as it is not secure).

### Storage: PostgreSQL & Drift
- **Decision**: PostgreSQL for the single source of truth; Drift (SQLite) for mobile-side caching.
- **Rationale**: PostgreSQL 16 supports robust JSONB for audit log payloads. Drift provides a type-safe, code-generated API for local SQLite access in Flutter, enabling smooth offline caching.
- **Alternatives considered**: Hive (rejected for lack of relational query support).

## Best Practices

### SSE Integrity
- Every event MUST have a `sequenceNumber`.
- Clients MUST send `Last-Event-ID` on reconnect.
- Backend MUST replay `AuditLog` entries for missed sequence numbers.

### direct-to-S3 Flow
- Backend provides a short-lived presigned URL and the final access URL.
- Client uses `Dio` with `PUT` and correct `Content-Type`.
- Frontend NEVER touches S3 credentials directly.

### Indian Market Optimization
- MSG91 for high delivery rates.
- Localized error messages using `messageKey`.
- Lottie animations and Shimmer loaders for high-perceived performance on mid-range devices.
