import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class FlareAnimator extends StatelessWidget {
  final String file,animation;
  final Alignment alignment;
  final BoxFit fit;
  final Color color;
  final Function callback;
  final double width , height;

  FlareAnimator({
    @required this.file,
    @required this.animation,
    this.alignment = Alignment.center,
    this.fit = BoxFit.contain,
    this.callback,
    this.color,
    this.width = 100,
    this.height = 100,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: FlareActor(
        file,
        alignment: alignment,
        fit: fit,
        animation: animation,
        callback: callback,
        color: color,
      ),
    );
  }
}
