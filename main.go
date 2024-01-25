package main

import (
	"net/http"

	"github.com/go-chi/chi/v5"
	"github.com/weqqr/flacster/internal/httpapi"

	"log"
)

type Server struct {
	router chi.Router
}

func NewServer() Server {
	r := chi.NewRouter()

	r.Route("/api/v1", func(r chi.Router) {
		r.Get("/list-files", httpapi.ListFiles)
	})

	return Server{
		router: r,
	}
}

func (s *Server) Start(address string) {
	log.Printf("listening at %v", address)
	log.Fatal(http.ListenAndServe(address, s.router))
}

func main() {
	server := NewServer()
	server.Start(":1337")
}
