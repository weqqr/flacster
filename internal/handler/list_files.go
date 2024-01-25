package handler

import "github.com/weqqr/flacster/internal/domain"

func ListFiles(request domain.ListFilesRequest) (domain.ListFilesResponse, error) {
	return domain.ListFilesResponse{
		Files: []string{
			"abc",
		},
	}, nil
}
