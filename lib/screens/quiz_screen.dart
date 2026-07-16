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

  // --- matching-question state ---
  // Maps a left-item index to the *display position* (index into
  // shuffledRightIndices) of the right item the user linked it to.
  Map<int, int> matchingSelections = {};
  int? activeLeft;
  List<int> shuffledRightIndices = [];

  // --- sequence-question state ---
  // Display order (indices into shuffledSequenceIndices) in which the
  // user tapped items.
  List<int> sequenceOrder = [];
  List<int> shuffledSequenceIndices = [];

  // --- multi-select-question state ---
  Set<int> multiSelected = {};

  // --- estimate-question state ---
  double estimateValue = 0;

  List<QuizQuestion> get questions => demoQuizQuestionsByLesson[widget.lesson.index] ?? const [];
  QuizQuestion get question => questions[questionIndex];
  bool get isLastQuestion => questionIndex == questions.length - 1;
  int get totalQuestions => questions.length;

  /// The lesson index at which each question type makes its first-ever
  /// appearance across the app. Lessons 0-7 each introduce exactly one new
  /// type, in this order; lessons 8+ freely remix the already-unlocked pool.
  /// Keeping this here (rather than in the data) means the "new type"
  /// badge below always reflects the actual curriculum, even if someone
  /// edits `mock_data.dart` later.
  static const Map<QuestionType, int> _typeUnlockLesson = {
    QuestionType.trueFalse: 1,
    QuestionType.oddOneOut: 2,
    QuestionType.fillBlank: 3,
    QuestionType.multiSelect: 4,
    QuestionType.matching: 5,
    QuestionType.sequence: 6,
    QuestionType.estimate: 7,
  };

  bool get isNewlyUnlockedType => _typeUnlockLesson[question.type] == widget.lesson.index;

  String _typeDisplayName(QuestionType type) {
    switch (type) {
      case QuestionType.trueFalse:
        return 'Richtig oder Falsch';
      case QuestionType.oddOneOut:
        return 'Was passt nicht?';
      case QuestionType.fillBlank:
        return 'Lückentext';
      case QuestionType.multiSelect:
        return 'Mehrfachauswahl';
      case QuestionType.matching:
        return 'Zuordnen';
      case QuestionType.sequence:
        return 'Reihenfolge';
      case QuestionType.estimate:
        return 'Schätzfrage';
      case QuestionType.multipleChoice:
        return 'Multiple Choice';
    }
  }

  bool get needsExplicitSubmit =>
      question.type == QuestionType.matching ||
      question.type == QuestionType.sequence ||
      question.type == QuestionType.multiSelect ||
      question.type == QuestionType.estimate;

  bool get canSubmit {
    switch (question.type) {
      case QuestionType.matching:
        return matchingSelections.length == (question.pairs?.length ?? 0);
      case QuestionType.sequence:
        return sequenceOrder.length == (question.sequenceItems?.length ?? 0);
      case QuestionType.multiSelect:
        return multiSelected.isNotEmpty;
      case QuestionType.estimate:
        return true;
      case QuestionType.multipleChoice:
      case QuestionType.trueFalse:
      case QuestionType.oddOneOut:
      case QuestionType.fillBlank:
        return false;
    }
  }

  @override
  void initState() {
    super.initState();
    _prepareCurrentQuestion();
  }

  void _prepareCurrentQuestion() {
    selectedAnswer = null;
    matchingSelections = {};
    activeLeft = null;
    shuffledRightIndices = [];
    sequenceOrder = [];
    shuffledSequenceIndices = [];
    multiSelected = {};
    estimateValue = 0;

    switch (question.type) {
      case QuestionType.matching:
        final pairCount = question.pairs!.length;
        shuffledRightIndices = List.generate(pairCount, (i) => i)..shuffle();
        break;
      case QuestionType.sequence:
        final itemCount = question.sequenceItems!.length;
        shuffledSequenceIndices = List.generate(itemCount, (i) => i)..shuffle();
        break;
      case QuestionType.estimate:
        estimateValue = (question.estimateMin! + question.estimateMax!) / 2;
        break;
      case QuestionType.multipleChoice:
      case QuestionType.trueFalse:
      case QuestionType.oddOneOut:
      case QuestionType.multiSelect:
      case QuestionType.fillBlank:
        break;
    }
  }

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

    final bool awaitingSubmit = needsExplicitSubmit && !revealed;
    final String buttonLabel = awaitingSubmit
        ? 'Prüfen'
        : (isLastQuestion ? 'Quiz abschließen' : 'Weiter');
    final VoidCallback? buttonAction = awaitingSubmit
        ? (canSubmit ? _submit : null)
        : (revealed ? _next : null);

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
              if (isNewlyUnlockedType) ...[
                _NewTypeBadge(label: _typeDisplayName(question.type)),
                const SizedBox(height: 12),
              ],
              Text(
                _questionLabel(),
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
              Expanded(child: SingleChildScrollView(child: _buildAnswerArea())),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: buttonAction,
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
                    buttonLabel,
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

  Widget _buildAnswerArea() {
    switch (question.type) {
      case QuestionType.matching:
        return _MatchingArea(
          pairs: question.pairs!,
          shuffledRightIndices: shuffledRightIndices,
          selections: matchingSelections,
          activeLeft: activeLeft,
          revealed: revealed,
          onTapLeft: _onTapLeft,
          onTapRight: _onTapRight,
        );
      case QuestionType.sequence:
        return _SequenceArea(
          items: question.sequenceItems!,
          shuffledIndices: shuffledSequenceIndices,
          order: sequenceOrder,
          revealed: revealed,
          onTapItem: _onTapSequenceItem,
        );
      case QuestionType.multiSelect:
        return Column(
          children: [
            for (var i = 0; i < question.answers.length; i++)
              _MultiSelectCard(
                label: question.answers[i],
                isSelected: multiSelected.contains(i),
                isCorrectAnswer: (question.correctIndices ?? const []).contains(i),
                revealed: revealed,
                onTap: revealed ? null : () => _toggleMultiSelect(i),
              ),
          ],
        );
      case QuestionType.estimate:
        return _EstimateArea(
          value: estimateValue,
          min: question.estimateMin!,
          max: question.estimateMax!,
          target: question.estimateTarget!,
          unit: question.estimateUnit,
          revealed: revealed,
          onChanged: revealed ? null : (v) => setState(() => estimateValue = v),
        );
      case QuestionType.fillBlank:
        return Column(
          children: [
            _FillBlankPreview(
              template: question.question,
              filledWord: selectedAnswer != null ? question.answers[selectedAnswer!] : null,
            ),
            for (var i = 0; i < question.answers.length; i++)
              _AnswerCard(
                label: question.answers[i],
                isSelected: selectedAnswer == i,
                isCorrect: question.correctIndex == i,
                revealed: revealed,
                onTap: revealed ? null : () => _selectAnswer(i),
              ),
          ],
        );
      case QuestionType.multipleChoice:
      case QuestionType.trueFalse:
      case QuestionType.oddOneOut:
        return Column(
          children: [
            for (var i = 0; i < question.answers.length; i++)
              _AnswerCard(
                label: question.answers[i],
                isSelected: selectedAnswer == i,
                isCorrect: question.correctIndex == i,
                revealed: revealed,
                onTap: revealed ? null : () => _selectAnswer(i),
              ),
          ],
        );
    }
  }

  String _questionLabel() {
    switch (question.type) {
      case QuestionType.trueFalse:
        return 'Richtig oder falsch? · Frage ${questionIndex + 1}';
      case QuestionType.matching:
        return 'Zuordnen · Frage ${questionIndex + 1}';
      case QuestionType.fillBlank:
        return 'Lückentext · Frage ${questionIndex + 1}';
      case QuestionType.sequence:
        return 'Richtige Reihenfolge · Frage ${questionIndex + 1}';
      case QuestionType.oddOneOut:
        return 'Was passt nicht? · Frage ${questionIndex + 1}';
      case QuestionType.multiSelect:
        return 'Mehrfachauswahl · Frage ${questionIndex + 1}';
      case QuestionType.estimate:
        return 'Schätzfrage · Frage ${questionIndex + 1}';
      case QuestionType.multipleChoice:
        return 'Frage ${questionIndex + 1}';
    }
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

  void _onTapLeft(int leftIndex) {
    if (revealed) {
      return;
    }
    setState(() {
      activeLeft = (activeLeft == leftIndex) ? null : leftIndex;
    });
  }

  void _onTapRight(int rightPosition) {
    if (revealed || activeLeft == null) {
      return;
    }
    setState(() {
      // A right item can only be linked to one left item at a time.
      matchingSelections.removeWhere((_, value) => value == rightPosition);
      matchingSelections[activeLeft!] = rightPosition;
      activeLeft = null;
    });
  }

  void _onTapSequenceItem(int displayPos) {
    if (revealed) {
      return;
    }
    setState(() {
      if (sequenceOrder.contains(displayPos)) {
        sequenceOrder.remove(displayPos);
      } else {
        sequenceOrder.add(displayPos);
      }
    });
  }

  void _toggleMultiSelect(int index) {
    if (revealed) {
      return;
    }
    setState(() {
      if (multiSelected.contains(index)) {
        multiSelected.remove(index);
      } else {
        multiSelected.add(index);
      }
    });
  }

  /// Shared submit handler for every question type that needs an explicit
  /// "Prüfen" step (matching, sequence, multi-select, estimate) rather than
  /// revealing on the first tap.
  void _submit() {
    if (!canSubmit) {
      return;
    }
    setState(() {
      revealed = true;
      bool correct;
      switch (question.type) {
        case QuestionType.matching:
          final pairs = question.pairs!;
          correct = List.generate(pairs.length, (leftIndex) {
            final rightPosition = matchingSelections[leftIndex];
            if (rightPosition == null) return false;
            return shuffledRightIndices[rightPosition] == leftIndex;
          }).every((c) => c);
          break;
        case QuestionType.sequence:
          final items = question.sequenceItems!;
          correct = sequenceOrder.length == items.length &&
              List.generate(
                items.length,
                (k) => shuffledSequenceIndices[sequenceOrder[k]] == k,
              ).every((c) => c);
          break;
        case QuestionType.multiSelect:
          final correctSet = (question.correctIndices ?? const []).toSet();
          correct = multiSelected.length == correctSet.length && multiSelected.containsAll(correctSet);
          break;
        case QuestionType.estimate:
          final tolerance = question.estimateTolerance ?? 0.1;
          final range = question.estimateMax! - question.estimateMin!;
          correct = (estimateValue - question.estimateTarget!).abs() <= tolerance * range;
          break;
        case QuestionType.multipleChoice:
        case QuestionType.trueFalse:
        case QuestionType.oddOneOut:
        case QuestionType.fillBlank:
          correct = false;
          break;
      }
      if (correct) {
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
      revealed = false;
      _prepareCurrentQuestion();
    });
  }
}

class _NewTypeBadge extends StatelessWidget {
  const _NewTypeBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      decoration: BoxDecoration(
        color: AppColors.accentYellow.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.accentYellow, width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.auto_awesome_rounded, size: 16, color: AppColors.accentYellow),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              'Neuer Fragetyp freigeschaltet: $label',
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
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

/// Toggle-style card used by multi-select questions: tapping doesn't reveal
/// immediately, it just checks/unchecks the option until "Prüfen" is tapped.
class _MultiSelectCard extends StatelessWidget {
  const _MultiSelectCard({
    required this.label,
    required this.isSelected,
    required this.isCorrectAnswer,
    required this.revealed,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final bool isCorrectAnswer;
  final bool revealed;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    Color borderColor = Colors.transparent;
    Color backgroundColor = Colors.white;
    Color textColor = Colors.black87;
    double borderWidth = 0;
    IconData icon = Icons.check_box_outline_blank_rounded;
    Color iconColor = Colors.black38;

    if (!revealed && isSelected) {
      borderColor = AppColors.primary;
      backgroundColor = AppColors.primary.withValues(alpha: 0.15);
      textColor = AppColors.primary;
      borderWidth = 2;
      icon = Icons.check_box_rounded;
      iconColor = AppColors.primary;
    }

    if (revealed && isCorrectAnswer) {
      borderColor = const Color(0xFF2F9E44);
      backgroundColor = const Color(0xFF2F9E44).withValues(alpha: 0.20);
      borderWidth = 2;
      icon = Icons.check_box_rounded;
      iconColor = const Color(0xFF2F9E44);
    }

    if (revealed && isSelected && !isCorrectAnswer) {
      borderColor = AppColors.danger;
      backgroundColor = AppColors.danger.withValues(alpha: 0.20);
      borderWidth = 2;
      icon = Icons.indeterminate_check_box_rounded;
      iconColor = AppColors.danger;
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
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.22),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(icon, color: iconColor, size: 22),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: textColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Live preview shown above the answer chips for fillBlank questions —
/// substitutes the "___" placeholder in [template] with the currently
/// chosen word.
class _FillBlankPreview extends StatelessWidget {
  const _FillBlankPreview({required this.template, required this.filledWord});

  final String template;
  final String? filledWord;

  @override
  Widget build(BuildContext context) {
    final display = template.replaceFirst('___', filledWord ?? '______');
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        display,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
          height: 1.4,
        ),
      ),
    );
  }
}

/// Slider-based estimate question. Correctness is decided by
/// [QuizQuestion.estimateTolerance] (a fraction of the min-max range).
class _EstimateArea extends StatelessWidget {
  const _EstimateArea({
    required this.value,
    required this.min,
    required this.max,
    required this.target,
    required this.unit,
    required this.revealed,
    required this.onChanged,
  });

  final double value;
  final double min;
  final double max;
  final double target;
  final String? unit;
  final bool revealed;
  final ValueChanged<double>? onChanged;

  @override
  Widget build(BuildContext context) {
    final unitSuffix = unit == null ? '' : ' $unit';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.22),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            '${value.round()}$unitSuffix',
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w800, color: AppColors.primary),
          ),
          if (revealed) ...[
            const SizedBox(height: 6),
            Text(
              'Richtiger Wert: ${target.round()}$unitSuffix',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black54),
            ),
          ],
          const SizedBox(height: 12),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: revealed ? const Color(0xFF2F9E44) : AppColors.primary,
              thumbColor: revealed ? const Color(0xFF2F9E44) : AppColors.primary,
              overlayColor: AppColors.primary.withValues(alpha: 0.15),
            ),
            child: Slider(
              value: value.clamp(min, max),
              min: min,
              max: max,
              onChanged: onChanged,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${min.round()}$unitSuffix', style: const TextStyle(fontSize: 12, color: Colors.black45)),
              Text('${max.round()}$unitSuffix', style: const TextStyle(fontSize: 12, color: Colors.black45)),
            ],
          ),
        ],
      ),
    );
  }
}

