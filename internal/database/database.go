package database

import "context"

type Row interface {
	Scan(args ...any) error
}

type Rows interface {
	Close() error
}

type Database interface {
	QueryRow(ctx context.Context, sql string, args ...any) Row
	Query(ctx context.Context, sql string, args ...any) (Rows, error)
	Execute(ctx context.Context, sql string, args ...any) error
	Close() error
}
