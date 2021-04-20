import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

enum CircleAlignment {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
}

class QuarterCircle extends StatelessWidget {
  final CircleAlignment circleAlignment;
  final Color color;
  final String imgUrl;

  const QuarterCircle({
    this.imgUrl,
    this.color = Colors.grey,
    this.circleAlignment = CircleAlignment.bottomRight,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: ClipRect(
        child: Container(
          child: Align(
            alignment: Alignment.bottomLeft,
            widthFactor: 1.4,
            heightFactor: 9.0,
            child: CustomPaint(
              size: Size.fromHeight(130),
              painter: QuarterCirclePainter(
                circleAlignment: circleAlignment,
                color: color,
              ),
              child: ClipRect(
                  child: Image.network(
                imgUrl,
              )),
              isComplex: false,
            ),
          ),
        ),
      ),
    );
  }
}

class QuarterCirclePainter extends CustomPainter {
  final CircleAlignment circleAlignment;
  final Color color;

  const QuarterCirclePainter({this.circleAlignment, this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final radius = math.min(size.height, size.width);
    final offset = circleAlignment == CircleAlignment.topRight
        ? Offset(.0, .0)
        : circleAlignment == CircleAlignment.topRight
            ? Offset(size.width, .0)
            : circleAlignment == CircleAlignment.bottomRight
                ? Offset(.0, size.height)
                : Offset(size.width, size.height);
    canvas.drawCircle(offset, radius, Paint()..color = color);
  }

  @override
  bool shouldRepaint(QuarterCirclePainter oldDelegate) {
    return color == oldDelegate.color &&
        circleAlignment == oldDelegate.circleAlignment;
  }
}
