package tags

import (
	"io"
	"slices"
	"strings"
)

// see https://xiph.org/flac/format.html for more information

var flacMarker = []byte{0x66, 0x4C, 0x61, 0x43}

const (
	typeVorbisComment = 4
)

type flacMetadataBlockHeader struct {
	IsLast bool
	Type   uint8
	Length uint32
}

func isFLAC(r io.ReadSeeker) bool {
	data := make([]byte, 4)

	_, err := io.ReadFull(r, data)
	if err != nil {
		return false
	}

	return slices.Equal(data[:4], flacMarker)
}

func decodeHeader(r io.Reader) (flacMetadataBlockHeader, error) {
	value, err := readUint32BE(r)
	if err != nil {
		return flacMetadataBlockHeader{}, err
	}

	isLast := (value >> 31) == 1
	ty := (value >> 24) & 0x7F
	length := value & 0x00FFFFFF

	return flacMetadataBlockHeader{
		IsLast: isLast,
		Type:   uint8(ty),
		Length: length,
	}, nil
}

func readCommentString(r io.Reader) (string, error) {
	length, err := readUint32LE(r)
	if err != nil {
		return "", err
	}

	data, err := readExact(r, length)

	return string(data), err
}

func decodeVorbisComment(r io.Reader) (map[string]string, error) {
	// Vendor info
	_, err := readCommentString(r)
	if err != nil {
		return nil, err
	}

	commentListLength, err := readUint32LE(r)
	if err != nil {
		return nil, err
	}

	comments := make(map[string]string)

	for i := 0; i < int(commentListLength); i++ {
		comment, err := readCommentString(r)
		if err != nil {
			return nil, err
		}

		parts := strings.SplitN(comment, "=", 2)

		if len(parts) != 2 {
			return nil, ErrInvalidMetadata
		}

		comments[parts[0]] = parts[1]
	}

	return comments, nil
}

func decodeFLACMetadata(r io.ReadSeeker) (Metadata, error) {
	// fLaC header was checked beforehand and can be skipped
	_, _ = readUint32BE(r)

	var header flacMetadataBlockHeader
	var err error

	// Find VORBIS_COMMENT block
	for !header.IsLast {
		header, err = decodeHeader(r)
		if err != nil {
			return Metadata{}, err
		}

		if header.Type == typeVorbisComment {
			break
		}

		if _, err = r.Seek(int64(header.Length), io.SeekCurrent); err != nil {
			return Metadata{}, err
		}
	}

	if header.Type != typeVorbisComment {
		return Metadata{}, ErrTagsNotFound
	}

	tags, err := decodeVorbisComment(r)
	if err != nil {
		return Metadata{}, err
	}

	return Metadata{
		Tags: tags,
	}, nil
}
