import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/main.dart';
import 'package:frontend/src/core/backend.dart';
import 'package:frontend/src/rpc/transport_stub.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    final backend = Backend(getTransport('dummy'));
    
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(backend: backend));

    // Verify that our title is present.
    expect(find.text('Starter Template'), findsOneWidget);
    expect(find.text('Enter your name'), findsOneWidget);
  });
}
