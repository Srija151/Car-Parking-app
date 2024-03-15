// main.go

package main

import (
	"database/sql"
	"fmt"
	"log"
	"net/http"

	"github.com/go-sql-driver/mysql"
	"github.com/labstack/echo/v4"
	"github.com/rs/cors"
)

var db *sql.DB

type Login struct {
	UserName        string `json : "UserName"`
	Password        string `json : "password"`
	ConfirmPassword string `json : "confirmpassword"`
}

func connectDB() *sql.DB {
	cfg := mysql.Config{
		User:                 "root",
		Passwd:               "21a81a4330",
		Net:                  "tcp",
		Addr:                 "localhost:3306",
		DBName:               "go",
		AllowNativePasswords: true,
	}

	var err error
	db, err = sql.Open("mysql", cfg.FormatDSN())
	if err != nil {
		log.Fatal(err)
	}
	pingErr := db.Ping()
	if pingErr != nil {
		log.Fatal(pingErr)
	}
	fmt.Println("Connected!")
	return db

}

func main() {

	e := echo.New()
	connectDB()

	e.Use(echo.WrapMiddleware(cors.Default().Handler))

	e.GET("/", func(c echo.Context) error {

		return c.String(http.StatusOK, "Hello, World!")
	})

	e.POST("/Createaccount", func(c echo.Context) error {
		db := connectDB()
		var data Login
		if err := c.Bind(&data); err != nil {
			return err
		}
		fmt.Println(data)

		_, _ = db.Exec("INSERT INTO autho (username,password,confirmpassword) VALUES (?, ?, ?)",
			data.UserName, data.Password, data.ConfirmPassword)

		return c.String(http.StatusOK, "Data inserted successfully")
	})

	/*e.POST("/login", func(c echo.Context) error {
		db := connectDB()
		var data Login
		if err := c.Bind(&data); err != nil {
			return err
		}

		var storedPassword string
		err := db.QueryRow("SELECT password FROM user WHERE username = ?", data.UserName).Scan(&storedPassword)
		if err != nil {
			return err
		}

		if storedPassword == data.Password {
			return c.String(http.StatusOK, "Login successful")
		}

		return c.String(http.StatusUnauthorized, "Invalid username or password")
	})*/

	e.Logger.Fatal(e.Start(":8080"))

}
