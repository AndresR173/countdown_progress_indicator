import 'package:flutter/material.dart';

typedef CountDownAnimationStatus = void Function(AnimationStatus status);

class CountDownProgressIndicator extends StatefulWidget {
  final double time;
  final Color backgroundColor;
  final Color valueColor;
  final CountDownAnimationStatus onFinish;
  const CountDownProgressIndicator({
    Key key,
    this.time,
    this.backgroundColor,
    this.valueColor,
    this.onFinish,
  }) : super(key: key);

  @override
  CountDownProgressIndicatorState createState() =>
      CountDownProgressIndicatorState();
}

class CountDownProgressIndicatorState extends State<CountDownProgressIndicator>
    with SingleTickerProviderStateMixin {
  Animation<double> _doubleAnimation;
  AnimationController _animationController;
  final double initial = 0;

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
        seconds: widget.time.toInt(),
      ),
    );
    _doubleAnimation = Tween(
      begin: initial,
      end: widget.time,
    ).animate(_animationController);

    _animationController.addStatusListener((status) => widget.onFinish(status));

    _animationController.addListener(() {
      setState(() {});
    });
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
              strokeWidth: 10,
              backgroundColor: widget.backgroundColor,
              valueColor: AlwaysStoppedAnimation<Color>(widget.valueColor),
              value: (widget.time - _doubleAnimation.value) / widget.time,
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
                      text: (widget.time - _doubleAnimation.value)
                          .toStringAsFixed(0),
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                    TextSpan(
                      text: '\nSEG',
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: Colors.white,
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
