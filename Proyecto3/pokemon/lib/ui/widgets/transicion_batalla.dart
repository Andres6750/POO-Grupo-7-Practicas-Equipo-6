import 'package:flutter/material.dart';

class TransicionBatalla extends StatefulWidget {
  final VoidCallback onFinish;

  const TransicionBatalla({super.key, required this.onFinish});

  @override
  State<TransicionBatalla> createState() => _TransicionBatallaState();
}

class _TransicionBatallaState extends State<TransicionBatalla>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _anim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(curve: Curves.easeInOut, parent: _controller)
    );

    _controller.forward();

    Future.delayed(const Duration(milliseconds: 700), () {
      widget.onFinish();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) {
        return CustomPaint(
          painter: _TransicionPainter(_anim.value),
          child: Container(),
        );
      },
    );
  }
}

class _TransicionPainter extends CustomPainter {
  final double v;
  _TransicionPainter(this.v);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black;
    final barras = 12;
    final h = size.height / barras;

    for (int i = 0; i < barras; i++) {
      final dy = i * h;
      final ancho = size.width * v;
      canvas.drawRect(Rect.fromLTWH(0, dy, ancho, h), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _TransicionPainter old) => true;
}
