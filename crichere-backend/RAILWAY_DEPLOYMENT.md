# Railway Deployment Guide: Crichere Backend

To deploy your backend to Railway, follow these steps to configure your environment variables.

## 1. Database & Redis Setup
In your Railway project:
1.  Click **+ New** -> **Database** -> **Add PostgreSQL**.
2.  Click **+ New** -> **Database** -> **Add Redis**.

Railway will automatically inject several variables. You just need to map them or add the ones missing.

## 2. Environment Variables Configuration
Go to your **Backend Service** -> **Variables** tab and add/update the following:

| Variable | Value / Source | Description |
| :--- | :--- | :--- |
| `SPRING_PROFILES_ACTIVE` | `prod` | Switches to production settings. |
| `PORT` | `8080` | (Injected by Railway, but good to have as default). |
| `SPRING_DATASOURCE_URL` | `jdbc:postgresql://${{Postgres.PGHOST}}:${{Postgres.PGPORT}}/${{Postgres.PGDATABASE}}` | Railway Postgres connection string. |
| `SPRING_DATASOURCE_USERNAME` | `${{Postgres.PGUSER}}` | Database user. |
| `SPRING_DATASOURCE_PASSWORD` | `${{Postgres.PGPASSWORD}}` | Database password. |
| `SPRING_DATA_REDIS_HOST` | `${{Redis.REDISHOST}}` | Redis host. |
| `SPRING_DATA_REDIS_PORT` | `${{Redis.REDISPORT}}` | Redis port. |
| `JWT_SECRET` | `(Generate a 64-character hex string)` | Used for signing tokens. |
| `CORS_ALLOWED_ORIGINS` | `(Your Firebase Frontend URL)` | e.g., `https://crichere.web.app` |
| `MSG91_AUTH_KEY` | `(Your Key)` | SMS provider key. |
| `MSG91_TEMPLATE_ID` | `(Your ID)` | SMS template ID. |

## 3. Important Note
Railway's PostgreSQL uses a internal private network. If you use the `${{Postgres.DATABASE_URL}}` directly, ensure the driver is correct (it usually provides `postgres://` while Spring needs `jdbc:postgresql://`). The mapping above handles this correctly.

## 4. Deployment Trigger
Once you connect your GitHub repo to Railway, every time you push to `main`, Railway will:
1.  See the `Dockerfile`.
2.  Run the multi-stage build.
3.  Expose the app on the dynamic `PORT`.
4.  Run Flyway migrations automatically on startup.
