package domain

type Track struct {
}

type File struct {
	Digest []byte
	Path   string
	Tags   map[string]string
}
