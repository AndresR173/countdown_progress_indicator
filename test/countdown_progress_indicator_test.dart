import 'package:countdown_progress_indicator/countdown_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('The widget has a title', (WidgetTester tester) async {
    await tester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: CountDownProgressIndicator(
          valueColor: Colors.red,
          backgroundColor: Colors.blue,
          initialPosition: 0,
          duration: 20,
          text: 'SEC',
        ),
      ),
    );

    final titleFinder = find.text('SEC');
    expect(titleFinder, findsOneWidget);
  });

  testWidgets('The widget stops at 0', (WidgetTester tester) async {
    await tester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: CountDownProgressIndicator(
          valueColor: Colors.red,
          backgroundColor: Colors.blue,
          initialPosition: 0,
          duration: 3,
          text: 'SEC',
        ),
      ),
    );

    await tester.pump(const Duration(seconds: 4));

    final textFinder = find.text('0');
    expect(textFinder, findsOneWidget);
  });

  testWidgets('The widget calls onComplete at the end of the animation',
      (WidgetTester tester) async {
    var onCallbackCalled = false;
    final onCallback = () => onCallbackCalled = true;

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: CountDownProgressIndicator(
          valueColor: Colors.red,
          backgroundColor: Colors.blue,
          initialPosition: 0,
          duration: 3,
          text: 'SEC',
          onComplete: onCallback,
        ),
      ),
    );

    await tester.pump(const Duration(seconds: 4));
    expect(onCallbackCalled, isTrue);
  });
}
