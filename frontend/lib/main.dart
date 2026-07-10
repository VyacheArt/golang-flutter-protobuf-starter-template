import 'dart:ui';
import 'package:flutter/material.dart';
import 'src/core/backend.dart';
import 'src/features/greet/presentation/greet_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the backend framework
  final backend = await Backend.init();

  // Create listener to gracefully stop the backend on exit
  AppLifecycleListener(
    onExitRequested: () async {
      backend.dispose();
      return AppExitResponse.exit;
    },
  );

  runApp(MyApp(backend: backend));
}

class MyApp extends StatelessWidget {
  final Backend backend;
  const MyApp({super.key, required this.backend});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter + Go + ConnectRPC',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: GreetPage(transport: backend.transport),
    );
  }
}
