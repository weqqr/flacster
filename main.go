package main

import (
	"errors"
	"log"
	"net/http"
	"os"
	"time"

	"github.com/go-chi/chi/v5"

	"github.com/flacster/flacster/internal/config"
	"github.com/flacster/flacster/internal/httpapi"
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
	server := &http.Server{
		Addr:         address,
		Handler:      s.router,
		ReadTimeout:  10 * time.Second,
		WriteTimeout: 10 * time.Second,
		IdleTimeout:  30 * time.Second,
	}

	log.Printf("listening at %v", address)
	log.Fatal(server.ListenAndServe())
}

func loadConfig() config.Config {
	configPath := config.Path()

	conf, err := config.ReadConfig(configPath)

	if errors.Is(err, os.ErrNotExist) {
		log.Println("config file not found, using default")
		conf = config.Default()
		conf.Save(configPath)
	} else if err != nil {
		log.Fatalf("failed to read config: %v", err)
	}

	return conf
}

func main() {
	conf := loadConfig()

	server := NewServer()
	server.Start(conf.Address)
}
