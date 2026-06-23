import 'package:flutter/material.dart';

import '../models/meal.dart';

class AppController extends ChangeNotifier {
  int selectedIndex = 0;
  int currentDay = 1;
  int unlockedLessonIndex = 0;
  int? latestQuizHintLesson;
  bool knowledgeHintSeen = false;

  final DateTime startDate = DateTime(2026, 6, 15);
  final List<String> mealNames = const ['Frühstück', 'Mittagessen', 'Abendessen'];
  final Map<int, List<MealStatus>> _mealStatusesByDay = {};
  final Set<int> unlockedQuizLessons = <int>{};

  final Map<int, int> quizStarsByLesson = {};

  List<MealStatus> get mealStatuses => _mealStatusesByDay.putIfAbsent(
        currentDay,
        () => [MealStatus.pending, MealStatus.pending, MealStatus.pending],
      );

  DateTime get currentDate => startDate.add(Duration(days: currentDay - 1));
  int get completedMealEntries => mealStatuses.where((status) => status.countsForDayProgress).length;
  int get plantStage => completedMealEntries < 0 ? 0 : (completedMealEntries > 3 ? 3 : completedMealEntries);
  bool get todayStarted => completedMealEntries >= 1;
  bool get todayComplete => completedMealEntries == 3;
  bool get todayQuizUnlocked => unlockedQuizLessons.contains(currentDay);
  bool get showKnowledgeBadge => latestQuizHintLesson != null && !knowledgeHintSeen;

  String get formattedCurrentDate => _formatGermanDate(currentDate);

  int completedMealEntriesForDay(int day) {
    final statuses = _mealStatusesByDay[day];
    if (statuses == null) {
      return 0;
    }
    return statuses.where((status) => status.countsForDayProgress).length;
  }

  bool dayHasStarted(int day) => completedMealEntriesForDay(day) >= 1;
  bool dayIsComplete(int day) => completedMealEntriesForDay(day) == 3;

  void setSelectedIndex(int index) {
    selectedIndex = index;
    if (index == 4) {
      knowledgeHintSeen = true;
    }
    notifyListeners();
  }

  void openQuickAdd() {
    selectedIndex = 2;
    notifyListeners();
  }

  void selectDay(int day) {
    currentDay = _clampDay(day);
    selectedIndex = 0;
    notifyListeners();
  }

  void nextDay() {
    selectDay(_clampDay(currentDay + 1));
  }

  void previousDay() {
    selectDay(_clampDay(currentDay - 1));
  }

  void setMealStatus(int index, MealStatus status) {
    if (index < 0 || index >= mealNames.length) {
      return;
    }
    mealStatuses[index] = status;
    _applyUnlockRulesForCurrentDay();
    notifyListeners();
  }

  void resetMealStatus(int index) {
    if (index < 0 || index >= mealNames.length) {
      return;
    }
    mealStatuses[index] = MealStatus.pending;
    notifyListeners();
  }

  void markKnowledgeHintSeen() {
    if (!knowledgeHintSeen) {
      knowledgeHintSeen = true;
      notifyListeners();
    }
  }

  bool isLessonUnlocked(int lessonIndex) => lessonIndex <= unlockedLessonIndex;

  bool isQuizAvailable(int lessonIndex) {
    if (lessonIndex == 0) {
      return true;
    }
    return unlockedQuizLessons.contains(lessonIndex) || quizStarsByLesson.containsKey(lessonIndex);
  }

  int starsForLesson(int lessonIndex) => quizStarsByLesson[lessonIndex] ?? 0;

  void storeQuizResult({
    required int lessonIndex,
    required int correctAnswers,
    required int totalQuestions,
  }) {
    final normalized = totalQuestions <= 0 ? 0 : ((correctAnswers / totalQuestions) * 3).round();
    quizStarsByLesson[lessonIndex] = normalized < 0 ? 0 : (normalized > 3 ? 3 : normalized);
    knowledgeHintSeen = true;
    notifyListeners();
  }

  // reset logic - for test only --- remove after -------------------------------------------------------------------
  void reset() {
    selectedIndex = 0;
    currentDay = 1;
    unlockedLessonIndex = 0;
    latestQuizHintLesson = null;
    knowledgeHintSeen = false;
    _mealStatusesByDay.clear();
    unlockedQuizLessons.clear();
    quizStarsByLesson.clear();
    notifyListeners();
  }
  // reset logic - for test only --- remove after -------------------------------------------------------------------

  int _clampDay(int day) => day < 1 ? 1 : (day > 14 ? 14 : day);

  void _applyUnlockRulesForCurrentDay() {
    if (completedMealEntries >= 1 && currentDay > unlockedLessonIndex) {
      unlockedLessonIndex = currentDay;
    }

    if (completedMealEntries == 3 && currentDay > 0 && !unlockedQuizLessons.contains(currentDay)) {
      unlockedQuizLessons.add(currentDay);
      latestQuizHintLesson = currentDay;
      knowledgeHintSeen = false;
    }
  }

  String _formatGermanDate(DateTime date) {
    const weekdays = [
      'Montag',
      'Dienstag',
      'Mittwoch',
      'Donnerstag',
      'Freitag',
      'Samstag',
      'Sonntag',
    ];
    const months = [
      'Januar',
      'Februar',
      'März',
      'April',
      'Mai',
      'Juni',
      'Juli',
      'August',
      'September',
      'Oktober',
      'November',
      'Dezember',
    ];

    return '${weekdays[date.weekday - 1]}, ${date.day}. ${months[date.month - 1]} ${date.year}';
  }
}

class AppStateScope extends InheritedNotifier<AppController> {
  const AppStateScope({
    required AppController controller,
    required super.child,
    super.key,
  }) : super(notifier: controller);

  static AppController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppStateScope>();
    assert(scope != null, 'AppStateScope not found in widget tree');
    return scope!.notifier!;
  }
}