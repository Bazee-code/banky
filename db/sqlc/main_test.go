package db

import (
	"database/sql"
	"log"
	"os"
	"testing"

	_ "github.com/lib/pq"
)

const (
	dbDriver = "postgres"
	dbSource = "postgresql://eugene@localhost:5432/banky?sslmode=disable"
)

var testQueries *Queries

var testDB *sql.DB

// entry point for all unit tests of a go package in our case package db
func TestMain(m *testing.M) {
	var err error

	// conn, err = sql.Open(dbDriver, dbSource)
	testDB, err = sql.Open(dbDriver, dbSource)

	if err != nil {
		log.Fatal("cannot connect to db:", err)
	}
	// testQueries = New(conn)
	testQueries = New(testDB)

	os.Exit((m.Run()))
}
