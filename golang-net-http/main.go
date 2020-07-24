package main

import (
	"fmt"
	"log"
	"net/http"
	"time"
)

type HelloWorldHandler struct {
}

func (h *HelloWorldHandler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	w.WriteHeader(http.StatusOK)
	w.Write([]byte("Hello, World!"))
}

func main() {
	h := &HelloWorldHandler{}

	s := &http.Server{
		Addr:              ":8001",
		Handler:           h,
		ReadTimeout:       10 * time.Second,
		ReadHeaderTimeout: 10 * time.Second,
		WriteTimeout:      10 * time.Second,
		MaxHeaderBytes:    1 << 20,
		IdleTimeout:       10 * time.Second,
	}
	fmt.Println("Listening for requests on port 8001...")
	log.Fatal(s.ListenAndServe())
}
