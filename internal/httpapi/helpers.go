package httpapi

import (
	"encoding/json"
	"net/http"
)

type errorJSON struct {
	Error string `json:"error"`
}

func SendError(w http.ResponseWriter, err error) {
	errJSON := errorJSON{
		Error: err.Error(),
	}

	data, _ := json.Marshal(errJSON)

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusInternalServerError)
	_, _ = w.Write(data)
}

func SendJSON(w http.ResponseWriter, response any) {
	data, err := json.Marshal(response)
	if err != nil {
		SendError(w, err)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	if _, err = w.Write(data); err != nil {
		return
	}
}
