package players

import (
	"context"
	"database/sql"
	"encoding/json"
	"log/slog"

	"github.com/ldzzz/kacky-gameserver-backend/config"
	"github.com/ldzzz/kacky-gameserver-backend/dbops"
	"github.com/ldzzz/kacky-gameserver-backend/internal/utils"
)

func getPlayer(login string, gameType string) (*dbops.TmPlayer, error) {
	var fetchedPlayer dbops.TmPlayer
	var err error

	if fetchedPlayer, err = config.ENV.DB.GetPlayer(context.Background(), dbops.GetPlayerParams{Login: login, GameType: gameType}); err != nil {
		slog.Error("Failed to get player", "error", err)
		return nil, utils.RequestError{Code: 500, Message: "Internal Server Error"}
	}

	return &fetchedPlayer, nil
}

func getPlayerMetadata(id int64) (*dbops.UserMetadatum, error) {
	var playerMetadata dbops.UserMetadatum
	var err error
	if playerMetadata, err = config.ENV.DB.GetPlayerMetadata(context.Background(), dbops.GetPlayerMetadataParams{Tm20PlayerID: sql.NullInt64{Int64: id, Valid: true}, TmnfPlayerID: sql.NullInt64{Int64: id, Valid: true}}); err != nil && err != sql.ErrNoRows {
		slog.Error("Failed to get player metadata", "error", err)
		return nil, utils.RequestError{Code: 500, Message: "Internal Server Error"}
	}

	return &playerMetadata, nil
}

func createUpdateStreamer(gameType string, id int64, streamData json.RawMessage) error {
	var err error
	if gameType == "KR" {
		err = config.ENV.DB.CreateUpdateStreamDataTM20(context.Background(), dbops.CreateUpdateStreamDataTM20Params{Tm20PlayerID: sql.NullInt64{Int64: id, Valid: true}, StreamData: streamData})
	} else {
		err = config.ENV.DB.CreateUpdateStreamDataTMNF(context.Background(), dbops.CreateUpdateStreamDataTMNFParams{TmnfPlayerID: sql.NullInt64{Int64: id, Valid: true}, StreamData: streamData})
	}
	if err != nil {
		slog.Error("Failed to create/update player stream data", "error", err)
		return utils.RequestError{Code: 500, Message: "Internal Server Error"}
	}
	return nil

}
