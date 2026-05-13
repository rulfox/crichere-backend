# Railway Deployment Guide: Crichere Backend

To deploy your backend to Railway, follow these steps to configure your environment variables.

## 1. Database & Redis Setup
In your Railway project:
1.  Click **+ New** -> **Database** -> **Add PostgreSQL**.
2.  Click **+ New** -> **Database** -> **Add Redis**.

Railway will automatically inject several variables. You just need to map them or add the ones missing.

## 2. Environment Variables Configuration
Go to your **Backend Service** -> **Variables** tab and add/update the following:

### Core Configuration
| Variable | Value | Description |
| :--- | :--- | :--- |
| `SPRING_PROFILES_ACTIVE` | `prod` | Switches to production settings. |
| `JWT_SECRET` | `(Generate a 64-character hex string)` | Used for signing tokens. |
| `CORS_ALLOWED_ORIGINS` | `*` or `(Your Railway Frontend URL)` | e.g., `https://crichere-web.up.railway.app` |

### Database & Redis (Automatic Mapping)
I have updated the code to automatically use Railway's default variable names. If you have added the Postgres and Redis plugins, ensure these variables exist in your backend service (Railway should link them automatically):

- `PGHOST` (from Postgres plugin)
- `PGPORT` (from Postgres plugin)
- `PGDATABASE` (from Postgres plugin)
- `PGUSER` (from Postgres plugin)
- `PGPASSWORD` (from Postgres plugin)
- `REDISHOST` (from Redis plugin)
- `REDISPORT` (from Redis plugin)

**Note:** You do NOT need to manually set `SPRING_DATASOURCE_URL` anymore unless you want to override the automatic mapping.

## 3. Troubleshooting the "JDBC URL invalid" error
If you still see `jdbc:postgresql://:/` in the logs, it means Railway has not yet linked the Postgres plugin to your Backend service. 
1. Go to the **Variables** tab of your Backend service.
2. Check if variables like `PGHOST` are present. 
3. If not, click **New Variable** -> **Reference Variable** and select the Postgres service variables.

## 4. Deployment Trigger
Once you connect your GitHub repo to Railway, every time you push to `main`, Railway will:
1.  See the `Dockerfile`.
2.  Run the multi-stage build.
3.  Expose the app on the dynamic `PORT`.
4.  Run Flyway migrations automatically on startup.
