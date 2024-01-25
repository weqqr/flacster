package domain

type (
	ListFilesRequest struct{}

	ListFilesResponse struct {
		Files []string `json:"files"`
	}
)
