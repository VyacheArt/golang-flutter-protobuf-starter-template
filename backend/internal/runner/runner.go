package runner

import (
	"log"
	"net"
	"net/http"
	"os"
	"time"

	"template/backend/internal/server"
)

// currentServer holds the singleton instance of the HTTP server.
// Since C-shared libraries use global state to communicate back to Dart easily,
// a singleton server instance is acceptable here.
var currentServer *http.Server

// loggingMiddleware intercepts incoming HTTP requests to log their method, path, and client address.
func loggingMiddleware(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		log.Printf("[Backend] Incoming request: %s %s from %s", r.Method, r.URL.Path, r.RemoteAddr)
		next.ServeHTTP(w, r)
	})
}

func startServerOnListener(listener net.Listener) {
	mux := http.NewServeMux()

	// Register all ConnectRPC handlers (GreetService, SysInfoService, etc.)
	server.RegisterHandlers(mux)

	// Enable native HTTP/2 without TLS (h2c) - requires Go 1.24+ or golang.org/x/net/http2/h2c
	protos := new(http.Protocols)
	protos.SetHTTP1(true)
	protos.SetUnencryptedHTTP2(true)

	srv := &http.Server{
		Handler:   loggingMiddleware(mux),
		Protocols: protos,
		// Best practice: mitigate Slowloris attacks by enforcing a short timeout for reading headers.
		// Note: We do NOT set ReadTimeout or WriteTimeout here because they apply to the entire
		// connection lifetime, which would break Server-Side Streaming.
		ReadHeaderTimeout: 5 * time.Second,
	}
	currentServer = srv

	// Start the server in a non-blocking goroutine.
	go func() {
		// Ignore ErrServerClosed since it's expected during graceful shutdown or forced close.
		if err := srv.Serve(listener); err != nil && err != http.ErrServerClosed {
			log.Printf("[Backend] Server error: %v", err)
		}
	}()
}

// StopServer forcefully closes all active connections and shuts down the listener.
// We use Close() instead of Shutdown() so the Desktop app can exit immediately without
// waiting for long-running streaming RPCs (like WatchMetrics) to finish.
func StopServer() error {
	if currentServer != nil {
		log.Println("[Backend] Stopping server...")
		return currentServer.Close()
	}
	return nil
}

// StartUDSServer initializes the HTTP/2 server over a Unix Domain Socket.
func StartUDSServer(socketPath string) error {
	// Clean up stale socket file if the previous process crashed.
	_ = os.Remove(socketPath)

	listener, err := net.Listen("unix", socketPath)
	if err != nil {
		return err
	}
	log.Printf("[Backend] Listening on UDS: %s", socketPath)
	startServerOnListener(listener)
	return nil
}

// StartTCPServer initializes the HTTP/2 server over standard TCP.
func StartTCPServer(address string) error {
	listener, err := net.Listen("tcp", address)
	if err != nil {
		return err
	}
	log.Printf("[Backend] Listening on TCP: %s", address)
	startServerOnListener(listener)
	return nil
}
