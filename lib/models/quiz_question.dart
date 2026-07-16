enum QuestionType {
  multipleChoice,
  trueFalse,
  matching,
  fillBlank,
  sequence,
  oddOneOut,
  multiSelect,
  estimate,
}

/// A single left/right pair for a [QuestionType.matching] question.
/// `left` items are shown in a fixed column; `right` items are shown
/// shuffled and the user taps to connect each left item to its match.
class MatchPair {
  const MatchPair({
    required this.left,
    required this.right,
  });

  final String left;
  final String right;
}

class QuizQuestion {
  const QuizQuestion({
    required this.question,
    this.type = QuestionType.multipleChoice,
    this.answers = const [],
    this.correctIndex = 0,
    this.correctIndices,
    this.pairs,
    this.sequenceItems,
    this.estimateMin,
    this.estimateMax,
    this.estimateTarget,
    this.estimateUnit,
    this.estimateTolerance,
  })  : assert(
          type != QuestionType.matching || pairs != null,
          'Matching questions require a non-null `pairs` list.',
        ),
        assert(
          type != QuestionType.sequence || sequenceItems != null,
          'Sequence questions require a non-null `sequenceItems` list, given in the correct order.',
        ),
        assert(
          type != QuestionType.multiSelect || correctIndices != null,
          'Multi-select questions require a non-null `correctIndices` list.',
        ),
        assert(
          type != QuestionType.estimate ||
              (estimateMin != null && estimateMax != null && estimateTarget != null),
          'Estimate questions require `estimateMin`, `estimateMax` and `estimateTarget`.',
        );

  final String question;
  final QuestionType type;

  /// Used for [QuestionType.multipleChoice], [QuestionType.trueFalse],
  /// [QuestionType.oddOneOut] and [QuestionType.fillBlank].
  /// For `fillBlank`, `question` should contain a "___" placeholder that
  /// gets replaced with the chosen answer as a live preview.
  final List<String> answers;
  final int correctIndex;

  /// Used for [QuestionType.multiSelect] — indices into [answers] that are
  /// all correct. The user must select exactly this set.
  final List<int>? correctIndices;

  /// Used for [QuestionType.matching] only.
  final List<MatchPair>? pairs;

  /// Used for [QuestionType.sequence] only. Listed here in the CORRECT
  /// order; the UI shuffles them for display and the user taps them back
  /// into order.
  final List<String>? sequenceItems;

  /// Used for [QuestionType.estimate] only. The user drags a slider between
  /// [estimateMin] and [estimateMax] toward [estimateTarget].
  /// [estimateTolerance] is a fraction of the (max - min) range within which
  /// a guess still counts as correct (default 0.1 = within 10% of the range).
  final double? estimateMin;
  final double? estimateMax;
  final double? estimateTarget;
  final String? estimateUnit;
  final double? estimateTolerance;
}