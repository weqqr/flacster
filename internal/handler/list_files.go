package handler

import "github.com/flacster/flacster/internal/domain"

func ListFiles(request domain.ListFilesRequest) (domain.ListFilesResponse, error) {
	return domain.ListFilesResponse{
		Files: []string{
			"abc",
		},
	}, nil
}
