import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../core/app_colors.dart';

class PlantBuddy extends StatelessWidget {
  const PlantBuddy({
    required this.stage,
    this.size = 164,
    super.key,
  });

  /// Daily growth stage: 0 = small sprout, 1 = bigger sprout,
  /// 2 = bloom stage, 3 = leafy stage. The last two are intentionally
  /// swapped compared with the uploaded plant reference so it matches the mockups.
  final int stage;
  final double size;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 420),
      switchInCurve: Curves.easeOutBack,
      switchOutCurve: Curves.easeIn,
      transitionBuilder: (child, animation) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.92, end: 1).animate(animation),
          child: FadeTransition(opacity: animation, child: child),
        );
      },
      child: CustomPaint(
        key: ValueKey(stage),
        painter: _CutePlantPainter(stage: stage.clamp(0, 3).toInt()),
        child: SizedBox(width: size, height: size * 1.26),
      ),
    );
  }
}

class _CutePlantPainter extends CustomPainter {
  const _CutePlantPainter({required this.stage});

  final int stage;

  static const _potTop = Color(0xFFEF9AA9);
  static const _potBody = Color(0xFFE08AA0);
  static const _potBodyDark = Color(0xFFCC7187);
  static const _leaf = Color(0xFFA8E6B4);
  static const _leafDark = Color(0xFF56B87C);
  static const _stem = Color(0xFF4FAF74);
  static const _face = Color(0xFF4A3340);
  static const _flower = Color(0xFFFF8FBB);
  static const _flowerLight = Color(0xFFFFD6E6);

  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / 164;
    canvas.save();
    canvas.scale(scale, scale);

    final w = size.width / scale;
    final h = size.height / scale;
    final cx = w / 2;
    final potTopY = h - 77;

    _drawGroundShadow(canvas, cx, h);

    final mappedStage = switch (stage) {
      0 => 1,
      1 => 2,
      2 => 4,
      _ => 3,
    };

    if (mappedStage == 1) {
      _drawStageOne(canvas, cx, potTopY);
    } else if (mappedStage == 2) {
      _drawStageTwo(canvas, cx, potTopY);
    } else if (mappedStage == 3) {
      _drawStageThree(canvas, cx, potTopY);
    } else {
      _drawStageFour(canvas, cx, potTopY);
    }

