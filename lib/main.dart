import 'package:basketball_clock/views/MyClock.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //To Hide StatusBar and keys
    SystemChrome.setEnabledSystemUIOverlays([]);
    //To force device to landscape mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return MaterialApp(
      title: "basketball clock",
      debugShowCheckedModeBanner: false,
      home: MyClock(),
    );
  }
}
