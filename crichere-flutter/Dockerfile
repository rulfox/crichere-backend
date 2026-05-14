# ──────────────────────────────────────────────
# Stage 1: Build Flutter web app
# ──────────────────────────────────────────────
FROM ghcr.io/cirruslabs/flutter:stable AS builder

WORKDIR /app

# Copy dependency manifest (pubspec.lock may be gitignored, so only copy pubspec.yaml)
COPY pubspec.yaml ./
RUN flutter pub get

# Copy the rest of the source code
COPY . .

# Build args for compile-time dart-defines (defaults = production values)
ARG API_BASE_URL=https://api.crichere.com/api/v1
ARG ENV=prod

# Build Flutter for web in release mode
RUN flutter build web --release \
    --dart-define=API_BASE_URL=${API_BASE_URL} \
    --dart-define=ENV=${ENV}

# ──────────────────────────────────────────────
# Stage 2: Serve with nginx
# ──────────────────────────────────────────────
FROM nginx:alpine

# Copy the compiled web assets from the builder stage
COPY --from=builder /app/build/web /usr/share/nginx/html

# Copy the nginx config template (Railway injects $PORT at runtime)
COPY nginx.conf /etc/nginx/templates/default.conf.template

EXPOSE 80
