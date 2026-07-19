# Deploying FoodRush to Clever Cloud (free)

Everything (app + MySQL) lives on Clever Cloud so there's no cross-cloud
networking to fight with. GitHub just holds your source.

## 0. What changed in this zip vs. yours
- `src/main/java/com/tap/Utility/DBConnection.java` — no longer has your
  MySQL password hardcoded. It now reads `MYSQL_ADDON_HOST`,
  `MYSQL_ADDON_PORT`, `MYSQL_ADDON_DB`, `MYSQL_ADDON_USER`,
  `MYSQL_ADDON_PASSWORD` (Clever Cloud sets these automatically once you
  link a MySQL add-on — see step 3). Locally it falls back to
  `localhost:3306/food_delivery_app` with user `root` and a blank password,
  so **set those same 5 variables in your OS/IDE environment locally** if
  your local root password isn't blank.
- Added `pom.xml` — this project had no build tool before; Clever Cloud
  needs Maven to build a WAR.
- Added `clevercloud/war.json` — tells Clever Cloud to build with Maven and
  deploy the WAR to a Tomcat 10 container.
- Removed the jars you had manually placed in `WEB-INF/lib` — Maven now
  supplies the exact same versions via `pom.xml`.

## 1. Push this project to GitHub
```bash
cd FOOD_DELIVERY_APP
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/<you>/food-rush.git
git push -u origin main
```

## 2. Create the app on Clever Cloud
1. Sign up at console.clever-cloud.com (free, no card needed for the free tier).
2. **Create > An application > Java** (it auto-detects Maven from `pom.xml`).
3. Either connect your GitHub repo (auto-deploy on push) or use the git
   remote Clever Cloud gives you:
   ```bash
   git remote add clever git+ssh://git@push.clever-cloud.com/<app_id>.git
   git push clever main
   ```

## 3. Add the MySQL database
1. In your app's dashboard: **Service dependencies > Link add-ons > MySQL**.
2. Pick the **DEV** plan (free).
3. Link it to your app. Clever Cloud automatically injects
   `MYSQL_ADDON_HOST`, `MYSQL_ADDON_PORT`, `MYSQL_ADDON_DB`,
   `MYSQL_ADDON_USER`, `MYSQL_ADDON_PASSWORD` into your app — that's what
   the updated `DBConnection.java` reads. No code changes needed.

## 4. Move your local data over
Your schema + data currently only exist in your local MySQL. Dump them and
import into the new Clever Cloud database — don't recreate the schema by
hand, dump your real one so nothing is missed.

**On your computer**, dump your local DB (structure + data):
```bash
mysqldump -u root -p food_delivery_app > food_delivery_app.sql
```

**Get your Clever Cloud MySQL credentials**: open the MySQL add-on's
dashboard on Clever Cloud — it shows host, port, database name, user, and
password (these are the same `MYSQL_ADDON_*` values injected into your app).

**Import into Clever Cloud**, either:
- via the command line:
  ```bash
  mysql -h <MYSQL_ADDON_HOST> -P <MYSQL_ADDON_PORT> -u <MYSQL_ADDON_USER> -p <MYSQL_ADDON_DB> < food_delivery_app.sql
  ```
- or via the built-in phpMyAdmin link on the add-on's dashboard (drag and
  drop the `.sql` file) — easiest if you're more comfortable with MySQL
  Workbench-style GUIs.

Either way, when it's done your production database has the exact same
tables and rows as your local one.

## 5. Set the remaining environment variables
In your app's **Environment variables** panel on Clever Cloud, add:
| Variable | Value |
|---|---|
| `SMTP_USER` | your Gmail address used for password-reset emails |
| `SMTP_PASS` | a Gmail **App Password** (not your normal password) |
| `GEMINI_API_KEY` | your Gemini API key for the chatbot |

(`MYSQL_ADDON_*` are already set automatically by step 3 — don't add them
yourself.)

## 6. Redeploy and check
Redeploy (push again, or trigger from the console) and visit your app's
Clever Cloud domain. `LandingPage.html` should load, and login/register
should hit the migrated data.

## Notes
- Every time you push to `main` (if GitHub-linked) or `git push clever main`,
  Clever Cloud rebuilds and redeploys automatically.
- If you add real users after go-live, remember your *local* database will
  now be out of sync with production — treat Clever Cloud as the source of
  truth from here on.
