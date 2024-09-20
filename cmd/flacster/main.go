package main

import (
	"errors"
	"io/fs"
	"log"
	"net/http"
	"os"
	"time"

	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
	"github.com/go-chi/cors"

	"github.com/flacster/flacster/internal/config"
	"github.com/flacster/flacster/internal/httpapi/library"
	"github.com/flacster/flacster/static"
)

type Server struct {
	router chi.Router
}

func NewServer(config config.Config) Server {
	r := chi.NewRouter()

	r.Use(middleware.RealIP)
	r.Use(middleware.Logger)
	r.Use(middleware.Recoverer)

	r.Use(cors.Handler(cors.Options{
		AllowedOrigins: []string{"https://*", "http://*"},
		AllowedMethods: []string{"HEAD", "GET", "POST", "DELETE", "PATCH"},
		AllowedHeaders: []string{"*"},
	}))

	libraryServer := library.NewServer(config)

	r.Route("/api/v1", func(r chi.Router) {
		r.Mount("/library", libraryServer.Router())
	})

	ui, _ := fs.Sub(static.UI, "ui")

	r.Handle("/*", http.FileServer(http.FS(ui)))

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

	server := NewServer(conf)
	server.Start(conf.Address)
}
