package library

import (
	"net/http"

	"github.com/flacster/flacster/internal/config"
	"github.com/flacster/flacster/internal/domain"
	"github.com/flacster/flacster/internal/handler/library"
	"github.com/flacster/flacster/internal/httpapi"
	"github.com/go-chi/chi/v5"
)

type Server struct {
	libraryHandler library.Handler
}

func NewServer(config config.Config) Server {
	return Server{
		libraryHandler: library.Handler{
			Config: config,
		},
	}
}

func (h *Server) Router() chi.Router {
	r := chi.NewRouter()

	r.Get("/files", h.ListFiles)

	return r
}

func (h *Server) ListFiles(w http.ResponseWriter, r *http.Request) {
	resp, err := h.libraryHandler.ListFiles(domain.ListFilesRequest{})
	if err != nil {
		httpapi.SendError(w, err)
		return
	}

	httpapi.SendJSON(w, resp)
}
