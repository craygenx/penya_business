import 'package:flutter/material.dart';

class StackedBlockChart extends StatelessWidget {
  const StackedBlockChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stacked Block Chart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomPaint(
          size: Size(double.infinity, 400),
          painter: BlockChartPainter(),
        ),
      ),
    );
  }
}

class BlockChartPainter extends CustomPainter {
  final List<String> xLabels = ['1 Oct', '9 Oct', '16 Oct', '23 Oct', '31 Oct', '6 Nov'];
  final List<List<double>> data = [
    [309200, 200000, 100000, 0],
    [400000, 187120, 50000, 0],
    [500000, 50000, 20000, 37000],
    [300000, 120000, 79800, 0],
    [250000, 150000, 67890, 10000],
    [467890, 100000, 0, 50000],
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    final double maxY = 600000; // Maximum value for the y-axis
    final double blockWidth = size.width / (data.length * 1.5);
    final double chartHeight = size.height - 50; // Space for x-axis labels
    final colors = [Colors.purple, Colors.amber, Colors.cyan, Colors.blue];

    for (int i = 0; i < data.length; i++) {
      double startX = i * blockWidth * 1.5 + blockWidth / 2;
      double startY = size.height - 20;

      for (int j = 0; j < data[i].length; j++) {
        if (data[i][j] == 0) continue; // Skip empty blocks
        double blockHeight = (data[i][j] / maxY) * chartHeight;

        paint.color = colors[j].withOpacity(1 - (j * 0.2)); // Fading effect
        canvas.drawRect(
          Rect.fromLTWH(startX, startY - blockHeight, blockWidth, blockHeight),
          paint,
        );

        startY -= blockHeight; // Adjust for the next block
      }

      // Draw x-axis labels
      textPainter.text = TextSpan(
        text: xLabels[i],
        style: TextStyle(color: Colors.black, fontSize: 12),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(startX + blockWidth / 4 - textPainter.width / 2, size.height - 20),
      );
    }

    // Draw y-axis grid lines and labels
    final int gridCount = 6;
    for (int i = 0; i <= gridCount; i++) {
      double gridY = chartHeight * (1 - i / gridCount);

      // Horizontal grid line
      paint.color = Colors.grey.withOpacity(0.5);
      paint.strokeWidth = 1;
      canvas.drawLine(Offset(0, gridY), Offset(size.width, gridY), paint);

      // Y-axis label
      double value = (maxY / gridCount) * i;
      textPainter.text = TextSpan(
        text: '${(value / 1000).toStringAsFixed(1)}k',
        style: TextStyle(color: Colors.black, fontSize: 12),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(0, gridY - textPainter.height / 2));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
