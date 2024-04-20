import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class AsyncVsIsolate extends StatelessWidget {
  const AsyncVsIsolate({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white10,
      body: Column(
        children: [
          const LoadingIndicator(
            indicatorType: Indicator.audioEqualizer,
            colors: [
              Colors.red,
              Colors.amber,
              Colors.yellow,
            ],
            strokeWidth: 2,
          ),
          const SizedBox(
            height: 32,
          ),
          // Async
          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: () async {
                double result = await testAsync();
                debugPrint("AsyncResult: $result");
              },
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                  Colors.amber,
                ),
              ),
              child: const Text(
                "Async",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          // Isolate
          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: () {
                final receivePort = ReceivePort();
                Isolate.spawn(testIsolate, receivePort.sendPort);
                receivePort.listen((result) {
                  debugPrint("IsolateResult: $result");
                });
              },
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                  Colors.red,
                ),
              ),
              child: const Text(
                "Isolate",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  // -- async--

  Future<double> testAsync() async {
    double total = 0;
    for (var i = 0; i < 1000000000; i++) {
      total += i;
    }
    return total;
  }
}

testIsolate(SendPort sendPort) {
  double total = 0;
  for (var i = 0; i < 1000000000; i++) {
    total += i;
  }
  sendPort.send(total);
}
