package api

import (
	"github.com/gin-gonic/gin"

	"github.com/gin-gonic/gin/binding"
	db "github.com/techschool/simplebank/db/sqlc"

	"github.com/go-playground/validator/v10"
)

type Server struct {
	store  db.Store    //allow us to interact with db
	router *gin.Engine // allows us to process our http requests
}

func NewServer(store db.Store) *Server {
	server := &Server{store: store}
	router := gin.Default()

	if val, ok := binding.Validator.Engine().(*validator.Validate); ok {
		val.RegisterValidation("currency", validCurrency)
	}

	router.GET("/accounts", server.getAllAccounts)
	router.POST("/accounts", server.createAccount)
	router.GET("/accounts/:id", server.getAccountById)
	router.PUT("/accounts", server.updateAccount)
	router.DELETE("/accounts/:id", server.deleteAccount)

	router.POST("/transfers", server.createTransfer)

	server.router = router
	return server
}

// run the http server on a specified address
func (server *Server) Start(address string) error {
	return server.router.Run(address)
}

func errorResponse(err error) gin.H {
	return gin.H{
		"error": err.Error()}
}
