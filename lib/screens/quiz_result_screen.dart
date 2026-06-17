import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../state/app_state.dart';

class QuizResultScreen extends StatelessWidget {
  const QuizResultScreen({
    required this.lessonTitle,
    required this.correctAnswers,
    required this.totalQuestions,
    super.key,
  });

  final String lessonTitle;
  final int correctAnswers;
  final int totalQuestions;

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
                    icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 34),
                    color: AppColors.primary,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Text(
                        'Quiz: $lessonTitle',
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.fromLTRB(18, 28, 18, 28),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(34),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.25),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
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
                          size: 74,
                          color: index < stars ? AppColors.accentYellow : const Color(0xFF9BA49C),
                        );
                      }),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      headline,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontSize: 27, fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 28),
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w900, height: 1.25),
                    ),
                    const SizedBox(height: 28),
                    const Text(
                      'Weiter so!',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 17),
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
}
