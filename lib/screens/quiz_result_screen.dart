import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../models/lesson.dart';
import '../state/app_state.dart';
import 'quiz_screen.dart';

class QuizResultScreen extends StatelessWidget {
  const QuizResultScreen({
    required this.lesson,
    required this.correctAnswers,
    required this.totalQuestions,
    super.key,
  });

  final Lesson lesson;
  final int correctAnswers;
  final int totalQuestions;

  String get lessonTitle => lesson.title;

  @override
  Widget build(BuildContext context) {
    final controller = AppStateScope.of(context);
    final rawStars = totalQuestions <= 0 ? 0 : ((correctAnswers / totalQuestions) * 3).round();
    final stars = rawStars < 0 ? 0 : (rawStars > 3 ? 3 : rawStars);
    final headline = switch (stars) {
      3 => 'Spitze!',
      2 => 'Sehr gut!',
      1 => 'Gut gemacht!',
      _ => 'Dranbleiben!',
    };
    final message = switch (stars) {
      3 => 'Du hast alle Fragen richtig beantwortet!',
      2 => 'Du hast fast alles richtig beantwortet!',
      1 => 'Du hast einen guten Start geschafft.',
      _ => 'Schau dir die Lektion nochmal an und versuch es erneut.',
    };

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 18, 22, 26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 22),
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      lessonTitle,
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 17, color: AppColors.primary, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
              const SizedBox(height:100),
              Container(
                padding: const EdgeInsets.fromLTRB(18, 28, 18, 28),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.35),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(3, (index) {
                        return Icon(
                          Icons.star,
                          size: 64,
                          color: index < stars ? AppColors.accentYellow : Colors.white.withValues(alpha: 0.35),
                        );
                      }),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      headline,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500, height: 1.4),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: const BorderSide(color: AppColors.primary, width: 2),
                  padding: const EdgeInsets.symmetric(vertical: 17),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                ),
                onPressed: () => _retakeQuiz(context),
                child: const Text('Quiz wiederholen', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              ),
              const SizedBox(height: 14),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 17),
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                ),
                onPressed: () {
                  controller.setSelectedIndex(4);
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: const Text('Zurück zum Wissenspfad', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  void _retakeQuiz(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => QuizScreen(lesson: lesson),
      ),
    );
  }
}