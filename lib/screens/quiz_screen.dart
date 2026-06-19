import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/mock_data.dart';
import '../models/lesson.dart';
import '../models/quiz_question.dart';
import '../state/app_state.dart';
import 'quiz_result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({required this.lesson, super.key});

  final Lesson lesson;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int questionIndex = 0;
  int correctAnswers = 0;
  int? selectedAnswer;
  bool revealed = false;

  List<QuizQuestion> get questions => demoQuizQuestionsByLesson[widget.lesson.index] ?? const [];
  QuizQuestion get question => questions[questionIndex];
  bool get isLastQuestion => questionIndex == questions.length - 1;
  int get totalQuestions => questions.length;

  @override
  Widget build(BuildContext context) {
    if (questions.isEmpty) {
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Für diese Lektion ist noch kein Quiz verfügbar.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Zurück'),
                ),
              ],
            ),
          ),
        ),
      );
    }

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
                    icon: const Icon(Icons.close_rounded, size: 26),
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: _ProgressBar(
                      currentIndex: questionIndex,
                      total: totalQuestions,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '${questionIndex + 1}/$totalQuestions',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Text(
                'Frage ${questionIndex + 1}',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                question.question,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  height: 1.35,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 32),
              for (var i = 0; i < question.answers.length; i++)
                _AnswerCard(
                  label: question.answers[i],
                  isSelected: selectedAnswer == i,
                  isCorrect: question.correctIndex == i,
                  revealed: revealed,
                  onTap: revealed ? null : () => _selectAnswer(i),
                ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: revealed ? _next : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.3),
                    disabledForegroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 17),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                  ),
                  child: Text(
                    isLastQuestion ? 'Quiz abschließen' : 'Weiter',
                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectAnswer(int index) {
    setState(() {
      selectedAnswer = index;
      revealed = true;
      if (index == question.correctIndex) {
        correctAnswers += 1;
      }
    });
  }

  void _next() {
    if (!revealed) {
      return;
    }
    if (isLastQuestion) {
      AppStateScope.of(context).storeQuizResult(
        lessonIndex: widget.lesson.index,
        correctAnswers: correctAnswers,
        totalQuestions: totalQuestions,
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (_) => QuizResultScreen(
            lesson: widget.lesson,
            correctAnswers: correctAnswers,
            totalQuestions: totalQuestions,
          ),
        ),
      );
      return;
    }
    setState(() {
      questionIndex += 1;
      selectedAnswer = null;
      revealed = false;
    });
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.currentIndex, required this.total});

  final int currentIndex;
  final int total;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 8,
      child: Row(
        children: List.generate(total, (index) {
          final isFilled = index <= currentIndex;
          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: index == total - 1 ? 0 : 4),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(99),
                child: Container(
                  height: 8,
                  color: isFilled ? AppColors.primary : AppColors.primaryLight.withValues(alpha: 0.3),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _AnswerCard extends StatelessWidget {
  const _AnswerCard({
    required this.label,
    required this.isSelected,
    required this.isCorrect,
    required this.revealed,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final bool isCorrect;
  final bool revealed;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    Color borderColor = Colors.transparent;
    Color backgroundColor = Colors.white;
    Color textColor = Colors.black87;
    Widget? trailingIcon;
    double borderWidth = 0;
    List<BoxShadow> shadow = [
      BoxShadow(
        color: AppColors.primary.withValues(alpha: 0.22),
        blurRadius: 10,
        offset: const Offset(0, 3),
      ),
    ];

    if (!revealed && isSelected) {
      borderColor = AppColors.primary;
      backgroundColor = AppColors.primary.withValues(alpha: 0.15);
      textColor = AppColors.primary;
      borderWidth = 2;
    }

    if (revealed && isCorrect) {
      borderColor = const Color(0xFF2F9E44);
      backgroundColor = const Color(0xFF2F9E44).withValues(alpha: 0.20);
      borderWidth = 2;
      trailingIcon = const Icon(Icons.check_circle_rounded, color: Color(0xFF2F9E44), size: 22);
    }

    if (revealed && isSelected && !isCorrect) {
      borderColor = AppColors.danger;
      backgroundColor = AppColors.danger.withValues(alpha: 0.20);
      borderWidth = 2;
      trailingIcon = Icon(Icons.cancel_rounded, color: AppColors.danger, size: 22);
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: borderColor, width: borderWidth),
              boxShadow: shadow,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: textColor),
                  ),
                ),
                if (trailingIcon != null) trailingIcon,
              ],
            ),
          ),
        ),
      ),
    );
  }
}