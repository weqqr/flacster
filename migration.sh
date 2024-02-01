#!/bin/sh

echo "run database migration"
/app/migrate -path /app/internal/db/migration -database postgresql://admin:1234@database:5432/flacster?sslmode=disable -verbose up

echo "start the application"
exec /app/flacster
