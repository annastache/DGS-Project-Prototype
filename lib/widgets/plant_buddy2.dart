import 'dart:math' as math;
 
import 'package:flutter/material.dart';
 import "package:flutter/foundation.dart";
import '../core/app_colors.dart';

 
class PlantBuddy extends StatefulWidget {
  const PlantBuddy({
    required this.stage,
    this.size = 164,
    super.key,
  });
 
  final int stage;
  final double size;
 
  @override
  State<PlantBuddy> createState() => _PlantBuddyState();
}
 
class _PlantBuddyState extends State<PlantBuddy> with TickerProviderStateMixin {
  late int _displayedStage;
  late AnimationController _blinkController;
  late Animation<double> _blinkAnimation;
  late AnimationController _swayController;
  late Animation<double> _swayAnimation;
  bool _showHearts = false;
   List<int> _tapHearts = [];
  int _tapId = 0;

  @override
  void initState() {
    super.initState();
    _displayedStage = widget.stage;

    _blinkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    _blinkAnimation = Tween<double>(begin: 1.0, end: 0.08).animate(
      CurvedAnimation(parent: _blinkController, curve: Curves.easeInOut),
    );

    _swayController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3500),
    )..repeat(reverse: true);

    _swayAnimation = Tween<double>(begin: -0.06, end: 0.06).animate(
      CurvedAnimation(parent: _swayController, curve: Curves.easeInOut),
    );

    _scheduleBlink();
    
  }
 
  void _scheduleBlink() async {
    final random = math.Random();
    while (mounted) {
      final delay = 10000 + random.nextInt(20001); // random between 5000ms and 15000ms
      await Future.delayed(Duration(milliseconds: delay));
      if (!mounted) break;
      await _blinkController.forward();
      await _blinkController.reverse();
    }
  }
  void _handleTap() {
   _blinkController.forward().then((_) {
      Future.delayed(const Duration(milliseconds: 135), () {   // ADD — hold closed
        if (mounted) _blinkController.reverse();
      });
    });
    final myTap = ++_tapId; 
    setState(() => _tapHearts.add(myTap));   
    Future.delayed(const Duration(milliseconds: 900), () {
      if (mounted) {
        setState(() => _tapHearts.remove(myTap));           // CHANGE — was the myTap == _tapId check
      }
    });
  }

 
  @override
  void didUpdateWidget(PlantBuddy oldWidget) {
    super.didUpdateWidget(oldWidget);
    /*if (oldWidget.stage != widget.stage) {
      Future.delayed(const Duration(milliseconds: 800), () {
        if (mounted) {
          setState(() {
            _displayedStage = widget.stage;
            _showHearts = true;
          });*/ // delay plant animation
    if (oldWidget.stage != widget.stage) {
      setState(() {
        _displayedStage = widget.stage;
        _showHearts = true;
      });
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) _blinkController.forward().then((_) => _blinkController.reverse());
        });
      Future.delayed(const Duration(milliseconds: 2000), () {
        if (mounted) setState(() => _showHearts = false);
      });
    }
  }
 
  @override
  void dispose() {
    _blinkController.dispose();
    _swayController.dispose();
    super.dispose();
  }
 
  @override
  Widget build(BuildContext context) {
    return GestureDetector(              
      behavior: HitTestBehavior.opaque,  
      onTap: _handleTap,                 
      child: Stack(
      clipBehavior: Clip.none,
      children: [
        AnimatedBuilder(
          animation: _swayAnimation,
          builder: (context, child) => Transform.rotate(
            angle: _swayAnimation.value,
            alignment: Alignment.bottomCenter,
            child: child,
          ),
          child: AnimatedSwitcher(
      duration: const Duration(milliseconds: 420),
      switchInCurve: Curves.easeOutBack,
      switchOutCurve: Curves.easeIn,
      transitionBuilder: (child, animation) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.9, end: 1).animate(animation),
          child: FadeTransition(opacity: animation, child: child),
        );
      },
      child: AnimatedBuilder(
        animation: _blinkAnimation,
        builder: (context, _) => CustomPaint(
          key: ValueKey(_displayedStage),
          painter: _CutePlantPainter(
            stage: _displayedStage.clamp(0, 3).toInt(),
            eyeScale: _blinkAnimation.value,
          ),
          child: SizedBox(width: widget.size, height: widget.size * 1.26),
        ),
      ),
        ),
        ),
        if (_showHearts) const _HeartBurst(),
        ..._tapHearts.map((id) => _SingleTapHeart(key: ValueKey(id))),
        
      ],
      ),
    );
  }
}

class _HeartBurst extends StatefulWidget {
  const _HeartBurst();

  @override
  State<_HeartBurst> createState() => _HeartBurstState();
}

