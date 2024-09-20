package main

import (
	"context"
	"errors"
	"io/fs"
	"log"
	"net/http"
	"os"
	"time"

	"github.com/alexflint/go-arg"
	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
	"github.com/go-chi/cors"

	"github.com/flacster/flacster/internal/config"
	"github.com/flacster/flacster/internal/database/sqlite3db"
	"github.com/flacster/flacster/internal/index"
	"github.com/flacster/flacster/internal/repo/file"
	"github.com/flacster/flacster/static"
)

type ForceIndex struct{}

var args struct {
	ForceIndex *ForceIndex `arg:"subcommand:forceindex"`
}

func main() {
	arg.MustParse(&args)

	conf := loadConfig()

	switch {
	case args.ForceIndex != nil:
		forceIndex(conf)
	default:
		server := NewServer(conf)
		server.Start(conf.Address)
	}
}

func forceIndex(conf config.Config) {
	db, err := sqlite3db.NewSQLite3DB()
	if err != nil {
		log.Fatal(err)
	}

	defer db.Close()

	indexer := index.NewIndexer(file.NewFileRepo(db))
	err = indexer.Index(context.Background(), conf.LibraryPath)
	if err != nil {
		log.Fatal(err)
	}
}

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
		if err := conf.Save(configPath); err != nil {
			log.Fatal("couldn't write default config")
		}

	} else if err != nil {
		log.Fatalf("failed to read config: %v", err)
	}

	return conf
}
