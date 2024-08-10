// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.27.0

package database

import (
	"context"
	"database/sql"
	"fmt"
)

type DBTX interface {
	ExecContext(context.Context, string, ...interface{}) (sql.Result, error)
	PrepareContext(context.Context, string) (*sql.Stmt, error)
	QueryContext(context.Context, string, ...interface{}) (*sql.Rows, error)
	QueryRowContext(context.Context, string, ...interface{}) *sql.Row
}

func New(db DBTX) *Queries {
	return &Queries{db: db}
}

func Prepare(ctx context.Context, db DBTX) (*Queries, error) {
	q := Queries{db: db}
	var err error
	if q.createUpdatePlayerStmt, err = db.PrepareContext(ctx, createUpdatePlayer); err != nil {
		return nil, fmt.Errorf("error preparing query CreateUpdatePlayer: %w", err)
	}
	if q.createUpdatePlayerMapFinishStmt, err = db.PrepareContext(ctx, createUpdatePlayerMapFinish); err != nil {
		return nil, fmt.Errorf("error preparing query CreateUpdatePlayerMapFinish: %w", err)
	}
	if q.createUpdateStreamDataTM20Stmt, err = db.PrepareContext(ctx, createUpdateStreamDataTM20); err != nil {
		return nil, fmt.Errorf("error preparing query CreateUpdateStreamDataTM20: %w", err)
	}
	if q.createUpdateStreamDataTMNFStmt, err = db.PrepareContext(ctx, createUpdateStreamDataTMNF); err != nil {
		return nil, fmt.Errorf("error preparing query CreateUpdateStreamDataTMNF: %w", err)
	}
	if q.fetchMapByUidStmt, err = db.PrepareContext(ctx, fetchMapByUid); err != nil {
		return nil, fmt.Errorf("error preparing query FetchMapByUid: %w", err)
	}
	if q.fetchPlayerMapFinishStmt, err = db.PrepareContext(ctx, fetchPlayerMapFinish); err != nil {
		return nil, fmt.Errorf("error preparing query FetchPlayerMapFinish: %w", err)
	}
	if q.getPlayerStmt, err = db.PrepareContext(ctx, getPlayer); err != nil {
		return nil, fmt.Errorf("error preparing query GetPlayer: %w", err)
	}
	if q.getPlayerFinishesStmt, err = db.PrepareContext(ctx, getPlayerFinishes); err != nil {
		return nil, fmt.Errorf("error preparing query GetPlayerFinishes: %w", err)
	}
	if q.getPlayerMetadataStmt, err = db.PrepareContext(ctx, getPlayerMetadata); err != nil {
		return nil, fmt.Errorf("error preparing query GetPlayerMetadata: %w", err)
	}
	if q.setPlayerRoleStmt, err = db.PrepareContext(ctx, setPlayerRole); err != nil {
		return nil, fmt.Errorf("error preparing query SetPlayerRole: %w", err)
	}
	return &q, nil
}

func (q *Queries) Close() error {
	var err error
	if q.createUpdatePlayerStmt != nil {
		if cerr := q.createUpdatePlayerStmt.Close(); cerr != nil {
			err = fmt.Errorf("error closing createUpdatePlayerStmt: %w", cerr)
		}
	}
	if q.createUpdatePlayerMapFinishStmt != nil {
		if cerr := q.createUpdatePlayerMapFinishStmt.Close(); cerr != nil {
			err = fmt.Errorf("error closing createUpdatePlayerMapFinishStmt: %w", cerr)
		}
	}
	if q.createUpdateStreamDataTM20Stmt != nil {
		if cerr := q.createUpdateStreamDataTM20Stmt.Close(); cerr != nil {
			err = fmt.Errorf("error closing createUpdateStreamDataTM20Stmt: %w", cerr)
		}
	}
	if q.createUpdateStreamDataTMNFStmt != nil {
		if cerr := q.createUpdateStreamDataTMNFStmt.Close(); cerr != nil {
			err = fmt.Errorf("error closing createUpdateStreamDataTMNFStmt: %w", cerr)
		}
	}
	if q.fetchMapByUidStmt != nil {
		if cerr := q.fetchMapByUidStmt.Close(); cerr != nil {
			err = fmt.Errorf("error closing fetchMapByUidStmt: %w", cerr)
		}
	}
	if q.fetchPlayerMapFinishStmt != nil {
		if cerr := q.fetchPlayerMapFinishStmt.Close(); cerr != nil {
			err = fmt.Errorf("error closing fetchPlayerMapFinishStmt: %w", cerr)
		}
	}
	if q.getPlayerStmt != nil {
		if cerr := q.getPlayerStmt.Close(); cerr != nil {
			err = fmt.Errorf("error closing getPlayerStmt: %w", cerr)
		}
	}
	if q.getPlayerFinishesStmt != nil {
		if cerr := q.getPlayerFinishesStmt.Close(); cerr != nil {
			err = fmt.Errorf("error closing getPlayerFinishesStmt: %w", cerr)
		}
	}
	if q.getPlayerMetadataStmt != nil {
		if cerr := q.getPlayerMetadataStmt.Close(); cerr != nil {
			err = fmt.Errorf("error closing getPlayerMetadataStmt: %w", cerr)
		}
	}
	if q.setPlayerRoleStmt != nil {
		if cerr := q.setPlayerRoleStmt.Close(); cerr != nil {
			err = fmt.Errorf("error closing setPlayerRoleStmt: %w", cerr)
		}
	}
	return err
}