/// Two-column tap-to-connect matching widget.
/// Tap a left item to select it, then tap a right item to link them.
/// Tapping a selected left item again deselects it.
class _MatchingArea extends StatelessWidget {
  const _MatchingArea({
    required this.pairs,
    required this.shuffledRightIndices,
    required this.selections,
    required this.activeLeft,
    required this.revealed,
    required this.onTapLeft,
    required this.onTapRight,
  });

  final List<MatchPair> pairs;
  final List<int> shuffledRightIndices;
  final Map<int, int> selections;
  final int? activeLeft;
  final bool revealed;
  final ValueChanged<int> onTapLeft;
  final ValueChanged<int> onTapRight;

  @override
  Widget build(BuildContext context) {
    // rightPosition -> leftIndex that claimed it (if any)
    final rightToLeft = <int, int>{
      for (final entry in selections.entries) entry.value: entry.key,
    };

    return Column(
      children: [
        for (var i = 0; i < pairs.length; i++) ...[
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: _MatchChip(
                    label: pairs[i].left,
                    badgeNumber: selections.containsKey(i) ? i + 1 : null,
                    isActive: activeLeft == i,
                    isCorrect: revealed
                        ? (selections[i] != null && shuffledRightIndices[selections[i]!] == i)
                        : null,
                    onTap: revealed ? null : () => onTapLeft(i),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _MatchChip(
                    label: pairs[shuffledRightIndices[i]].right,
                    badgeNumber: rightToLeft.containsKey(i) ? rightToLeft[i]! + 1 : null,
                    isActive: false,
                    isCorrect: revealed && rightToLeft.containsKey(i)
                        ? shuffledRightIndices[i] == rightToLeft[i]
                        : null,
                    onTap: revealed ? null : () => onTapRight(i),
                  ),
                ),
              ],
            ),
          ),
          if (i != pairs.length - 1) const SizedBox(height: 12),
        ],
      ],
    );
  }
}

