import 'package:flutter/material.dart';

class WaveContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path_0 = Path();
    path_0.moveTo(size.width, size.height * 0.0980000);
    path_0.cubicTo(
        size.width * 0.9405000,
        size.height * 0.1710000,
        size.width * 0.9210000,
        size.height * 0.2090000,
        size.width * 0.7940000,
        size.height * 0.2188000);
    path_0.cubicTo(
        size.width * 0.6680000,
        size.height * 0.2146000,
        size.width * 0.6260000,
        size.height * 0.1626000,
        size.width * 0.5280000,
        size.height * 0.1572000);
    path_0.cubicTo(
        size.width * 0.3881250,
        size.height * 0.1504000,
        size.width * 0.1683750,
        size.height * 0.3144000,
        size.width * 0.0865000,
        size.height * 0.3092000);
    path_0.cubicTo(
        size.width * 0.0098750,
        size.height * 0.2956000,
        size.width * 0.0386250,
        size.height * 0.2956000,
        0,
        size.height * 0.2824000);
    path_0.quadraticBezierTo(
        size.width * -0.0080000, size.height * 0.4295000, 0, size.height);
    path_0.lineTo(size.width, size.height);
    path_0.quadraticBezierTo(size.width, size.height * 0.7745000, size.width,
        size.height * 0.0980000);
    path_0.close();

    canvas.drawPath(path_0, paint_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class SecondWaveContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..color = Color(0xFF04BAF8).withOpacity(.4)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path_0 = Path();
    path_0.moveTo(size.width, 0);
    path_0.lineTo(0, 0);
    path_0.quadraticBezierTo(
        0, size.height * 0.2550000, 0, size.height * 0.3960000);
    path_0.cubicTo(
        size.width * 0.0490000,
        size.height * 0.3845000,
        size.width * 0.0490000,
        size.height * 0.3183000,
        size.width * 0.1300000,
        size.height * 0.3132000);
    path_0.cubicTo(
        size.width * 0.2127500,
        size.height * 0.3151000,
        size.width * 0.1842500,
        size.height * 0.3973000,
        size.width * 0.2890000,
        size.height * 0.4000000);
    path_0.cubicTo(
        size.width * 0.4052500,
        size.height * 0.3797000,
        size.width * 0.3382500,
        size.height * 0.3219000,
        size.width * 0.4320000,
        size.height * 0.3116000);
    path_0.cubicTo(
        size.width * 0.5318750,
        size.height * 0.3107000,
        size.width * 0.5156250,
        size.height * 0.3913000,
        size.width * 0.6080000,
        size.height * 0.4004000);
    path_0.cubicTo(
        size.width * 0.7048750,
        size.height * 0.3877000,
        size.width * 0.6596250,
        size.height * 0.3263000,
        size.width * 0.7430000,
        size.height * 0.3136000);
    path_0.cubicTo(
        size.width * 0.8230000,
        size.height * 0.3183000,
        size.width * 0.8038250,
        size.height * 0.4030600,
        size.width * 0.9017000,
        size.height * 0.3987600);
    path_0.cubicTo(
        size.width * 1.0179750,
        size.height * 0.3543000,
        size.width * 1.0038500,
        size.height * 0.2871400,
        size.width,
        size.height * 0.4008600);
    path_0.quadraticBezierTo(
        size.width * 1.0112000, size.height * 0.3278200, size.width, 0);
    path_0.close();

    canvas.drawPath(path_0, paint_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
