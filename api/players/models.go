package players

type PlayerConnect struct {
	Login    string `json:"login" validate:"required"`
	Nickname string `json:"nickname" validate:"required"`
	Zone     string `json:"zone" validate:"required,contains=0x7C"` //TODO: ok to do this validation ?? -> checking if string contains pipe (|)
	GameType string `json:"gameType" validate:"required,oneof=TmForever Trackmania"`
}

type PlayerNickname struct {
	Login    string `json:"login" validate:"required"`
	Nickname string `json:"nickname" validate:"required"`
	GameType string `json:"gameType" validate:"required,oneof=TmForever Trackmania"`
}

type PlayerStreamerData struct {
	Login         string `json:"login" validate:"required"`
	Platform      string `json:"platform" validate:"required"`
	StreamerLogin string `json:"streamerLogin" validate:"required"`
	StreamStatus  *bool  `json:"streamStatus" validate:"required"`
	GameType      string `json:"gameType" validate:"required,oneof=TmForever Trackmania"`
}

type PlayerStreamerStatus struct {
	Login        string `json:"login" validate:"required"`
	StreamStatus *bool  `json:"streamStatus" validate:"required"`
	GameType     string `json:"gameType" validate:"required,oneof=TmForever Trackmania"`
}

type PlayerFinish struct {
	Login     string `json:"login" validate:"required"`
	MapUid    string `json:"mapUid" validate:"required"`
	Timestamp string `json:"timestamp" validate:"required"` //TODO: validate as datetime???
	Score     int    `json:"score" validate:"required,gt=0"`
	GameType  string `json:"gameType" validate:"required,oneof=TmForever Trackmania"`
}

type PlayerStreamData struct {
	Platform      *string `json:"platform"`
	StreamerLogin *string `json:"streamerLogin"`
	StreamStatus  *bool   `json:"streamStatus"`
}
