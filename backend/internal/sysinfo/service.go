package sysinfo

import (
	"context"
	"os"
	"runtime"
	"time"

	"connectrpc.com/connect"
	sysinfov1 "template/backend/gen/sysinfo/v1"
)

type Service struct{}

func NewService() *Service {
	return &Service{}
}

func (s *Service) GetSystemInfo(
	ctx context.Context,
	req *connect.Request[sysinfov1.GetSystemInfoRequest],
) (*connect.Response[sysinfov1.GetSystemInfoResponse], error) {
	hostname, err := os.Hostname()
	if err != nil {
		hostname = "unknown"
	}

	return connect.NewResponse(&sysinfov1.GetSystemInfoResponse{
		Hostname:  hostname,
		GoVersion: runtime.Version(),
		Os:        runtime.GOOS,
	}), nil
}

func (s *Service) WatchMetrics(
	ctx context.Context,
	req *connect.Request[sysinfov1.WatchMetricsRequest],
	stream *connect.ServerStream[sysinfov1.WatchMetricsResponse],
) error {
	ticker := time.NewTicker(1 * time.Second)
	defer ticker.Stop()

	for {
		select {
		case <-ctx.Done():
			return ctx.Err()
		case <-ticker.C:
			var m runtime.MemStats
			runtime.ReadMemStats(&m)

			err := stream.Send(&sysinfov1.WatchMetricsResponse{
				AllocatedMemory: m.Alloc,
				NumGoroutines:   uint64(runtime.NumGoroutine()),
			})
			if err != nil {
				return err
			}
		}
	}
}
