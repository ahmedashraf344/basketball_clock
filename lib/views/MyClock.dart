import 'dart:async';
import 'package:basketball_clock/widgets/FlareAnimator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MyClock extends StatefulWidget {
  @override
  _MyClcokState createState() => _MyClcokState();
}

class _MyClcokState extends State<MyClock> with TickerProviderStateMixin {
  DateTime _dateTime = DateTime.now();
  AnimationController xController;
  Animation<Offset> xSlideAnimation;
  Animation<double> xFadeAnimation;
  bool isNight = false;

  void _updateTime() {
    setState(() {
      _dateTime = DateTime.now();
      Timer(
        Duration(seconds: 1),
        _updateTime,
      );
      xController.repeat();
    });
  }

  @override
  void initState() {
    // To Change The sun icon to cloud icon
    DateTime now = DateTime.now();
    if (now.hour > 16) {
      isNight = true;
    } else {
      isNight = false;
    }
    xController =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    xSlideAnimation = Tween<Offset>(begin: Offset(0.1, 0.6), end: Offset.zero)
        .animate(xController);
    xFadeAnimation =
        CurvedAnimation(parent: xController, curve: Curves.easeOut);
    super.initState();
    _updateTime();
  }

  @override
  Widget build(BuildContext context) {
    final day = DateFormat('EEEE').format(_dateTime);
    final hour = DateFormat('Hm').format(_dateTime);
    return Scaffold(
      backgroundColor: Color(
        0xff4A4260,
      ),
      body: SafeArea(
        child: Center(
          child: AspectRatio(
            aspectRatio: 5 / 3,
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    "assets/basketarea.png",
                  ),
                ),
              ),
              child: Row(
                children: <Widget>[
                  xTime(day, hour),
                  Spacer(),
                  xSeconds(),
                  Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column xSeconds() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FadeTransition(
          opacity: xFadeAnimation,
          child: SlideTransition(
            position: xSlideAnimation,
            child: Text(
              "${_dateTime.second}",
              style: GoogleFonts.titilliumWeb(
                fontWeight: FontWeight.bold,
                textStyle: TextStyle(
                  color: Colors.white.withOpacity(
                    0.8,
                  ),
                  fontSize: 45,
                ),
              ),
            ),
          ),
        ),
        FlareAnimator(
          height: 300,
          fit: BoxFit.cover,
          file: "assets/ball.flr",
          animation: "Untitled",
        ),
      ],
    );
  }

  Align xTime(String day, String hour) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 45,
          left: 30,
        ),
        child: FittedBox(
          child: Container(
            padding: EdgeInsets.all(
              5,
            ),
            decoration: BoxDecoration(
              color: Color(
                0xffE77749,
              ),
              border: Border.all(
                color: Colors.white,
                width: 10,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(
                  25,
                ),
              ),
            ),
            child: Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 7,
                      ),
                      child: Text(
                        day,
                        style: GoogleFonts.titilliumWeb(
                          fontWeight: FontWeight.bold,
                          textStyle: TextStyle(
                            color: Colors.white.withOpacity(
                              0.8,
                            ),
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      hour,
                      style: GoogleFonts.titilliumWeb(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        textStyle: TextStyle(
                          color: Colors.white,
                          letterSpacing: 10,
                        ),
                      ),
                    ),
                  ],
                ),
                FlareAnimator(
                  color: isNight ? null : Colors.yellow,
                  fit: BoxFit.cover,
                  file: isNight ? "assets/cloudynight.flr" : "assets/sun.flr",
                  animation: "go",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
