# ──────────────────────────────────────────────
# Stage 1: Build Flutter web app
# ──────────────────────────────────────────────
# 3.41.9: Dart 3.11.5, satisfies sdk >=3.8.0. --web-renderer removed in 3.29.0;
# running as non-root already avoids the WASM seccomp dry-run issue.
FROM ghcr.io/cirruslabs/flutter:3.41.9 AS builder

# Disable telemetry and pre-download web tooling as root.
# This warms the SDK cache so the non-root build step needs no SDK writes.
RUN flutter config --no-analytics && flutter precache --web

# Mark the SDK directory as safe for git and ensure permissions for the builder user
RUN git config --global --add safe.directory /sdks/flutter \
    && chown -R root:root /sdks/flutter \
    && chmod -R g+rwX /sdks/flutter

# Create a non-root user.
# Running Flutter as root in Docker causes an "Unexpected wasm dry run failure"
# due to seccomp restrictions on certain CPU instructions. Non-root avoids this.
RUN useradd --create-home --shell /bin/bash builder --groups root \
    && mkdir /app && chown builder:builder /app

WORKDIR /app
USER builder

# Mark the SDK directory as safe for git for the builder user as well
RUN git config --global --add safe.directory /sdks/flutter

# Copy dependency manifest (pubspec.lock may be gitignored, only copy pubspec.yaml)
COPY --chown=builder:builder pubspec.yaml ./
RUN flutter pub get

# Copy the rest of the source code
COPY --chown=builder:builder . .

# Build args for compile-time dart-defines (defaults = production values)
ARG API_BASE_URL=https://api.crichere.com/api/v1
ARG ENV=prod

# Build Flutter for web. --no-wasm-dry-run skips the dart2wasm feasibility check
# that fails under Docker's seccomp profile (exit 252), and builds with dart2js.
RUN flutter build web --release --no-wasm-dry-run \
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
