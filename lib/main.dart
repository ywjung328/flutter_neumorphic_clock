import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  double elevation = 3.0;
  double size = 72.0;

  late AnimationController _controller;
  late Animation _animation;

  late Timer _timer;
  late DateTime dateTime;

  int h1 = 0;
  int h2 = 0;
  int m1 = 0;
  int m2 = 0;
  int s1 = 0;
  int s2 = 0;

  bool subscribeH1 = false;
  bool subscribeH2 = false;
  bool subscribeM1 = false;
  bool subscribeM2 = false;
  bool subscribeS1 = false;
  bool subscribeS2 = false;

  double elevH1 = 3.0;
  double elevH2 = 3.0;
  double elevM1 = 3.0;
  double elevM2 = 3.0;
  double elevS1 = 3.0;
  double elevS2 = 3.0;

  setTime(Timer timer) async {
    dateTime = DateTime.now();

    subscribeH1 = h1 != dateTime.hour ~/ 10;
    subscribeH2 = h2 != dateTime.hour % 10;
    subscribeM1 = m1 != dateTime.minute ~/ 10;
    subscribeM2 = m2 != dateTime.minute % 10;
    subscribeS1 = s1 != dateTime.second ~/ 10;
    subscribeS2 = s2 != dateTime.second % 10;

    await _controller.forward();

    h1 = dateTime.hour ~/ 10;
    h2 = dateTime.hour % 10;
    m1 = dateTime.minute ~/ 10;
    m2 = dateTime.minute % 10;
    s1 = dateTime.second ~/ 10;
    s2 = dateTime.second % 10;

    await _controller.reverse();
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 250), vsync: this);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        dateTime = DateTime.now();

        s1 = dateTime.second ~/ 10;
        s2 = dateTime.second % 10;
      }
    });

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _animation.addListener(() {
      setState(() {});
    });

    dateTime = DateTime.now();
    _timer = Timer.periodic(const Duration(milliseconds: 1000), setTime);

    h1 = dateTime.hour ~/ 10;
    h2 = dateTime.hour % 10;
    m1 = dateTime.minute ~/ 10;
    m2 = dateTime.minute % 10;
    s1 = dateTime.second ~/ 10;
    s2 = dateTime.second % 10;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: size / 8 * 5,
              child: Center(
                child: Text(
                  "$s1",
                  style: TextStyle(
                    fontFamily: 'NanumSquareRound',
                    fontWeight: FontWeight.w700,
                    fontSize: size,
                    color: Colors.grey.shade200,
                    shadows: [
                      Shadow(
                        color: Colors.grey.shade500,
                        offset: Offset(elevation, elevation) *
                            (subscribeS1 ? 1.0 - _animation.value : 1.0),
                        blurRadius: elevation *
                            10 /
                            3 *
                            (subscribeS1 ? 1.0 - _animation.value : 1.0),
                      ),
                      Shadow(
                        color: Colors.white,
                        offset: Offset(-elevation, -elevation) *
                            (subscribeS1 ? 1.0 - _animation.value : 1.0),
                        blurRadius: elevation *
                            10 /
                            3 *
                            (subscribeS1 ? 1.0 - _animation.value : 1.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: size / 8 * 5,
              child: Center(
                child: Text(
                  "$s2",
                  style: TextStyle(
                    fontFamily: 'NanumSquareRound',
                    fontWeight: FontWeight.w700,
                    fontSize: size,
                    color: Colors.grey.shade200,
                    shadows: [
                      Shadow(
                        color: Colors.grey.shade500,
                        offset: Offset(elevation, elevation) *
                            (subscribeS2 ? 1.0 - _animation.value : 1.0),
                        blurRadius: elevation *
                            10 /
                            3 *
                            (subscribeS2 ? 1.0 - _animation.value : 1.0),
                      ),
                      Shadow(
                        color: Colors.white,
                        offset: Offset(-elevation, -elevation) *
                            (subscribeS2 ? 1.0 - _animation.value : 1.0),
                        blurRadius: elevation *
                            10 /
                            3 *
                            (subscribeS2 ? 1.0 - _animation.value : 1.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
