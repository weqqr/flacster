package httpapi

import (
	"encoding/json"
	"net/http"

	"github.com/flacster/flacster/internal/domain"
	"github.com/flacster/flacster/internal/handler"
)

func ListFiles(w http.ResponseWriter, r *http.Request) {
	resp, err := handler.ListFiles(domain.ListFilesRequest{})
	if err != nil {
		panic(err)
	}

	data, err := json.Marshal(resp)
	if err != nil {
		panic(err)
	}

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(200)
	w.Write(data)
}
