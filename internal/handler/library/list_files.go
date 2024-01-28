package library

import (
	"io/fs"
	"path/filepath"

	"github.com/flacster/flacster/internal/domain"
)

func (c *Handler) ListFiles(request domain.ListFilesRequest) (domain.ListFilesResponse, error) {
	var files []string

	err := filepath.WalkDir(c.Config.LibraryPath, func(path string, d fs.DirEntry, err error) error {
		if err != nil {
			return err
		}

		if !d.Type().IsRegular() {
			return nil
		}

		relativePath, err := filepath.Rel(c.Config.LibraryPath, path)
		if err != nil {
			return err
		}

		files = append(files, relativePath)

		return nil
	})

	if err != nil {
		return domain.ListFilesResponse{}, err
	}

	return domain.ListFilesResponse{
		Files: files,
	}, nil
}
