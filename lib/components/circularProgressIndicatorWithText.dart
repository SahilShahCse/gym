import 'dart:math';

import 'package:flutter/material.dart';

class CircularProgressWithText extends StatelessWidget {
  final double percentage;
  final String text;

  const CircularProgressWithText(this.percentage, this.text ,{super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CircularProgressPainter(percentage),
      child: Container(
        width: 100,
        height: 100,
        alignment: Alignment.center,
        child: OutlinedText(text),
      ),
    );
  }
}

class _CircularProgressPainter extends CustomPainter {
  final double percentage;

  _CircularProgressPainter(this.percentage);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 10
      ..color = Colors.black12
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);

    canvas.drawCircle(center, radius, paint);

    final progressPaint = Paint()
      ..strokeWidth = 10
      ..color = Colors.purple
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    double arcAngle = 2 * pi * (percentage / 100);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        arcAngle, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class OutlinedText extends StatelessWidget {
  final String text;

  const OutlinedText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Colors.black.withOpacity(0.5);

    return Stack(
      alignment: Alignment.center,
      children: [
        Text(text , style: TextStyle(fontWeight: FontWeight.w500 , fontSize: 14),),
      ],
    );
  }
}