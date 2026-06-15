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

  QuizQuestion get question => demoQuizQuestions[questionIndex];
  bool get isLastQuestion => questionIndex == demoQuizQuestions.length - 1;

  @override
  Widget build(BuildContext context) {
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
                        'Quiz ${widget.lesson.index}: ${widget.lesson.title}',
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(flex: 1),
              Container(
                padding: const EdgeInsets.fromLTRB(18, 14, 18, 24),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(34),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.25),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 9),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        border: Border.all(color: Colors.white70, width: 3),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        'Frage ${questionIndex + 1}',
                        style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(height: 26),
                    Text(
                      question.question,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontSize: 23, fontWeight: FontWeight.w700, height: 1.25),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 36),
              for (var i = 0; i < question.answers.length; i++)
                _AnswerButton(
                  label: question.answers[i],
                  isSelected: selectedAnswer == i,
                  isCorrect: question.correctIndex == i,
                  revealed: revealed,
                  onTap: revealed ? null : () => _selectAnswer(i),
                ),
              const Spacer(flex: 2),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: revealed ? _next : null,
                  child: Text(
                    isLastQuestion ? 'Quiz Abschließen' : 'Nächste Frage >',
                    style: TextStyle(
                      fontSize: 26,
                      color: revealed ? AppColors.textSoft : AppColors.muted,
                      fontWeight: FontWeight.w700,
                    ),
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
        totalQuestions: demoQuizQuestions.length,
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (_) => QuizResultScreen(
            lessonTitle: widget.lesson.title,
            correctAnswers: correctAnswers,
            totalQuestions: demoQuizQuestions.length,
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

class _AnswerButton extends StatelessWidget {
  const _AnswerButton({
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
    Color color = AppColors.primary;
    BorderSide side = const BorderSide(color: AppColors.primaryLight, width: 3);
    if (!revealed && isSelected) {
      side = const BorderSide(color: AppColors.accentYellow, width: 3);
    }
    if (revealed && isCorrect) {
      color = const Color(0xFF6FD84F);
    }
    if (revealed && isSelected && !isCorrect) {
      color = AppColors.danger;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: SizedBox(
        height: 50,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
            disabledBackgroundColor: color,
            disabledForegroundColor: Colors.white,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999),
              side: side,
            ),
          ),
          child: Text(label, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
        ),
      ),
    );
  }
}
