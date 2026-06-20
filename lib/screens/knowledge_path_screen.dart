import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/mock_data.dart';
import '../state/app_state.dart';
import '../widgets/top_brand_header.dart';
import 'lesson_detail_screen.dart';

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
        if (mounted) {
          AppStateScope.of(context).markKnowledgeHintSeen();
        }
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

          const Divider(
            height: 1,
            color: AppColors.primary,
          ),

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
                      ?.copyWith(
                        color: AppColors.primary,
                      ),
                ),

                const SizedBox(height: 12),

                const Text(
                  'Lektion 0 ist von Beginn an offen. Danach wird pro Tag nach der ersten Mahlzeit die Tageslektion freigeschaltet.',
                  style: TextStyle(
                    fontSize: 12.5,
                    color: AppColors.textSoft,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 112),
              itemCount: demoLessons.length,
              itemBuilder: (context, index) {
                final lesson = demoLessons[index];

                final unlocked =
                    controller.isLessonUnlocked(lesson.index);

                return _PathNode(
                  lessonIndex: lesson.index,
                  title: lesson.title,
                  unlocked: unlocked,
                  isCurrent:
                      lesson.index ==
                      controller.unlockedLessonIndex,
                  quizAvailable:
                      controller.isQuizAvailable(
                    lesson.index,
                  ),
                  stars:
                      controller.starsForLesson(
                    lesson.index,
                  ),
                  onTap: unlocked
                      ? () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) =>
                                  LessonDetailScreen(
                                lesson: lesson,
                              ),
                            ),
                          );
                        }
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
    required this.onTap,
  });

  final int lessonIndex;
  final String title;
  final bool unlocked;
  final bool isCurrent;
  final bool quizAvailable;
  final int stars;
  final VoidCallback? onTap;


  @override
  Widget build(BuildContext context) {

    final color = lessonIndex == 0
        ? AppColors.accentYellow
        : unlocked
            ? AppColors.primary
            : AppColors.muted;

    final isLeft = lessonIndex.isOdd;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),

      child: SizedBox(
        height: 130,

        child: Stack(
          children: [

            Positioned.fill(
              child: CustomPaint(
                painter: _RoadPainter(
                  leftSide: isLeft,
                  active: unlocked,
                ),
              ),
            ),


            Positioned(
              left: isLeft ? 20 : 140,
              top: 20,

              child: Row(
                mainAxisSize: MainAxisSize.min,

                children: [

                  if (isLeft)
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 8),
                      child: _Stars(
                        stars: stars,
                        unlocked: unlocked,
                      ),
                    ),


                  Container(
                    width: 58,
                    height: 58,

                    decoration: BoxDecoration(
                      shape: BoxShape.circle,

                      color: unlocked
                          ? AppColors.background
                          : const Color(0xFFF1F1F1),

                      border: Border.all(
                        color: color,
                        width: isCurrent ? 7 : 5,
                      ),
                    ),

                    child: Center(
                      child: Text(
                        '$lessonIndex',

                        style: TextStyle(
                          fontSize: 22,
                          fontWeight:
                              FontWeight.w900,
                          color: color,
                        ),
                      ),
                    ),
                  ),


                  if (!isLeft)
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8),

                      child: _Stars(
                        stars: stars,
                        unlocked: unlocked,
                      ),
                    ),
                ],
              ),
            ),


            Positioned(
              left: isLeft ? 20 : 90,
              top: 85,
              width: 160,

              child: Text(
                title,

                textAlign: TextAlign.center,

                maxLines: 2,
                overflow:
                    TextOverflow.ellipsis,

                style: TextStyle(
                  fontSize: 14,
                  fontWeight:
                      FontWeight.w700,

                  color: unlocked
                      ? AppColors.primary
                      : AppColors.muted,
                ),
              ),
            ),


            if (quizAvailable && unlocked)

              Positioned(
                top: 5,
                right: 10,

                child: Container(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),

                  decoration: BoxDecoration(
                    color:
                        AppColors.accentYellow,

                    borderRadius:
                        BorderRadius.circular(20),
                  ),

                  child: const Text(
                    'Quiz',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight:
                          FontWeight.w800,
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



class _Stars extends StatelessWidget {

  const _Stars({
    required this.stars,
    required this.unlocked,
  });


  final int stars;
  final bool unlocked;


  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisSize: MainAxisSize.min,

      children:
          List.generate(3, (index) {

        final filled =
            index < stars;

        return Icon(
          filled
              ? Icons.star
              : Icons.star_border,

          size: 15,

          color: unlocked
              ? AppColors.accentYellow
              : AppColors.muted,
        );
      }),
    );
  }
}



class _RoadPainter extends CustomPainter {

  const _RoadPainter({
    required this.leftSide,
    required this.active,
  });


  final bool leftSide;
  final bool active;


  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {

    final paint = Paint()

      ..color = active
          ? AppColors.primary.withValues(alpha: 0.5)
          : AppColors.muted.withValues(alpha: 0.3)

      ..strokeWidth = 5

      ..style =
          PaintingStyle.stroke

      ..strokeCap =
          StrokeCap.round;


    final path = Path();


    final double x1 =
      leftSide ? 50.0 : size.width - 50.0;

    final double x2 =
      leftSide ? size.width - 50.0 : 50.0;


    path.moveTo(x1, 0);

    path.cubicTo(
      x1,
      40,
      x2,
      80,
      x2,
      size.height,
    );


    canvas.drawPath(
      path,
      paint,
    );
  }


  @override
  bool shouldRepaint(_) => false;
}