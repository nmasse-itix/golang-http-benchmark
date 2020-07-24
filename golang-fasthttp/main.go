package main

import (
	"fmt"
	"time"

	"github.com/valyala/fasthttp"
)

type HelloWorldHandler struct {
}

func fastHTTPHandler(ctx *fasthttp.RequestCtx) {
	fmt.Fprintln(ctx, "Hello, World!")
}

func main() {
	s := &fasthttp.Server{
		Handler:      fastHTTPHandler,
		ReadTimeout:  10 * time.Second,
		WriteTimeout: 10 * time.Second,
		IdleTimeout:  10 * time.Second,
	}
	fmt.Println("Listening for requests on port 8002...")
	s.ListenAndServe(":8002")
}
