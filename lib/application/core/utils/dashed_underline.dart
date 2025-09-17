import 'package:flutter/material.dart';

class DottedLine extends StatelessWidget {
  final Axis axis;
  final double length; // if null will expand
  final double dashLength;
  final double dashGap;
  final double strokeWidth;
  final Color color;

  const DottedLine({
    Key? key,
    this.axis = Axis.horizontal,
    this.length = double.infinity,
    this.dashLength = 4.0,
    this.dashGap = 4.0,
    this.strokeWidth = 1.0,
    this.color = Colors.black54,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: axis == Axis.horizontal ? length : strokeWidth,
      height: 1,
      child: CustomPaint(
        painter: _DottedLinePainter(
          axis: axis,
          dashLength: dashLength,
          dashGap: dashGap,
          strokeWidth: strokeWidth,
          color: color,
        ),
      ),
    );
  }
}

class _DottedLinePainter extends CustomPainter {
  final Axis axis;
  final double dashLength;
  final double dashGap;
  final double strokeWidth;
  final Color color;

  _DottedLinePainter({
    required this.axis,
    required this.dashLength,
    required this.dashGap,
    required this.strokeWidth,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final isHorizontal = axis == Axis.horizontal;
    final total = isHorizontal ? size.width : size.height;
    double start = 0.0;

    while (start < total) {
      final end = (start + dashLength).clamp(0.0, total);
      if (isHorizontal) {
        canvas.drawLine(Offset(start, size.height / 2),
                        Offset(end, size.height / 2),
                        paint);
      } else {
        canvas.drawLine(Offset(size.width / 2, start),
                        Offset(size.width / 2, end),
                        paint);
      }
      start += dashLength + dashGap;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
