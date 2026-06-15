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
          const Divider(height: 1, color: AppColors.primary),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Wissenspfad',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.primary),
                ),
                const SizedBox(height: 4),
                Text(
                  'Lektion 0 ist von Beginn an offen. Danach wird pro Tag nach der ersten Mahlzeit die Tageslektion freigeschaltet.',
                  style: const TextStyle(fontSize: 12.5, color: AppColors.textSoft, height: 1.3),
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
                final unlocked = controller.isLessonUnlocked(lesson.index);
                final quizAvailable = controller.isQuizAvailable(lesson.index);
                final stars = controller.starsForLesson(lesson.index);
                return _PathNode(
                  lessonIndex: lesson.index,
                  title: lesson.title,
                  unlocked: unlocked,
                  isCurrent: lesson.index == controller.unlockedLessonIndex,
                  quizAvailable: quizAvailable,
                  stars: stars,
                  onTap: unlocked
                      ? () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => LessonDetailScreen(lesson: lesson),
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
    final color = unlocked ? (isCurrent ? AppColors.primaryDark : AppColors.primary) : AppColors.muted;
    final isLeft = lessonIndex.isOdd;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Column(
          crossAxisAlignment: isLeft ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                if (isLeft) _Stars(stars: stars, unlocked: unlocked),
                if (isLeft) const SizedBox(width: 6),
                if (!isLeft) const Spacer(),
                Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: unlocked ? AppColors.background : const Color(0xFFF1F1F1),
                    border: Border.all(color: color, width: isCurrent ? 8 : 6),
                  ),
                  child: Center(
                    child: Text(
                      '$lessonIndex',
                      style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900, color: color),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 180,
                  child: Text(
                    title,
                    textAlign: isLeft ? TextAlign.left : TextAlign.right,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15.5,
                      fontWeight: FontWeight.w800,
                      color: unlocked ? AppColors.primary : AppColors.muted,
                    ),
                  ),
                ),
                if (isLeft) const Spacer(),
                if (!isLeft) const SizedBox(width: 6),
                if (!isLeft) _Stars(stars: stars, unlocked: unlocked),
              ],
            ),
            if (quizAvailable && unlocked)
              Container(
                margin: EdgeInsets.only(
                  top: 6,
                  left: isLeft ? 74 : 0,
                  right: isLeft ? 0 : 74,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: stars > 0 ? AppColors.primaryLight : AppColors.accentYellow.withOpacity(0.72),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  stars > 0 ? 'Quiz wiederholen' : 'Quiz verfügbar',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: AppColors.primaryDark),
                ),
              ),
            if (!unlocked)
              Container(
                margin: EdgeInsets.only(
                  top: 6,
                  left: isLeft ? 74 : 0,
                  right: isLeft ? 0 : 74,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: const Color(0xFFE9ECE8), borderRadius: BorderRadius.circular(999)),
                child: const Text(
                  'Noch gesperrt',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.textSoft),
                ),
              ),
            Container(
              width: 8,
              height: 30,
              margin: EdgeInsets.only(
                left: isLeft ? 25 : 0,
                right: isLeft ? 0 : 25,
                top: 3,
              ),
              decoration: BoxDecoration(
                color: color.withOpacity(unlocked ? 0.95 : 0.4),
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Stars extends StatelessWidget {
  const _Stars({required this.stars, required this.unlocked});

  final int stars;
  final bool unlocked;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        final filled = index < stars;
        return Icon(
          filled ? Icons.star : Icons.star_border,
          size: 15,
          color: unlocked ? AppColors.accentYellow : AppColors.muted,
        );
      }),
    );
  }
}
