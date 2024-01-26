package main

import (
	"embed"
	"errors"
	"io/fs"
	"log"
	"net/http"
	"os"
	"time"

	"github.com/go-chi/chi/v5"
	"github.com/go-chi/cors"

	"github.com/flacster/flacster/internal/config"
	"github.com/flacster/flacster/internal/httpapi"
)

type Server struct {
	router chi.Router
}

func NewServer(static fs.FS) Server {
	r := chi.NewRouter()

	r.Use(cors.Handler(cors.Options{
		AllowedOrigins: []string{"https://*", "http://*"},
		AllowedMethods: []string{"HEAD", "GET", "POST", "DELETE", "PATCH"},
		AllowedHeaders: []string{"*"},
	}))

	r.Route("/api/v1", func(r chi.Router) {
		r.Get("/list-files", httpapi.ListFiles)
	})

	r.Handle("/*", http.FileServer(http.FS(static)))

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

//go:embed all:static/*
var static embed.FS

func main() {
	conf := loadConfig()

	sub, _ := fs.Sub(static, "static")

	server := NewServer(sub)
	server.Start(conf.Address)
}
