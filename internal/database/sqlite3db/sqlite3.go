package sqlite3db

import (
	"context"
	"database/sql"
	"log"

	_ "embed"

	"github.com/flacster/flacster/internal/database"
	_ "github.com/ncruces/go-sqlite3/driver"
	_ "github.com/ncruces/go-sqlite3/embed"
)

type SQLite3DB struct {
	db *sql.DB
}

var _ database.Database = &SQLite3DB{}

func NewSQLite3DB() (*SQLite3DB, error) {
	db, err := sql.Open("sqlite3", "file:flacster.db")
	if err != nil {
		return nil, err
	}

	if err = db.Ping(); err != nil {
		log.Fatal(err)
	}

	sqlite3db := &SQLite3DB{
		db: db,
	}

	sqlite3db.cringeMigrate(context.Background())

	return sqlite3db, nil
}

func (db *SQLite3DB) QueryRow(ctx context.Context, sql string, args ...any) database.Row {
	return db.db.QueryRowContext(ctx, sql, args...)
}

func (db *SQLite3DB) Query(ctx context.Context, sql string, args ...any) (database.Rows, error) {
	return db.db.QueryContext(ctx, sql, args...)
}

func (db *SQLite3DB) Execute(ctx context.Context, sql string, args ...any) error {
	_, err := db.db.ExecContext(ctx, sql, args...)
	return err
}

func (db *SQLite3DB) Close() error {
	return db.db.Close()
}

//go:embed init.sql
var initSQL string

func (db *SQLite3DB) cringeMigrate(ctx context.Context) {
	_, err := db.db.ExecContext(ctx, initSQL)

	if err != nil {
		log.Fatal(err)
	}
}
