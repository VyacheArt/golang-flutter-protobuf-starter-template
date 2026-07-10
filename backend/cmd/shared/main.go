package main

import "C"
import (
	"template/backend/internal/runner"
)

//export StartUDSServer
func StartUDSServer(socketPath *C.char) *C.char {
	err := runner.StartUDSServer(C.GoString(socketPath))
	if err != nil {
		return C.CString(err.Error())
	}
	return nil
}

//export StartTCPServer
func StartTCPServer(address *C.char) *C.char {
	err := runner.StartTCPServer(C.GoString(address))
	if err != nil {
		return C.CString(err.Error())
	}
	return nil
}

//export StopServer
func StopServer() *C.char {
	err := runner.StopServer()
	if err != nil {
		return C.CString(err.Error())
	}
	return nil
}

func main() {}