    _drawPot(canvas, cx, h);
    canvas.restore();
  }

  void _drawGroundShadow(Canvas canvas, double cx, double h) {
    final shadowPaint = Paint()
      ..shader = RadialGradient(
        colors: [Colors.black.withOpacity(0.13), Colors.transparent],
      ).createShader(Rect.fromCenter(center: Offset(cx, h - 12), width: 132, height: 24));
    canvas.drawOval(Rect.fromCenter(center: Offset(cx, h - 12), width: 132, height: 22), shadowPaint);
  }

  void _drawStageOne(Canvas canvas, double cx, double potTopY) {
    final bottom = potTopY + 2;
    final top = bottom - 31;
    _drawStem(canvas, Offset(cx, bottom), Offset(cx, top), width: 7);
    _drawLeaf(canvas, Offset(cx, top + 8), 32, 22, left: true);
    _drawLeaf(canvas, Offset(cx, top + 8), 32, 22, left: false);
    _drawSmallLeaf(canvas, Offset(cx, top - 2), 8, 18);
  }

  void _drawStageTwo(Canvas canvas, double cx, double potTopY) {
    final bottom = potTopY + 3;
    final top = bottom - 68;
    _drawStem(canvas, Offset(cx, bottom), Offset(cx, top), width: 9);
    _drawLeaf(canvas, Offset(cx, top + 42), 48, 30, left: true);
    _drawLeaf(canvas, Offset(cx, top + 42), 48, 30, left: false);
    _drawTopOvalLeaf(canvas, Offset(cx, top + 10), 42, 54);
  }

  void _drawStageThree(Canvas canvas, double cx, double potTopY) {
    final bottom = potTopY + 4;
    final top = bottom - 94;
    _drawStem(canvas, Offset(cx, bottom), Offset(cx, top), width: 9);
    _drawLeaf(canvas, Offset(cx, bottom - 18), 48, 30, left: true, angleOffset: -0.08);
    _drawLeaf(canvas, Offset(cx, bottom - 18), 48, 30, left: false, angleOffset: 0.08);
    _drawLeaf(canvas, Offset(cx, bottom - 49), 42, 27, left: true);
    _drawLeaf(canvas, Offset(cx, bottom - 49), 42, 27, left: false);
    _drawLeaf(canvas, Offset(cx, bottom - 74), 36, 24, left: true);
    _drawLeaf(canvas, Offset(cx, bottom - 74), 36, 24, left: false);
    _drawTopOvalLeaf(canvas, Offset(cx, top + 7), 36, 46);
  }

  void _drawStageFour(Canvas canvas, double cx, double potTopY) {
    final bottom = potTopY + 4;
    final top = bottom - 98;
    _drawStem(canvas, Offset(cx, bottom), Offset(cx, top), width: 9);
    _drawLeaf(canvas, Offset(cx, bottom - 30), 51, 32, left: true);
    _drawLeaf(canvas, Offset(cx, bottom - 30), 51, 32, left: false);
    _drawLeaf(canvas, Offset(cx, bottom - 68), 38, 25, left: true);
    _drawLeaf(canvas, Offset(cx, bottom - 68), 38, 25, left: false);

    _drawFlower(canvas, Offset(cx - 48, top + 6), 13);
    _drawFlower(canvas, Offset(cx + 48, top + 6), 13);
    _drawFlower(canvas, Offset(cx, top - 20), 15);
  }

  void _drawStem(Canvas canvas, Offset from, Offset to, {required double width}) {
    final paint = Paint()
      ..shader = const LinearGradient(colors: [_leaf, _stem]).createShader(Rect.fromPoints(from, to))
      ..strokeWidth = width
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(from, to, paint);
  }

  void _drawLeaf(Canvas canvas, Offset origin, double width, double height, {required bool left, double angleOffset = 0}) {
    final direction = left ? -1.0 : 1.0;
    final path = Path()
      ..moveTo(origin.dx, origin.dy)
      ..cubicTo(
        origin.dx + direction * width * 0.45,
        origin.dy - height * 0.95,
        origin.dx + direction * width * 1.06,
        origin.dy - height * 0.45,
        origin.dx + direction * width * 1.18,
        origin.dy + height * 0.2,
      )
      ..cubicTo(
        origin.dx + direction * width * 0.5,
        origin.dy + height * 0.58,
        origin.dx + direction * width * 0.12,
        origin.dy + height * 0.36,
        origin.dx,
        origin.dy,
      );

    final bounds = path.getBounds().inflate(6);
    final paint = Paint()
      ..shader = LinearGradient(
        colors: left ? const [_leaf, _leafDark] : const [_leaf, _leafDark],
        begin: left ? Alignment.topLeft : Alignment.topRight,
        end: left ? Alignment.bottomRight : Alignment.bottomLeft,
      ).createShader(bounds);

    canvas.save();
    canvas.translate(origin.dx, origin.dy);
    canvas.rotate((left ? -0.02 : 0.02) + angleOffset);
    canvas.translate(-origin.dx, -origin.dy);
    canvas.drawPath(path, paint);

    final vein = Paint()
      ..color = Colors.white.withOpacity(0.35)
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(origin.dx + direction * width * 0.18, origin.dy - height * 0.08),
      Offset(origin.dx + direction * width * 0.76, origin.dy - height * 0.17),
      vein,
    );
    canvas.restore();
  }

  void _drawSmallLeaf(Canvas canvas, Offset top, double width, double height) {
    final rect = Rect.fromCenter(center: top, width: width, height: height);
    final paint = Paint()..color = const Color(0xFFB6EDC1);
    canvas.drawRRect(RRect.fromRectAndRadius(rect, const Radius.circular(8)), paint);
  }

  void _drawTopOvalLeaf(Canvas canvas, Offset center, double width, double height) {
    final rect = Rect.fromCenter(center: center, width: width, height: height);
    final path = Path()
      ..addOval(rect)
      ..close();
    final paint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFB6EDC1), _leafDark],
      ).createShader(rect);
    canvas.drawPath(path, paint);
    canvas.drawLine(
      Offset(center.dx, center.dy - height * 0.25),
      Offset(center.dx, center.dy + height * 0.28),
      Paint()
        ..color = Colors.white.withOpacity(0.35)
        ..strokeWidth = 4
        ..strokeCap = StrokeCap.round,
    );
  }

  void _drawFlower(Canvas canvas, Offset center, double radius) {
    final petalPaint = Paint()
      ..shader = RadialGradient(colors: const [_flowerLight, _flower]).createShader(
        Rect.fromCircle(center: center, radius: radius * 1.5),
      );
    for (var i = 0; i < 6; i++) {
      final angle = math.pi * 2 * i / 6;
      final petalCenter = center + Offset(math.cos(angle), math.sin(angle)) * radius * 0.72;
      canvas.drawCircle(petalCenter, radius * 0.46, petalPaint);
    }
    canvas.drawCircle(center, radius * 0.42, Paint()..color = AppColors.accentYellow);
  }

  void _drawPot(Canvas canvas, double cx, double h) {
    final topRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(cx, h - 71), width: 128, height: 30),
      const Radius.circular(15),
    );
    final topPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [_potTop, Color(0xFFDD8094)],
      ).createShader(topRect.outerRect);
    canvas.drawRRect(topRect, topPaint);

    final potPath = Path()
      ..moveTo(cx - 54, h - 58)
      ..lineTo(cx + 54, h - 58)
      ..lineTo(cx + 42, h - 4)
      ..lineTo(cx - 42, h - 4)
      ..close();
    final potPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [_potBody, _potBodyDark],
      ).createShader(Rect.fromLTWH(cx - 56, h - 58, 112, 54));
    canvas.drawPath(potPath, potPaint);

    final highlight = Paint()..color = Colors.white.withOpacity(0.17);
    canvas.drawPath(
      Path()
        ..moveTo(cx - 42, h - 55)
        ..lineTo(cx - 20, h - 55)
        ..lineTo(cx - 27, h - 6)
        ..lineTo(cx - 46, h - 6)
        ..close(),
      highlight,
    );

    final blush = Paint()
      ..color = const Color(0xFFFF7FB0).withOpacity(0.42)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 0.5);
    canvas.drawOval(Rect.fromCenter(center: Offset(cx - 39, h - 34), width: 22, height: 13), blush);
    canvas.drawOval(Rect.fromCenter(center: Offset(cx + 39, h - 34), width: 22, height: 13), blush);

    final eyePaint = Paint()..color = _face;
    final shinePaint = Paint()..color = Colors.white.withOpacity(0.92);
    canvas.drawOval(Rect.fromCenter(center: Offset(cx - 22, h - 38), width: 18, height: 23), eyePaint);
    canvas.drawOval(Rect.fromCenter(center: Offset(cx + 22, h - 38), width: 18, height: 23), eyePaint);
    canvas.drawCircle(Offset(cx - 19, h - 42), 3.2, shinePaint);
    canvas.drawCircle(Offset(cx + 25, h - 42), 3.2, shinePaint);

    final mouth = Path()
      ..moveTo(cx - 14, h - 24)
      ..quadraticBezierTo(cx, h - 9, cx + 14, h - 24)
      ..quadraticBezierTo(cx, h - 15, cx - 14, h - 24)
      ..close();
    canvas.drawPath(mouth, Paint()..color = const Color(0xFF5A2F3E));
    canvas.drawOval(Rect.fromCenter(center: Offset(cx, h - 17), width: 14, height: 8), Paint()..color = const Color(0xFFFF7FA8));
  }

  @override
  bool shouldRepaint(covariant _CutePlantPainter oldDelegate) => oldDelegate.stage != stage;
}
