# ──────────────────────────────────────────────
# Stage 1: Build Flutter web app
# ──────────────────────────────────────────────
FROM ghcr.io/cirruslabs/flutter:stable AS builder

# Disable telemetry and pre-download web tooling as root.
# This warms the SDK cache so the non-root build step needs no SDK writes.
RUN flutter config --no-analytics && flutter precache --web

# Create a non-root user.
# Running Flutter as root in Docker causes an "Unexpected wasm dry run failure"
# due to seccomp restrictions on certain CPU instructions. Non-root avoids this.
RUN useradd --uid 1000 --create-home --shell /bin/bash builder \
    && mkdir /app && chown builder:builder /app

WORKDIR /app
USER builder

COPY --chown=builder:builder pubspec.yaml ./
RUN flutter pub get

COPY --chown=builder:builder . .

# Build args for compile-time dart-defines (defaults = production values)
ARG API_BASE_URL=https://api.crichere.com/api/v1
ARG ENV=prod

RUN flutter build web --release \
    --dart-define=API_BASE_URL=${API_BASE_URL} \
    --dart-define=ENV=${ENV}

# ──────────────────────────────────────────────
# Stage 2: Serve with nginx
# ──────────────────────────────────────────────
FROM nginx:alpine

COPY --from=builder /app/build/web /usr/share/nginx/html

# Copy the nginx config template (Railway injects $PORT at runtime)
COPY nginx.conf /etc/nginx/templates/default.conf.template

EXPOSE 80
