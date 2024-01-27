package tags

import (
	"errors"
	"io"
)

var (
	ErrTagsNotFound      = errors.New("tags not found")
	ErrInvalidMetadata   = errors.New("invalid metadata")
	ErrUnsupportedFormat = errors.New("unsupported format")
)

type Metadata struct {
	Tags map[string]string
}

func DecodeMetadata(r io.ReadSeeker) (Metadata, error) {
	switch {
	case isFLAC(r):
		r.Seek(0, io.SeekStart)
		return decodeFLACMetadata(r)
	}
	return Metadata{}, ErrUnsupportedFormat
}
