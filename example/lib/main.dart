import 'package:countdown_progress_indicator/countdown_progress_indicator.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          color: Colors.white,
          child: Center(
            child: SizedBox(
              height: 200,
              width: 200,
              child: CountDownProgressIndicator(
                valueColor: Colors.red,
                backgroundColor: Colors.blue,
                time: 20,
                onFinish: (_) => null,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
