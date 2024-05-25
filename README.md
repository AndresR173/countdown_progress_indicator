# Countdown Progress Indicator

![](https://badges.fyi/github/latest-tag/AndresR173/countdown_progress_indicator)
![](https://badges.fyi/github/stars/AndresR173/countdown_progress_indicator)
![](https://badges.fyi/github/license/AndresR173/countdown_progress_indicator)

Customizable countdown timer for Flutter

## Getting Started

To use this package, add `countdown_progress_indicador` as a dependency in your `pubspec.yaml` file.

```yaml
dependencies:
	...
	countdown_progress_indicador: ^0.1.3
```

## How to use

In your project add the following import:

```dart
import  'package:countdown_progress_indicator/countdown_progress_indicator.dart';
```

This widget starts the countdown automatically by default and supports pause and resume actions.
If you want to support these actions, implement a `CountdownController` as the example above:

```dart
SizedBox(
	height:  200,
	width:  200,
	child:  CountDownProgressIndicator(
		controller: _controller,
		valueColor:  Colors.red,
		backgroundColor:  Colors.blue,
		initialPosition:  0,
		duration:  20,
		text:  'SEC',
		onComplete: () =>  null,
	),
),
```

## Custom Formatter

If you want to show a text different than the time in seconds, you can implement a custom time formatter.

```dart
CountDownProgressIndicator(
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
```

# Countdown

![countdown](https://github.com/AndresR173/countdown_progress_indicator/blob/main/src/img/countdown.gif)
