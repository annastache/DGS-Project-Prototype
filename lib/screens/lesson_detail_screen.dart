import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../models/lesson.dart';
import '../state/app_state.dart';
import 'quiz_screen.dart';

class LessonDetailScreen extends StatelessWidget {
  const LessonDetailScreen({required this.lesson, super.key});

  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    final controller = AppStateScope.of(context);
    final quizAvailable = controller.isQuizAvailable(lesson.index);
    final hasQuizConcept = true;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.primary,
        titleSpacing: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              lesson.title,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
            ),
            Text(
              lesson.readingTime,
              style: const TextStyle(fontSize: 12, color: AppColors.text),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(22, 14, 22, 28),
        children: [
          if (quizAvailable)
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 14),
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => QuizScreen(lesson: lesson),
                    ),
                  );
                },
                child: Text(
                  controller.starsForLesson(lesson.index) > 0 ? 'Quiz wiederholen' : 'Quiz starten',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          if (!quizAvailable && hasQuizConcept)
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Text(
                'Das Quiz zu dieser Lektion wird freigeschaltet, sobald an diesem Tag Frühstück, Mittagessen und Abendessen erledigt sind.',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.primaryDark),
              ),
            ),
          if (quizAvailable || hasQuizConcept) const SizedBox(height: 26),
          Text(
            'Lektion ${lesson.index}',
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: AppColors.textSoft),
          ),
          const SizedBox(height: 4),
          Text(
            lesson.title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColors.primary),
          ),
          const SizedBox(height: 12),
          Text(
            lesson.body,
            style: const TextStyle(fontSize: 17, height: 1.45, color: AppColors.text),
          ),
          const SizedBox(height: 22),
          if (lesson.index == 0) ...[
            Text(
              'So funktioniert die Erkennungsphase',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.primary),
            ),
            const SizedBox(height: 8),
            const Text(
              'Jeden Tag startet deine Pflanze klein. Durch die Tagesdokumentation wächst sie in vier Stufen. Der Wissenspfad begleitet dich parallel und schaltet neue Inhalte passend zu deinem Fortschritt frei.',
              style: TextStyle(fontSize: 17, height: 1.45, color: AppColors.text),
            ),
          ],
        ],
      ),
    );
  }
}