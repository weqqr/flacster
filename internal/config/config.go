package config

import (
	"os"
	"path/filepath"

	"github.com/pelletier/go-toml/v2"
)

type Config struct {
	Address    string `json:"address"`
	ConnString string `json:"conn_string"`
}

func Default() Config {
	return Config{
		Address:    ":1337",
		ConnString: "",
	}
}

func ReadConfig(path string) (Config, error) {
	data, err := os.ReadFile(path)
	if err != nil {
		return Config{}, err
	}

	var config Config

	err = toml.Unmarshal(data, &config)
	if err != nil {
		return Config{}, err
	}

	return config, nil
}

func (c Config) Save(path string) error {
	data, err := toml.Marshal(c)
	if err != nil {
		return err
	}

	return os.WriteFile(path, data, 0644)
}

func Path() string {
	workDir, err := os.Getwd()
	if err != nil {
		panic(err)
	}

	return filepath.Join(workDir, "flacster.toml")
}
