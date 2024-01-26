package handler

import (
	"io/fs"
	"path/filepath"

	"github.com/flacster/flacster/internal/domain"
)

func ListFiles(request domain.ListFilesRequest) (domain.ListFilesResponse, error) {
	var files []string

	filepath.WalkDir("internal", func(path string, d fs.DirEntry, err error) error {
		if !d.Type().IsRegular() {
			return nil
		}

		files = append(files, path)

		return nil
	})

	return domain.ListFilesResponse{
		Files: files,
	}, nil
}