/// Single-column tap-in-order widget for sequence questions. Tapping an
/// item appends it to the user's order (badge shows its position); tapping
/// an already-placed item removes it again.
class _SequenceArea extends StatelessWidget {
  const _SequenceArea({
    required this.items,
    required this.shuffledIndices,
    required this.order,
    required this.revealed,
    required this.onTapItem,
  });

  final List<String> items;
  final List<int> shuffledIndices;
  final List<int> order;
  final bool revealed;
  final ValueChanged<int> onTapItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var displayPos = 0; displayPos < shuffledIndices.length; displayPos++) ...[
          Builder(
            builder: (context) {
              final posInOrder = order.indexOf(displayPos);
              final badge = posInOrder == -1 ? null : posInOrder + 1;
              final isCorrect =
                  revealed && badge != null ? shuffledIndices[displayPos] == posInOrder : null;
              return _MatchChip(
                label: items[shuffledIndices[displayPos]],
                badgeNumber: badge,
                isActive: false,
                isCorrect: isCorrect,
                onTap: revealed ? null : () => onTapItem(displayPos),
              );
            },
          ),
          if (displayPos != shuffledIndices.length - 1) const SizedBox(height: 12),
        ],
      ],
    );
  }
}

class _MatchChip extends StatelessWidget {
  const _MatchChip({
    required this.label,
    required this.badgeNumber,
    required this.isActive,
    required this.isCorrect,
    required this.onTap,
  });

