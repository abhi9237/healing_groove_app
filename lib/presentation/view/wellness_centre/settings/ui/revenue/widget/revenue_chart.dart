import 'package:flutter/material.dart';
import 'package:healing/core/color_constant/color_constant.dart';

class RevenueChart extends StatelessWidget {
  final List<String> xLabels;
  final List<double> values;

  const RevenueChart({
    super.key,
    required this.xLabels,
    required this.values,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      width: double.infinity,
      child: CustomPaint(
        painter: _ChartPainter(xLabels: xLabels, values: values),
      ),
    );
  }
}

class _ChartPainter extends CustomPainter {
  final List<String> xLabels;
  final List<double> values;

  _ChartPainter({required this.xLabels, required this.values});

  @override
  void paint(Canvas canvas, Size size) {
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    const double leftPadding = 35.0;
    const double bottomPadding = 30.0;
    final double graphWidth = size.width - leftPadding - 10;
    final double graphHeight = size.height - bottomPadding - 10;

    double maxValue = values.fold<double>(0.0, (max, val) => val > max ? val : max);
    if (maxValue < 1000.0) maxValue = 1000.0; // Avoid division by zero/small scale

    // Round maxValue up to a nice number
    final double stepVal = maxValue / 9;

    // 1. Draw grid lines and Y-axis labels
    final paintGrid = Paint()
      ..color = const Color(0xFFF1F5F9)
      ..strokeWidth = 1.0;

    for (int i = 0; i < 10; i++) {
      final double y = graphHeight - (i * (graphHeight / 9)) + 10;
      
      // Draw grid line
      canvas.drawLine(Offset(leftPadding, y), Offset(size.width - 10, y), paintGrid);

      // Draw label text
      final double val = stepVal * i;
      final String label = val >= 1000 
          ? '${(val / 1000).toStringAsFixed(1)}k'.replaceAll('.0k', 'k')
          : val.toStringAsFixed(0);

      textPainter.text = TextSpan(
        text: label,
        style: const TextStyle(
          fontFamily: 'Afacad',
          fontSize: 10,
          color: Colors.grey,
        ),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(5, y - textPainter.height / 2));
    }

    // 2. Draw X-axis labels
    final double stepX = graphWidth / (xLabels.length - 1);
    final List<Offset> points = [];

    for (int i = 0; i < xLabels.length; i++) {
      final double x = leftPadding + (i * stepX);
      
      // Draw label text
      textPainter.text = TextSpan(
        text: xLabels[i],
        style: const TextStyle(
          fontFamily: 'Afacad',
          fontSize: 11,
          color: Colors.grey,
        ),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(x - textPainter.width / 2, size.height - bottomPadding + 8));

      // Calculate chart point
      final double ratio = values[i] / maxValue;
      final double y = graphHeight - (ratio * graphHeight) + 10;
      points.add(Offset(x, y));
    }

    // 3. Draw gradient fill under the line chart curve
    final pathFill = Path();
    pathFill.moveTo(leftPadding, graphHeight + 10);
    pathFill.lineTo(points.first.dx, points.first.dy);

    for (int i = 0; i < points.length - 1; i++) {
      final p1 = points[i];
      final p2 = points[i + 1];
      final controlX = (p1.dx + p2.dx) / 2;
      pathFill.cubicTo(controlX, p1.dy, controlX, p2.dy, p2.dx, p2.dy);
    }
    
    pathFill.lineTo(points.last.dx, graphHeight + 10);
    pathFill.close();

    final paintGradient = Paint()
      ..shader = const LinearGradient(
        colors: [
          Color(0x50007A48), // Transparent green
          Color(0x05007A48),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTRB(leftPadding, 10, size.width, graphHeight + 10));

    canvas.drawPath(pathFill, paintGradient);

    // 4. Draw curve line chart
    final pathLine = Path();
    pathLine.moveTo(points.first.dx, points.first.dy);
    for (int i = 0; i < points.length - 1; i++) {
      final p1 = points[i];
      final p2 = points[i + 1];
      final controlX = (p1.dx + p2.dx) / 2;
      pathLine.cubicTo(controlX, p1.dy, controlX, p2.dy, p2.dx, p2.dy);
    }

    final paintLine = Paint()
      ..color = ColorConstant.appColor
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(pathLine, paintLine);

    // 5. Draw data point dots
    final paintDotOuter = Paint()
      ..color = ColorConstant.appColor
      ..style = PaintingStyle.fill;
    final paintDotInner = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    for (int i = 0; i < points.length; i++) {
      canvas.drawCircle(points[i], 5.0, paintDotOuter);
      canvas.drawCircle(points[i], 2.5, paintDotInner);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
