package file

import (
	"context"

	"github.com/flacster/flacster/internal/database"
	"github.com/flacster/flacster/internal/domain"
	"github.com/google/uuid"
)

type FileRepo struct {
	db database.Database
}

func NewFileRepo(db database.Database) *FileRepo {
	return &FileRepo{
		db: db,
	}
}

func (r *FileRepo) AddFile(ctx context.Context, file domain.File) (uuid.UUID, error) {
	id := uuid.New()

	const sql = `
		INSERT INTO files (id, digest, path)
		VALUES ($1, $2, $3)
		ON CONFLICT (digest)
			DO NOTHING
	`

	err := r.db.Execute(ctx, sql,
		id.String(),
		file.Digest,
		file.Path,
	)

	return id, err
}
