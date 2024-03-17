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

type Reg struct {
	UserName string `json : "UserName"`
	Password string `json : "password"`
}

var db *sql.DB

func ConnectDB() *sql.DB {
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
	db := ConnectDB()
	e.Use(echo.WrapMiddleware(cors.Default().Handler))

	e.POST("/Createaccount", func(c echo.Context) error {
		var data Reg
		if err := c.Bind(&data); err != nil {
			return err
		}
		fmt.Println(data)

		_, _ = db.Exec("INSERT INTO users (username,password) VALUES (?, ?)",
			data.UserName, data.Password)

		return c.String(http.StatusOK, "Data inserted successfully")
	})

	// Update the /signin route to handle errors properly and provide detailed logging

	// Update the /signin route to handle errors properly and provide detailed logging

	e.POST("/signin", func(c echo.Context) error {
		var data map[string]string
		if err := c.Bind(&data); err != nil {
			return err
		}
		fmt.Println(data)

		// Prepare the SQL query
		query := "SELECT username, password FROM users WHERE username = ? AND password = ?"

		// Execute the query
		rows, err := db.Query(query, data["Username"], data["Password"])
		if err != nil {
			// Log the error
			fmt.Println("Error executing SQL query:", err)
			return err // Return the error to the client
		}
		defer rows.Close()

		rowCount := 0
		for rows.Next() {
			// User found
			rowCount++
		}

		if rowCount == 0 {
			// User not found
			return c.String(http.StatusNotFound, "User not found")
		}

		// User found
		return c.String(http.StatusOK, "Login successfully")
	})

	e.POST("/forgot",
		func(c echo.Context) error {
			var data map[string]string
			fmt.Println("Hello")
			if err := c.Bind(&data); err != nil {
				return c.String(http.StatusBadRequest, "Invalid request body")
			}

			// Check if the required fields are present in the request body
			if data["username"] == "" {
				return c.String(http.StatusBadRequest, "Username is required")
			}

			// Query the database to check if the provided username and email match
			rows, err := db.Query("SELECT username FROM user WHERE username = ?", data["username"])
			if err != nil {
				return c.String(http.StatusInternalServerError, "Database error")
			}
			defer rows.Close()

			// Check if the user exists with the provided username and email
			userExists := false
			for rows.Next() {
				userExists = true
				break
			}

			if !userExists {
				return c.String(http.StatusNotFound, "User not found")
			}

			// If everything is successful, return a success response
			return c.String(http.StatusOK, "Password recovery initiated")
		})
	e.POST("/reset",
		func(c echo.Context) error {

			var data map[string]string
			if err := c.Bind(&data); err != nil {
				return err
			}

			// New password received from the request
			newPassword := data["password"]

			// Update the password for the specified username
			result, err := db.Exec("UPDATE user SET password = ? WHERE username = ?", newPassword, data["username"])
			if err != nil {
				panic(err.Error())
			}

			// Check the number of rows affected to verify if the update was successful
			rowsAffected, err := result.RowsAffected()
			if err != nil {
				panic(err.Error())
			}

			// If no rows were affected, it means the username doesn't exist
			if rowsAffected == 0 {
				return c.String(http.StatusNotFound, "User not found")
			}

			// If rows were affected, it means the password was updated successfully
			return c.String(http.StatusOK, "Password updated successfully")

		})

	e.Logger.Fatal(e.Start(":8080"))

}
