package index

import (
	"bytes"
	"context"
	"crypto/sha256"
	"io/fs"
	"log"
	"os"
	"path/filepath"
	"slices"
	"strings"

	"github.com/edsrzf/mmap-go"
	"github.com/flacster/flacster/internal/domain"
	"github.com/flacster/flacster/pkg/tags"
	"github.com/google/uuid"
)

type IndexRepo interface {
	AddFile(context.Context, domain.File) (uuid.UUID, error)
}

type Indexer struct {
	AllowedExtensions []string

	Repo IndexRepo
}

func NewIndexer(repo IndexRepo) *Indexer {
	return &Indexer{
		AllowedExtensions: []string{"flac"},

		Repo: repo,
	}
}

func (i *Indexer) Index(ctx context.Context, libraryPath string) error {
	var files []string

	err := filepath.WalkDir(libraryPath, func(path string, d fs.DirEntry, err error) error {
		if err != nil {
			return err
		}

		if !d.Type().IsRegular() {
			return nil
		}

		extension := strings.TrimLeft(filepath.Ext(path), ".")
		if !slices.Contains(i.AllowedExtensions, extension) {
			return nil
		}

		relativePath, err := filepath.Rel(libraryPath, path)
		if err != nil {
			return err
		}

		files = append(files, relativePath)

		file, err := os.OpenFile(path, os.O_RDONLY, 0755)
		mmappedData, err := mmap.Map(file, mmap.RDONLY, 0)
		if err != nil {
			log.Fatal(err)
		}

		defer mmappedData.Unmap()

		meta, err := tags.DecodeMetadata(bytes.NewReader(mmappedData))
		if err != nil {
			return err
		}

		digest := sha256.Sum256(mmappedData)

		indexedFile := domain.File{
			Digest: digest[:],
			Path:   path,
			Tags:   meta.Tags,
		}

		id, err := i.Repo.AddFile(ctx, indexedFile)
		if err != nil {
			return err
		}

		log.Println(id, path)

		return nil
	})

	return err
}
