package helpers

import (
	"encoding/json"
)

func PrettyPrint(i interface{}) string {
	s, _ := json.Marshal(i)
	return string(s)
}
