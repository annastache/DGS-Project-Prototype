enum MealStatus {
  pending,
  eaten,
  skipped,
}

extension MealStatusLabel on MealStatus {
  String get label {
    switch (this) {
      case MealStatus.pending:
        return 'Offen';
      case MealStatus.eaten:
        return 'Erfasst';
      case MealStatus.skipped:
        return 'Nicht gegessen';
    }
  }

  bool get countsForDayProgress => this == MealStatus.eaten || this == MealStatus.skipped;
}
