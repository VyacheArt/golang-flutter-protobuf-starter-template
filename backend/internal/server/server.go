package server

import (
	"net/http"
	
	"template/backend/gen/greet/v1/greetv1connect"
	"template/backend/internal/greet"
	
	"template/backend/gen/sysinfo/v1/sysinfov1connect"
	"template/backend/internal/sysinfo"
)

func RegisterHandlers(mux *http.ServeMux) {
	greetPath, greetHandler := greetv1connect.NewGreetServiceHandler(greet.NewService())
	mux.Handle(greetPath, greetHandler)

	sysInfoPath, sysInfoHandler := sysinfov1connect.NewSysInfoServiceHandler(sysinfo.NewService())
	mux.Handle(sysInfoPath, sysInfoHandler)
}
