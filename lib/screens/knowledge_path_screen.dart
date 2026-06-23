import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/mock_data.dart';
import '../state/app_state.dart';
import '../widgets/top_brand_header.dart';
import 'lesson_detail_screen.dart';

Color _nodeColor(int lessonIndex, bool unlocked) {
  if (!unlocked) return AppColors.muted;
  if (lessonIndex <= 4) return AppColors.accentYellow;
  if (lessonIndex <= 9) return AppColors.primary;
  return AppColors.accentBlue;
}

class KnowledgePathScreen extends StatefulWidget {
  const KnowledgePathScreen({super.key});

  @override
  State<KnowledgePathScreen> createState() => _KnowledgePathScreenState();
}

class _KnowledgePathScreenState extends State<KnowledgePathScreen> {
  bool _markedSeen = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_markedSeen) {
      _markedSeen = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) AppStateScope.of(context).markKnowledgeHintSeen();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = AppStateScope.of(context);

    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          const TopBrandHeader(),
          const Divider(height: 1, color: AppColors.primary),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Wissenspfad - Erkennungsphase',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: AppColors.primary),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Lektion 0 ist von Beginn an offen. Danach wird pro Tag nach der ersten Mahlzeit die Tageslektion freigeschaltet.',
                  style: TextStyle(
                      fontSize: 12.5, color: AppColors.textSoft, height: 1.3),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 112),
              itemCount: demoLessons.length,
              itemBuilder: (context, index) {
                final lesson = demoLessons[index];
                final unlocked = controller.isLessonUnlocked(lesson.index);
                final isLast = lesson.index == demoLessons.length - 1;

                return _PathNode(
                  lessonIndex: lesson.index,
                  title: lesson.title,
                  unlocked: unlocked,
                  isCurrent: lesson.index == controller.unlockedLessonIndex,
                  quizAvailable: controller.isQuizAvailable(lesson.index),
                  stars: controller.starsForLesson(lesson.index),
                  isLast: isLast,
                  onTap: unlocked
                      ? () => Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) =>
                                  LessonDetailScreen(lesson: lesson),
                            ),
                          )
                      : null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _PathNode extends StatelessWidget {
  const _PathNode({
    required this.lessonIndex,
    required this.title,
    required this.unlocked,
    required this.isCurrent,
    required this.quizAvailable,
    required this.stars,
    required this.isLast,
    required this.onTap,
  });

  final int lessonIndex;
  final String title;
  final bool unlocked;
  final bool isCurrent;
  final bool quizAvailable;
  final int stars;
  final bool isLast;
  final VoidCallback? onTap;

  // Ungerade = Circle rechts, gerade = Circle links (wie im Mockup)
  bool get _circleOnRight => lessonIndex.isEven;

  @override
  Widget build(BuildContext context) {
    final color = _nodeColor(lessonIndex, unlocked);
    final pathColor = unlocked
        ? _nodeColor(lessonIndex, true)
        : AppColors.muted.withValues(alpha: 0.4);

    // Breite des Screens für relative Positionierung
    final screenWidth = MediaQuery.of(context).size.width;

    const double circleD = 68.0;
    const double circleR = circleD / 2;
    const double edgeMargin = 40.0;   // Abstand Circle-Rand zum Screen-Rand
    const double starsW = 20.0;       // Breite der vertikalen Sterne (Icon-Größe)
    const double starsGap = 5.0;     // gleicher Abstand Circle ↔ Sterne auf beiden Seiten

    // Circle-Mittelpunkt: nah am Rand
    final double circleCx = _circleOnRight
        ? screenWidth - edgeMargin - circleR
        : edgeMargin + circleR;
    final double circleLeft = circleCx - circleR;

    // Text auf der gegenüberliegenden Seite
    const double textWidth = 140.0;
    final double textLeft = _circleOnRight
        ? circleCx - circleR - textWidth - 12
        : circleCx + circleR + 12;

    // Sterne: gleicher Abstand zum Circle auf beiden Seiten, Breite berücksichtigt
    final double starsLeft = _circleOnRight
        ? circleCx + circleR + starsGap          // rechter Circle → Sterne rechts davon
        : circleCx - circleR - starsGap - starsW; // linker Circle → Sterne links davon

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 130,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Verbindungspfad
            if (!isLast)
              Positioned.fill(
                child: CustomPaint(
                  painter: _RoadPainter(
                    circleOnRight: _circleOnRight,
                    pathColor: pathColor,
                    screenWidth: screenWidth,
                  ),
                ),
              ),

            // Circle
            Positioned(
              left: circleLeft,
              top: 22,
              child: _NodeCircle(
                lessonIndex: lessonIndex,
                color: color,
                isCurrent: isCurrent,
                unlocked: unlocked,
                size: circleD,
              ),
            ),

            // Sterne — schräg außen oben neben dem Circle (gegenüber dem Text)
            Positioned(
              left: starsLeft,
              top: 20,
              child: _Stars(stars: stars, color: color),
            ),

            // Titel — auf der gegenüberliegenden Seite des Circles
            Positioned(
              left: textLeft,
              top: 36,
              width: textWidth,
              child: Text(
                title,
                textAlign:
                    _circleOnRight ? TextAlign.right : TextAlign.left,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: unlocked ? AppColors.text : AppColors.muted,
                  height: 1.3,
                ),
              ),
            ),

            // Quiz-Badge — über dem Titel
            if (quizAvailable && unlocked)
              Positioned(
                left: _circleOnRight ? textLeft : null,
                right: _circleOnRight
                    ? null
                    : screenWidth - textLeft - textWidth,
                top: 4,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Quiz',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: color == AppColors.accentYellow
                          ? AppColors.text
                          : Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _NodeCircle extends StatelessWidget {
  const _NodeCircle({
    required this.lessonIndex,
    required this.color,
    required this.isCurrent,
    required this.unlocked,
    required this.size,
  });

  final int lessonIndex;
  final Color color;
  final bool isCurrent;
  final bool unlocked;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: unlocked ? AppColors.background : const Color(0xFFEEEEEE),
        border: Border.all(color: color, width: isCurrent ? 8 : 5),
        boxShadow: unlocked
            ? [
                BoxShadow(
                  color: color.withValues(alpha: 0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Center(
        child: Text(
          '$lessonIndex',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: color,
          ),
        ),
      ),
    );
  }
}

class _Stars extends StatelessWidget {
  const _Stars({required this.stars, required this.color});

  final int stars;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        final filled = index < stars;
        return Icon(
          filled ? Icons.star_rounded : Icons.star_outline_rounded,
          size: 20,
          color: filled ? color : AppColors.muted,
        );
      }),
    );
  }
}

