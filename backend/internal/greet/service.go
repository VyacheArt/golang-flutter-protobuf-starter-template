package greet

import (
	"context"
	"errors"
	"fmt"
	"io"

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

func (s *Service) GreetStream(
	ctx context.Context,
	stream *connect.BidiStream[greetv1.GreetRequest, greetv1.GreetResponse],
) error {
	for {
		req, err := stream.Receive()
		if errors.Is(err, io.EOF) {
			// The client closed its side of the stream.
			return nil
		}
		if err != nil {
			return err
		}
		if err := stream.Send(&greetv1.GreetResponse{
			Greeting: fmt.Sprintf("Hello, %s!", req.Name),
		}); err != nil {
			return err
		}
	}
}
