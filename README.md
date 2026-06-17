# viatolea Gamification Prototype

Clickable Flutter prototype for the viatolea gamification concept.

## Start

```bash
flutter pub get
flutter run -d chrome
```

The app is optimized for smartphone size. When opened on a wide desktop browser, it is displayed in a centered phone frame.

## Implemented in this version

- Home starts at **Tag 1 von 14**.
- Daily progress bar updates with the selected day.
- Current date changes with the simulated day.
- Three main meals per day: Frühstück, Mittagessen, Abendessen.
- `Nicht gegessen` also counts as completed and uses a check mark.
- The center plus button is docked above the bottom navigation.
- Plus button opens the add screen.
- `Mahlzeit hinzufügen` lets the user select Frühstück, Mittagessen or Abendessen.
- The plant resets every day and grows through four stages:
  - 0 entries: small sprout
  - 1 entry: stage 1
  - 2 entries: stage 2
  - 3 entries: stage 3 with hearts
- Knowledge path contains lessons 0 to 14.
- Lesson 0 is unlocked from the beginning.
- Lesson 1 to 14 unlock after the first meal entry of the respective day.
- Quiz for a day unlocks after the third meal entry of the respective day.
- Old lessons and old quizzes remain available and repeatable.
- Journal contains a prototype calendar to simulate moving to another day.

## Main files

```text
lib/main.dart
lib/app.dart
lib/state/app_state.dart
lib/screens/main_shell.dart
lib/screens/home_screen.dart
lib/screens/quick_add_screen.dart
lib/screens/journal_screen.dart
lib/screens/knowledge_path_screen.dart
```

## Notes

This is a click dummy/prototype. It does not use a backend and stores all state only in memory while the app is running.