class _RoadPainter extends CustomPainter {
  const _RoadPainter({
    required this.circleOnRight,
    required this.pathColor,
    required this.screenWidth,
  });

  final bool circleOnRight;
  final Color pathColor;
  final double screenWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = pathColor
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final double circleR = 34.0;
    final double edgeMargin = 40.0;
    final double x1 = circleOnRight
        ? screenWidth - edgeMargin - circleR
        : edgeMargin + circleR;
    final double x2 = circleOnRight
        ? edgeMargin + circleR
        : screenWidth - edgeMargin - circleR;
    // Pfad startet an Unterkante des aktuellen Circles
    // und endet bei y=0 des nächsten Nodes (= Oberkante des nächsten Circles bei top:22)
    // Wir zeichnen von 0 bis size.height damit der Pfad lückenlos verbindet
    final double circleBottom = 22 + 68.0;
    final double midY = circleBottom + (size.height - circleBottom) * 0.5;

    final path = Path();
    path.moveTo(x1, 0);             // startet am Anfang des Nodes (= Unterkante vorheriger Circle)
    path.lineTo(x1, circleBottom);  // senkrecht zur Unterkante des Circles
    path.lineTo(x1, midY);          // weiter runter zur Mitte
    path.lineTo(x2, midY);          // waagerecht rüber
    path.lineTo(x2, size.height);   // senkrecht zum Ende des Nodes
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_RoadPainter old) =>
      old.pathColor != pathColor || old.circleOnRight != circleOnRight;
}