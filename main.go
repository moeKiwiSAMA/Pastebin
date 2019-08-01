package main

import (
	"strings"
	"github.com/gomodule/redigo/redis"
	"encoding/hex"
	"io"
	"crypto/md5"
	"github.com/kataras/iris/middleware/logger"
	"github.com/kataras/iris/middleware/recover"
	"github.com/kataras/iris"
)

func main() {
	// Create Redis client instance
	redisClient, err := redis.Dial("tcp", "127.0.0.1:6379")
	if err != nil {
		panic(err)
	}
	// Create Iris app
	app := iris.New()
	app.Logger().SetLevel("debug")
	app.Use(recover.New())
	app.Use(logger.New())

	// ViewRegister
	app.RegisterView(iris.HTML("./public", ".html").Reload(true))

	// Static assets Handler
	app.HandleDir("/css", "./public/css")

	//Method: GET
	// Main Webpage
	app.Handle("GET", "/", func(ctx iris.Context) {
		ctx.View("input.html")
	})

	// Method: POST
	// Recv User input
	app.Post("/paste", func(ctx iris.Context){
		text := ctx.FormValue("text")
	// Generate an ID with md5[0:6]
		textMd5 := md5.New()
		io.WriteString(textMd5, text)
		textID := (hex.EncodeToString(textMd5.Sum(nil)))[0:6]

		app.Logger().Infof("IP:%s Send a paste %s", ctx.RemoteAddr(), textID)
		redisClient.Do("SET", textID, text, "ex", "100")

		ctx.ViewData("id", textID)
		ctx.View("redirect.html")
	})

	// Method: GET
	// Show RAW data
	app.Get("/{id:string}", func(ctx iris.Context){
		textID := ctx.Params().GetStringDefault("id", "")
		
		v, err := redis.String(redisClient.Do("GET", strings.ToLower(textID)))
		if err != nil {
			ctx.ViewData("id", "/")
			ctx.View("redirect.html")
		} else {
			ctx.ViewData("content", v)
			ctx.View("raw.html")
		}
	})

	// http://localhost:8964
	// http://localhost:8964/paste
	// http://localhost:8964/css
	// http://localhost:8964/{id:string}
	app.Run(iris.Addr(":8082"), iris.WithoutServerError(iris.ErrServerClosed))
}
