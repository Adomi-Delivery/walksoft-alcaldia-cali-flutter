import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:walksoft_alcaldia_cali_flutter/src/model/project.dart';

class MarkerPhotoProject extends CustomPainter {
  final Project p;
  ui.Image image;

  MarkerPhotoProject(this.p, this.image);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(50, 50);
    final radius = 45.0;

    // The circle should be paint before or it will be hidden by the path
    Paint paintCircle = Paint()..color = Colors.black;
    Paint paintBorder = Paint()
      ..color = Colors.white
      ..strokeWidth = size.width / 36
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius, paintCircle);
    canvas.drawCircle(center, radius, paintBorder);

    var drawImageWidth = 0.0;
    var drawImageHeight = -size.height * 0.8;

    Path path = Path()
      ..addOval(Rect.fromLTWH(drawImageWidth, drawImageHeight,
          image.width.toDouble(), image.height.toDouble()));

    canvas.clipPath(path);

    canvas.drawImage(
        image, new Offset(drawImageWidth, drawImageHeight), new Paint());
  }

  @override
  bool shouldRepaint(MarkerPhotoProject oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(MarkerPhotoProject oldDelegate) => false;
}
