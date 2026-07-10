package greet

import (
	"context"
	"fmt"

	"connectrpc.com/connect"
	greetv1 "template/backend/gen/greet/v1"
)

type Service struct{}

func NewService() *Service {
	return &Service{}
}

func (s *Service) Greet(
	ctx context.Context,
	req *connect.Request[greetv1.GreetRequest],
) (*connect.Response[greetv1.GreetResponse], error) {
	return connect.NewResponse(&greetv1.GreetResponse{
		Greeting: fmt.Sprintf("Hello, %s!", req.Msg.Name),
	}), nil
}
