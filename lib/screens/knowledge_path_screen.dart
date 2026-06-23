import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/mock_data.dart';
import '../state/app_state.dart';
import '../widgets/top_brand_header.dart';
import 'lesson_detail_screen.dart';

// Konstanten die Painter und Layout teilen
const double _nodeHeight = 130.0;
const double _circleD = 68.0;
const double _circleR = _circleD / 2;
const double _circleTop = 22.0;
const double _circleBottom = _circleTop + _circleD; // 90
const double _gap = _circleTop; // 22px — symmetrisch oben und unten
const double _horizY = _circleBottom + _gap; // 112 — wo die horizontale Linie liegt
const double _edgeMargin = 40.0;

Color _nodeColor(int lessonIndex, bool unlocked) {
  if (!unlocked) return AppColors.muted;
  if (lessonIndex <= 4) return AppColors.accentYellow;
  if (lessonIndex <= 9) return AppColors.accentBlue;
  return AppColors.primary;
}

bool _circleOnRight(int lessonIndex) => lessonIndex.isEven;

double _circleCx(int lessonIndex, double screenWidth) => _circleOnRight(lessonIndex)
    ? screenWidth - _edgeMargin - _circleR
    : _edgeMargin + _circleR;

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
    final screenWidth = MediaQuery.of(context).size.width;
    final totalHeight = demoLessons.length * _nodeHeight;

    // Baut Liste der Node-Daten für Painter
    final nodes = demoLessons.map((lesson) {
      final unlocked = controller.isLessonUnlocked(lesson.index);
      return _NodeData(
        lessonIndex: lesson.index,
        unlocked: unlocked,
        color: _nodeColor(lesson.index, unlocked),
      );
    }).toList();

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
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 112),
              child: SizedBox(
                width: screenWidth,
                height: totalHeight,
                child: Stack(
                  children: [
                    // Globaler Pfad-Painter über alle Nodes
                    Positioned.fill(
                      child: CustomPaint(
                        painter: _GlobalRoadPainter(
                          nodes: nodes,
                          screenWidth: screenWidth,
                        ),
                      ),
                    ),
                    // Node-Widgets darüber
                    for (final lesson in demoLessons)
                      Positioned(
                        top: lesson.index * _nodeHeight,
                        left: 0,
                        right: 0,
                        height: _nodeHeight,
                        child: _PathNode(
                          lesson: lesson,
                          unlocked: controller.isLessonUnlocked(lesson.index),
                          isCurrent: lesson.index == controller.unlockedLessonIndex,
                          quizAvailable: controller.isQuizAvailable(lesson.index),
                          stars: controller.starsForLesson(lesson.index),
                          screenWidth: screenWidth,
                          onTap: controller.isLessonUnlocked(lesson.index)
                              ? () => Navigator.of(context).push(
                                    MaterialPageRoute<void>(
                                      builder: (_) =>
                                          LessonDetailScreen(lesson: lesson),
                                    ),
                                  )
                              : null,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NodeData {
  const _NodeData({
    required this.lessonIndex,
    required this.unlocked,
    required this.color,
  });
  final int lessonIndex;
  final bool unlocked;
  final Color color;
}

// Zeichnet den kompletten Pfad für alle Nodes in einem einzigen Paint-Aufruf
class _GlobalRoadPainter extends CustomPainter {
  const _GlobalRoadPainter({
    required this.nodes,
    required this.screenWidth,
  });

  final List<_NodeData> nodes;
  final double screenWidth;

  @override
  void paint(Canvas canvas, Size size) {
    for (var i = 0; i < nodes.length - 1; i++) {
      final node = nodes[i];
      final nextNode = nodes[i + 1];
      final segmentUnlocked = node.unlocked && nextNode.unlocked;
      final paint = Paint()
        ..color = segmentUnlocked
            ? node.color
            : AppColors.muted.withValues(alpha: 0.35)
        ..strokeWidth = 8
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;

      final double nodeTop = i * _nodeHeight;
      final double xOwn = _circleCx(node.lessonIndex, screenWidth);
      final double xNext = _circleCx(nodes[i + 1].lessonIndex, screenWidth);

      // Absoluter y-Wert der horizontalen Linie für diesen Node
      final double absHorizY = nodeTop + _horizY;

      final path = Path();
      // Von Unterkante Circle senkrecht runter bis horizY
      path.moveTo(xOwn, nodeTop + _circleBottom);
      path.lineTo(xOwn, absHorizY);
      // Horizontal rüber
      path.lineTo(xNext, absHorizY);
      // Senkrecht runter bis Oberkante des nächsten Circles
      path.lineTo(xNext, nodeTop + _nodeHeight + _circleTop);

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(_GlobalRoadPainter old) => true;
}

class _PathNode extends StatelessWidget {
  const _PathNode({
    required this.lesson,
    required this.unlocked,
    required this.isCurrent,
    required this.quizAvailable,
    required this.stars,
    required this.screenWidth,
    required this.onTap,
  });

  final dynamic lesson;
  final bool unlocked;
  final bool isCurrent;
  final bool quizAvailable;
  final int stars;
  final double screenWidth;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final color = _nodeColor(lesson.index, unlocked);
    final onRight = _circleOnRight(lesson.index);
    final circleCx = _circleCx(lesson.index, screenWidth);
    final circleLeft = circleCx - _circleR;

    const double starsW = 20.0;
    const double starsGap = 8.0;
    final double starsLeft = onRight
        ? circleCx + _circleR + starsGap
        : circleCx - _circleR - starsGap - starsW;

    const double textWidth = 145.0;
    final double textLeft = onRight
        ? circleCx - _circleR - textWidth - 12
        : circleCx + _circleR + 12;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: _nodeHeight,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Circle
            Positioned(
              left: circleLeft,
              top: _circleTop,
              child: _NodeCircle(
                lessonIndex: lesson.index,
                color: color,
                isCurrent: isCurrent,
                unlocked: unlocked,
              ),
            ),

            // Sterne — nur wenn Quiz verfügbar
            if (quizAvailable && unlocked)
              Positioned(
                left: starsLeft,
                top: _circleTop + 4,
                child: _Stars(stars: stars, color: color),
              ),

            // Titel
            Positioned(
              left: textLeft,
              top: _circleTop + 12,
              width: textWidth,
              child: Text(
                lesson.title,
                textAlign: onRight ? TextAlign.right : TextAlign.left,
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
  });

  final int lessonIndex;
  final Color color;
  final bool isCurrent;
  final bool unlocked;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _circleD,
      height: _circleD,
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