func (q *Queries) exec(ctx context.Context, stmt *sql.Stmt, query string, args ...interface{}) (sql.Result, error) {
	switch {
	case stmt != nil && q.tx != nil:
		return q.tx.StmtContext(ctx, stmt).ExecContext(ctx, args...)
	case stmt != nil:
		return stmt.ExecContext(ctx, args...)
	default:
		return q.db.ExecContext(ctx, query, args...)
	}
}

func (q *Queries) query(ctx context.Context, stmt *sql.Stmt, query string, args ...interface{}) (*sql.Rows, error) {
	switch {
	case stmt != nil && q.tx != nil:
		return q.tx.StmtContext(ctx, stmt).QueryContext(ctx, args...)
	case stmt != nil:
		return stmt.QueryContext(ctx, args...)
	default:
		return q.db.QueryContext(ctx, query, args...)
	}
}

func (q *Queries) queryRow(ctx context.Context, stmt *sql.Stmt, query string, args ...interface{}) *sql.Row {
	switch {
	case stmt != nil && q.tx != nil:
		return q.tx.StmtContext(ctx, stmt).QueryRowContext(ctx, args...)
	case stmt != nil:
		return stmt.QueryRowContext(ctx, args...)
	default:
		return q.db.QueryRowContext(ctx, query, args...)
	}
}

type Queries struct {
	db                              DBTX
	tx                              *sql.Tx
	createUpdatePlayerStmt          *sql.Stmt
	createUpdatePlayerMapFinishStmt *sql.Stmt
	createUpdateStreamDataTM20Stmt  *sql.Stmt
	createUpdateStreamDataTMNFStmt  *sql.Stmt
	fetchMapByUidStmt               *sql.Stmt
	fetchPlayerMapFinishStmt        *sql.Stmt
	getPlayerStmt                   *sql.Stmt
	getPlayerFinishesStmt           *sql.Stmt
	getPlayerMetadataStmt           *sql.Stmt
	setPlayerRoleStmt               *sql.Stmt
}

func (q *Queries) WithTx(tx *sql.Tx) *Queries {
	return &Queries{
		db:                              tx,
		tx:                              tx,
		createUpdatePlayerStmt:          q.createUpdatePlayerStmt,
		createUpdatePlayerMapFinishStmt: q.createUpdatePlayerMapFinishStmt,
		createUpdateStreamDataTM20Stmt:  q.createUpdateStreamDataTM20Stmt,
		createUpdateStreamDataTMNFStmt:  q.createUpdateStreamDataTMNFStmt,
		fetchMapByUidStmt:               q.fetchMapByUidStmt,
		fetchPlayerMapFinishStmt:        q.fetchPlayerMapFinishStmt,
		getPlayerStmt:                   q.getPlayerStmt,
		getPlayerFinishesStmt:           q.getPlayerFinishesStmt,
		getPlayerMetadataStmt:           q.getPlayerMetadataStmt,
		setPlayerRoleStmt:               q.setPlayerRoleStmt,
	}
}