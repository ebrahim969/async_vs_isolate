import 'package:flutter/material.dart';
import 'package:isolate_vs_async/async_vs_isolate.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Isolate vs Async',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const AsyncVsIsolate(),
    );
  }
}
