import 'package:flutter/material.dart';

/// Create a Circular countdown indicator
class CountDownProgressIndicator extends StatefulWidget {
  final int duration;
  final Color backgroundColor;
  final Color valueColor;
  final CountDownController controller;
  final Function onComplete;
  final double strokeWidth;
  final int initialPosition;
  final Color textColor;

  // ignore: public_member_api_docs
  const CountDownProgressIndicator({
    Key key,
    @required this.duration,
    this.initialPosition = 0,
    @required this.backgroundColor,
    @required this.valueColor,
    @required this.controller,
    @required this.onComplete,
    this.textColor = Colors.black,
    this.strokeWidth = 10,
  })  : assert(duration > 0),
        super(key: key);

  @override
  CountDownProgressIndicatorState createState() =>
      CountDownProgressIndicatorState();
}

class CountDownProgressIndicatorState extends State<CountDownProgressIndicator>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _animationController;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: widget.duration,
      ),
    );
    _animation = Tween<double>(
      begin: widget.initialPosition.toDouble(),
      end: widget.duration.toDouble(),
    ).animate(_animationController);

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) widget.onComplete();
    });

    _animationController.addListener(() {
      setState(() {});
    });

    widget.controller._state = this;

    onAnimationStart();
  }

  @override
  void reassemble() {
    onAnimationStart();
    super.reassemble();
  }

  void onAnimationStart() {
    _animationController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: CircularProgressIndicator(
              strokeWidth: widget.strokeWidth,
              backgroundColor: widget.backgroundColor,
              valueColor: AlwaysStoppedAnimation<Color>(widget.valueColor),
              value: (widget.duration - _animation.value) / widget.duration,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: (widget.duration - _animation.value)
                          .toStringAsFixed(0),
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: widget.textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                    TextSpan(
                      text: '\nSEG',
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: widget.textColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Helper class for CountDown widget
class CountDownController {
  CountDownProgressIndicatorState _state;

  /// Pause countdown timer
  void pause() {
    _state._animationController.stop(canceled: false);
  }

  /// Resume countdown time
  void resume() {
    _state._animationController.forward(from: _state._animation.value ?? 0);
  }

  /// Restart countdown timer.
  ///
  /// * [time] is an optional value, if this value is null,
  /// the time will use the previous time defined in the widget
  void restart({int time}) {}
}