class _HeartBurstState extends State<_HeartBurst> with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _positions;
  late List<Animation<double>> _opacities;

  final _heartOffsets = [-30.0, 0.0, 30.0];
  final _heartStartY = [19.0, 0.0, 20.0];

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(3, (i) => AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    ));

    _positions = _controllers.map((c) =>
      Tween<double>(begin: 0, end: -80).animate(
        CurvedAnimation(parent: c, curve: Curves.easeOut),
      ),
    ).toList();

    _opacities = _controllers.map((c) =>
      Tween<double>(begin: 1, end: 0).animate(
        CurvedAnimation(parent: c, curve: const Interval(0.4, 1.0)),
      ),
    ).toList();

    for (var i = 0; i < _controllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 120), () {
        if (mounted) _controllers[i].forward();
      });
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 80,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (i) {
          return AnimatedBuilder(
            animation: _controllers[i],
            builder: (context, _) {
              return Transform.translate(
                offset: Offset(_heartOffsets[i], _positions[i].value + _heartStartY[i]),
                child: Opacity(
                  opacity: _opacities[i].value,
                  child: const Text(
                    '❤️',
                    style: TextStyle(fontSize: 22),
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
class _SingleTapHeart extends StatefulWidget {
  const _SingleTapHeart({super.key});

  @override
  State<_SingleTapHeart> createState() => _SingleTapHeartState();
}

class _SingleTapHeartState extends State<_SingleTapHeart> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _position;
  late final Animation<double> _opacity;
  late final Animation<double> _scale;
  late final double _startTop;
  late final double _startRight;
  late final double _randomsize;
  late final Color _heartColor;

  @override
  void initState() {
    super.initState();
    final random = math.Random();
    _startTop = 90 + (random.nextDouble() - 0.5) * 50;   
    _startRight = 50 + (random.nextDouble() - 0.5) * 70; 
    _randomsize = 40 + (random.nextDouble() - 0.5) * 30; 
    _heartColor = HSLColor.fromColor(Colors.green)          // ADD
        .withLightness(
          (HSLColor.fromColor(Colors.green).lightness +
                  (random.nextDouble() - 0.5) * 0.25)
              .clamp(0.25, 0.75),
        )
        .withHue(
          (HSLColor.fromColor(Colors.green).hue + (random.nextDouble() - 0.5) * 20)
              .clamp(90.0, 150.0),
        )
        .toColor();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {   // ADD
      if (mounted) _controller.forward();                // ADD
    });

    _position = Tween<double>(begin: 0, end: -36).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _opacity = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.35, 1.0)),
    );
    _scale = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.4, curve: Curves.easeOut)),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) { 
    return Positioned(
      top: _startTop,
      right: _startRight,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Transform.translate(
            offset: Offset(0, _position.value),
            child: Opacity(
              opacity: _opacity.value,
              child: Transform.scale(
                scale: _scale.value,
                child: Icon(Icons.favorite_rounded, color: _heartColor, size: _randomsize),
              ),
            ),
          );
        },
      ),
    );
  }
}
class _CutePlantPainter extends CustomPainter {
  const _CutePlantPainter({
    required this.stage,
    this.eyeScale = 1.0,
  });
 
  final int stage;
  final double eyeScale;
 
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
        colors: [Colors.black.withValues(alpha: 0.13), Colors.transparent],
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
 
  void _drawStageFour(Canvas canvas, double cx, double potTopY) {
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
      ..color = Colors.white.withValues(alpha: 0.35)
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
        ..color = Colors.white.withValues(alpha: 0.35)
        ..strokeWidth = 4
        ..strokeCap = StrokeCap.round,
    );
  }
 
  void _drawFlower(Canvas canvas, Offset center, double radius) {
    final petalPaint = Paint()
      ..shader = const RadialGradient(colors: [_flowerLight, _flower]).createShader(
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
      ..lineTo(cx + 42, h + 5)
      ..lineTo(cx - 42, h + 5)
      ..close();
    final potPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [_potBody, _potBodyDark],
      ).createShader(Rect.fromLTWH(cx - 56, h - 58, 112, 54));
    canvas.drawPath(potPath, potPaint);
 
    /*final highlight = Paint()..color = Colors.white.withValues(alpha: 0.17);
    canvas.drawPath(
      Path()
        ..moveTo(cx - 42, h - 55)
        ..lineTo(cx - 20, h - 55)
        ..lineTo(cx - 27, h - 6)
        ..lineTo(cx - 46, h - 6)
        ..close(),
      highlight,
    );*/
 
    final blush = Paint()
      ..color = const Color(0xFFFF7FB0).withValues(alpha: 0.42)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 0.5);
    canvas.drawOval(Rect.fromCenter(center: Offset(cx - 39, h - 34), width: 22, height: 13), blush);
    canvas.drawOval(Rect.fromCenter(center: Offset(cx + 39, h - 34), width: 22, height: 13), blush);
 
    final eyePaint = Paint()..color = _face;
    final shinePaint = Paint()..color = Colors.white.withValues(alpha: 0.92);
    canvas.drawOval(Rect.fromCenter(center: Offset(cx - 22, h - 38), width: 18, height: 23 * eyeScale), eyePaint);
    canvas.drawOval(Rect.fromCenter(center: Offset(cx + 22, h - 38), width: 18, height: 23 * eyeScale), eyePaint);
    canvas.drawCircle(Offset(cx - 19, h - 42), 3.2 * eyeScale, shinePaint);
    canvas.drawCircle(Offset(cx + 25, h - 42), 3.2 * eyeScale, shinePaint);
 
    final mouth = Path()
    ..moveTo(cx - 10, h - 26)                          
    ..quadraticBezierTo(cx - 12, h - 24, cx - 12, h - 23) 
    ..quadraticBezierTo(cx, h - 5, cx + 12, h - 23)   
    ..quadraticBezierTo(cx + 12, h - 24, cx + 10, h - 26) 
    ..quadraticBezierTo(cx, h - 23, cx - 10, h - 25)      
    ..close();
    canvas.drawPath(mouth, Paint()..color = const Color(0xFF5A2F3E));
    canvas.drawOval(Rect.fromCenter(center: Offset(cx, h - 17), width: 10, height: 7), Paint()..color = const Color(0xFFFF7FA8));
  }
 
  @override
  bool shouldRepaint(covariant _CutePlantPainter oldDelegate) =>
      oldDelegate.stage != stage || oldDelegate.eyeScale != eyeScale;
}