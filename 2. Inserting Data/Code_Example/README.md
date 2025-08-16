# Code_Example

This folder contains runnable SQL examples used by the "2. Inserting Data" lesson.

Files:
- `00_run_all.sql` - helper wrapper that runs examples in an intended order (read before running).
- `1_create_and_insert_cats.sql` - basic CREATE/INSERT examples.
- `2_people_exercise.sql` - `people` table exercise from the README.
- `3_not_null_and_defaults.sql` - NOT NULL and DEFAULT examples.
- `4_primary_key_and_autoinc.sql` - PRIMARY KEY and AUTO_INCREMENT examples.
- `5_employees_exercise.sql` - comprehensive employees table exercise.

Notes:
- These scripts use `CREATE TABLE IF NOT EXISTS` to avoid errors on re-run, but they do not
  select a database. Add `USE your_database;` at the top of a file or run them after selecting
  the desired database.
- Some lines that intentionally demonstrate failing behavior are commented out. Uncomment to test.

How to run one file (PowerShell):

```powershell
mysql -u root -p < "e:\Git Clone\MySQL-Bootcamp\2. Inserting Data\Code_Example\1_create_and_insert_cats.sql"
```

How to run all (in order):

```powershell
mysql -u root -p < "e:\Git Clone\MySQL-Bootcamp\2. Inserting Data\Code_Example\00_run_all.sql"
```

VS Code / SQLTools workspace connection
-------------------------------------
This repo includes a workspace SQLTools connection at `.vscode/settings.json` named
`MySQL - local` (host: localhost, port: 3306, user: root). If you installed SQLTools,
you should see this connection in the SQLTools connections list. The password is not
saved; you'll be prompted when connecting.