  final String label;
  final int? badgeNumber;
  final bool isActive;
  // null = not evaluated yet, true/false = correct/incorrect after reveal
  final bool? isCorrect;
  final VoidCallback? onTap;

  // Blue used while an item is placed/linked but not yet checked — distinct
  // from the app's primary color (active-selection state) and from the
  // green/red reveal colors.
  static const Color _pendingColor = Color(0xFF2F6FED);

  @override
  Widget build(BuildContext context) {
    // Border width stays constant across all states — only the color
    // changes (transparent = no visible border). Varying the width itself
    // was causing a subtle layout shift when a chip got selected.
    Color borderColor = Colors.transparent;
    Color backgroundColor = Colors.white;
    Color textColor = Colors.black87;
    const double borderWidth = 2;

    if (isActive) {
      borderColor = AppColors.primary;
      backgroundColor = AppColors.primary.withValues(alpha: 0.15);
      textColor = AppColors.primary;
    } else if (badgeNumber != null && isCorrect == null) {
      borderColor = _pendingColor;
      backgroundColor = _pendingColor.withValues(alpha: 0.10);
      textColor = _pendingColor;
    }

    if (isCorrect == true) {
      borderColor = const Color(0xFF2F9E44);
      backgroundColor = const Color(0xFF2F9E44).withValues(alpha: 0.20);
    } else if (isCorrect == false) {
      borderColor = AppColors.danger;
      backgroundColor = AppColors.danger.withValues(alpha: 0.20);
    }

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          constraints: const BoxConstraints(minHeight: 64),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: borderColor, width: borderWidth),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.15),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Fixed-height slot reserved whether or not a badge is
              // currently shown, so the chip's height (and therefore the
              // whole layout) never jumps when a number appears.
              SizedBox(
                height: 26,
                child: badgeNumber == null
                    ? null
                    : Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: 20,
                          height: 20,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isCorrect == false
                                ? AppColors.danger
                                : (isCorrect == true ? const Color(0xFF2F9E44) : _pendingColor),
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '$badgeNumber',
                            style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
              ),
              Text(
                label,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: textColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}