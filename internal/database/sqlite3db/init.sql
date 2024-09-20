CREATE TABLE IF NOT EXISTS files(
    id     TEXT PRIMARY KEY,
    digest BLOB,
    path   TEXT
);

CREATE UNIQUE INDEX IF NOT EXISTS files_digest_unique ON files (digest);
