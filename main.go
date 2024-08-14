package main

import (
	"database/sql"

	"github.com/techschool/simplebank/api"
	db "github.com/techschool/simplebank/db/sqlc"

	"log"
)

const (
	dbDriver      = "postgres"
	dbSource      = "postgresql://eugeneobazee:eugene_admin@localhost:5432/banky?sslmode=disable"
	serverAddress = "0.0.0.0:8080"
)

func main() {
	conn, err := sql.Open(dbDriver, dbSource)

	if err != nil {
		log.Fatal("cannot connect to db:", err)
	}

	store := db.NewStore(conn)
	server := api.NewServer(store)

	err = server.Start(serverAddress)
	if err != nil {
		log.Fatal("cannot start server:", err)
	}

}
