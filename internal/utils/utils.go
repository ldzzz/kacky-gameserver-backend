package utils

import (
	"encoding/json"
	"log/slog"
	"reflect"

	"github.com/go-playground/validator/v10"
	"github.com/nats-io/nats.go/micro"
)

// Error struct that is returned as responses to request
type RequestError struct {
	Code    int    `json:"code"`
	Message string `json:"message"`
}

func (err RequestError) Error() string {
	ret, _ := json.Marshal(err)
	return string(ret)
}

func PrettyPrint(i interface{}) string {
	s, _ := json.Marshal(i)
	return string(s)
}

func updateGameType(v interface{}) {
	rv := reflect.ValueOf(v)
	if rv.Kind() == reflect.Ptr {
		rv = rv.Elem()
	}
	if rv.Kind() != reflect.Struct {
		return
	}
	gameTypeField := rv.FieldByName("GameType")
	if gameTypeField.IsValid() {
		if gameTypeField.CanSet() {
			if gameTypeField.String() == "Trackmania" {
				gameTypeField.SetString("KR")
			} else {
				gameTypeField.SetString("KK")
			}
		}
	}
}

func Deserialize(req micro.Request, obj any) error {
	if err := json.Unmarshal(req.Data(), obj); err != nil {
		slog.Error("Unable to marshal JSON", "error", err)
		return RequestError{400, "Bad Request"}
	}
	validate := validator.New()
	if err := validate.Struct(obj); err != nil {
		slog.Error("Validation failed", "error", err)
		return RequestError{400, "Bad Request"}
	}

	// convert gameType from names to event names
	updateGameType(obj)

	return nil
}
