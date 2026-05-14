# Deploying crichere-flutter to Railway (crichere.com)

## Overview

The Flutter web app is served via a multi-stage Docker build:
- **Stage 1** – `ghcr.io/cirruslabs/flutter:stable` compiles `flutter build web --release`
- **Stage 2** – `nginx:alpine` serves the compiled assets; Railway injects `$PORT` at runtime via the nginx template

---

## Step 1 – Push the changes to GitHub

```bash
cd crichere          # repo root
git add crichere-flutter/Dockerfile crichere-flutter/railway.json
git commit -m "chore: add multi-stage Railway Dockerfile for Flutter web"
git push origin main
```

---

## Step 2 – Create a new Railway service for the Flutter app

1. Go to [railway.app](https://railway.app) and open your **crichere** project (or create one if it doesn't exist yet).
2. Click **+ New Service → GitHub Repo**.
3. Select `rulfox/crichere-live`.
4. In the service settings, set **Root Directory** to:
   ```
   crichere/crichere-flutter
   ```
   Railway will find the `Dockerfile` and `railway.json` inside that folder.
5. Click **Deploy**. The first build will take ~5–10 minutes (Flutter SDK download + compile).

---

## Step 3 – Add environment variables (optional)

The production API URL is baked in at build time via Docker ARGs and defaults to `https://api.crichere.com/api/v1`.

If you ever need to override them without changing code, add these as **Build Variables** in Railway (not runtime env vars):

| Variable | Value |
|---|---|
| `API_BASE_URL` | `https://api.crichere.com/api/v1` |
| `ENV` | `prod` |

---

## Step 4 – Add the custom domain in Railway

1. In your Flutter service on Railway, go to **Settings → Networking → Custom Domain**.
2. Add `crichere.com` and `www.crichere.com`.
3. Railway will show you a **CNAME target** that looks like:
   ```
   <something>.up.railway.app
   ```
   Copy this value — you'll need it in Hostinger.

---

## Step 5 – Configure DNS in Hostinger

Log in to [hpanel.hostinger.com](https://hpanel.hostinger.com), go to **Domains → crichere.com → DNS / Nameservers → Manage DNS Records**, then add:

| Type | Name | Points to | TTL |
|---|---|---|---|
| CNAME | `www` | `<your-service>.up.railway.app` | 3600 |
| CNAME | `@` | `<your-service>.up.railway.app` | 3600 |

> **Note:** Some DNS providers don't allow a CNAME on the root (`@`). If Hostinger blocks it, use their **"Redirect"** feature to forward `crichere.com` → `www.crichere.com`, and only add the `www` CNAME pointing to Railway.

DNS propagation typically takes 5–30 minutes but can take up to 48 hours.

---

## Step 6 – Verify SSL

Railway auto-provisions a Let's Encrypt SSL certificate once DNS resolves. Visit `https://crichere.com` — you should see the Flutter web app with a valid HTTPS padlock.

---

## Architecture Summary

```
User Browser
    │
    ▼
crichere.com  ──CNAME──►  <service>.up.railway.app
                               │
                    Railway Flutter Service
                    (nginx serving build/web)
                               │
                    Calls API at api.crichere.com
                               │
                    Railway Backend Service
                    (Spring Boot on api.crichere.com)
```
