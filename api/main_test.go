package api

import (
	"os"
	"testing"

	"github.com/gin-gonic/gin"
)

// entry point for all unit tests of a go package in our case package db
func TestMain(m *testing.M) {
	gin.SetMode(gin.TestMode)

	os.Exit((m.Run()))
}
