package main

import (
	"log"
	"os"
	"os/signal"
	"syscall"

	"template/backend/internal/runner"
)

func main() {
	address := "127.0.0.1:8080"
	log.Printf("Starting standalone ConnectRPC server on TCP %s", address)

	if _, err := runner.StartTCPServer(address); err != nil {
		log.Fatalf("Failed to start server: %v", err)
	}

	// Block until we receive a termination signal
	sigs := make(chan os.Signal, 1)
	signal.Notify(sigs, syscall.SIGINT, syscall.SIGTERM)
	<-sigs

	log.Println("Shutting down standalone server...")
}
