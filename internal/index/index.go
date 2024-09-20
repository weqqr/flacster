package index

import (
	"io/fs"
	"log"
	"os"
	"path/filepath"
	"slices"
	"strings"

	"github.com/flacster/flacster/pkg/tags"
)

type Indexer struct {
	AllowedExtensions []string
}

func NewIndexer() *Indexer {
	return &Indexer{
		AllowedExtensions: []string{"flac"},
	}
}

func (i *Indexer) Index(libraryPath string) error {
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

		file, err := os.Open(path)
		if err != nil {
			return err
		}

		meta, err := tags.DecodeMetadata(file)
		if err != nil {
			return err
		}

		log.Println(relativePath)
		for key, value := range meta.Tags {
			log.Printf("  %v: %v", key, value)
		}

		return nil
	})

	return err
}
