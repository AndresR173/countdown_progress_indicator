import 'package:countdown_progress_indicator/countdown_progress_indicator.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isRunning = true;
  final _controller = CountDownController();
  final _controller2 = CountDownController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 200,
                  width: 200,
                  child: CountDownProgressIndicator(
                    controller: _controller,
                    valueColor: Colors.red,
                    backgroundColor: Colors.blue,
                    initialPosition: 0,
                    duration: 365,
                    timeFormatter: (seconds) {
                      return Duration(seconds: seconds)
                          .toString()
                          .split('.')[0]
                          .padLeft(8, '0');
                    },
                    text: 'hh:mm:ss',
                    onComplete: () => null,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 200,
                  width: 200,
                  child: CountDownProgressIndicator(
                    controller: _controller2,
                    valueColor: Colors.red,
                    backgroundColor: Colors.blue,
                    initialPosition: 0,
                    duration: 365,
                    text: 'Seg',
                    onComplete: () => null,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => setState(() {
                    if (_isRunning) {
                      _controller.pause();
                      _controller2.pause();
                    } else {
                      _controller.resume();
                      _controller2.resume();
                    }

                    _isRunning = !_isRunning;
                  }),
                  child: Text(_isRunning ? 'Pause' : 'Resume'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
