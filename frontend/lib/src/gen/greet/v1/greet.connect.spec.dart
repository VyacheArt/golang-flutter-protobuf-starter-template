//
//  Generated code. Do not modify.
//  source: greet/v1/greet.proto
//

import "package:connectrpc/connect.dart" as connect;
import "greet.pb.dart" as greetv1greet;

abstract final class GreetService {
  /// Fully-qualified name of the GreetService service.
  static const name = 'greet.v1.GreetService';

  static const greet = connect.Spec(
    '/$name/Greet',
    connect.StreamType.unary,
    greetv1greet.GreetRequest.new,
    greetv1greet.GreetResponse.new,
  );
}
