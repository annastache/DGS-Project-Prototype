import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../state/app_state.dart';
import '../widgets/top_brand_header.dart';

class JournalScreen extends StatelessWidget {
  const JournalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AppStateScope.of(context);

    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(18, 4, 18, 112),
        children: [
          const TopBrandHeader(),
          const Divider(height: 1, color: AppColors.primary),
          const SizedBox(height: 16),
          Text(
            'Journal',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColors.primary),
          ),
          const SizedBox(height: 8),
          const Text(
            'Kalender-Simulation für den Prototyp: Wähle einen anderen Tag, um zu zeigen, wie die Tagesfortschritte, Pflanze und Wissenspfad-Freischaltungen reagieren.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textSoft, height: 1.35),
          ),
          const SizedBox(height: 18),
          Card(
            elevation: 2,
            color: AppColors.surface,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      IconButton.filledTonal(
                        onPressed: controller.currentDay > 1 ? controller.previousDay : null,
                        icon: const Icon(Icons.chevron_left),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              'Tag ${controller.currentDay} von 14',
                              style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w900, color: AppColors.primary),
                            ),
                            Text(
                              controller.formattedCurrentDate,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.textSoft),
                            ),
                          ],
                        ),
                      ),
                      IconButton.filledTonal(
                        onPressed: controller.currentDay < 14 ? controller.nextDay : null,
                        icon: const Icon(Icons.chevron_right),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                    ),
                    onPressed: controller.currentDay < 14 ? controller.nextDay : null,
                    icon: const Icon(Icons.wb_sunny_outlined),
                    label: const Text('Neuen Tag starten', style: TextStyle(fontWeight: FontWeight.w800)),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            itemCount: 14,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.28,
            ),
            itemBuilder: (context, index) {
              final day = index + 1;
              return _DayCard(
                day: day,
                selected: day == controller.currentDay,
                mealEntries: controller.completedMealEntriesForDay(day),
                lessonUnlocked: controller.isLessonUnlocked(day),
                quizUnlocked: controller.unlockedQuizLessons.contains(day),
                onTap: () => controller.selectDay(day),
              );
            },
          ),
          
          // reset button - for test only --- remove after -------------------------------------------------------
          const SizedBox(height: 32),
          const Divider(color: AppColors.primaryLight),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.danger,
              side: const BorderSide(color: AppColors.danger, width: 1.5),
              padding: const EdgeInsets.symmetric(vertical: 13),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
            ),
            onPressed: () => _confirmReset(context, controller),
            icon: const Icon(Icons.refresh_rounded),
            label: const Text('App zurücksetzen', style: TextStyle(fontWeight: FontWeight.w700)),
          ),
          const SizedBox(height: 8),
          const Text(
            'Setzt alle Fortschritte zurück – nur für Testzwecke.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: AppColors.muted),
          ),
        ],
      ),
    );
  }

  void _confirmReset(BuildContext context, AppController controller) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('App zurücksetzen?', style: TextStyle(fontWeight: FontWeight.w800)),
        content: const Text('Alle Fortschritte, Mahlzeiten und Quiz-Ergebnisse werden gelöscht. Dies kann nicht rückgängig gemacht werden.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Abbrechen'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.danger,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
            ),
            onPressed: () {
              Navigator.pop(ctx);
              controller.reset();
            },
            child: const Text('Zurücksetzen', style: TextStyle(fontWeight: FontWeight.w700)),
          ),
        // reset button - for test only --- remove after -------------------------------------------------------

        ],
      ),
    );
  }
}

class _DayCard extends StatelessWidget {
  const _DayCard({
    required this.day,
    required this.selected,
    required this.mealEntries,
    required this.lessonUnlocked,
    required this.quizUnlocked,
    required this.onTap,
  });

  final int day;
  final bool selected;
  final int mealEntries;
  final bool lessonUnlocked;
  final bool quizUnlocked;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final borderColor = selected ? AppColors.primary : AppColors.primaryLight;
    final background = selected ? AppColors.primaryLight : AppColors.surface;

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: borderColor, width: selected ? 3 : 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Tag $day',
                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: AppColors.primary),
                  ),
                ),
                if (selected) const Icon(Icons.radio_button_checked, color: AppColors.primary, size: 18),
              ],
            ),
            const SizedBox(height: 8),
            _MiniStatus(icon: Icons.restaurant, label: '$mealEntries/3 Mahlzeiten'),
            _MiniStatus(
              icon: lessonUnlocked ? Icons.menu_book : Icons.lock_outline,
              label: lessonUnlocked ? 'Lektion offen' : 'Lektion gesperrt',
            ),
            _MiniStatus(
              icon: quizUnlocked ? Icons.quiz : Icons.lock_outline,
              label: quizUnlocked ? 'Quiz offen' : 'Quiz gesperrt',
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniStatus extends StatelessWidget {
  const _MiniStatus({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Row(
        children: [
          Icon(icon, size: 15, color: AppColors.textSoft),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: AppColors.textSoft),
            ),
          ),
        ],
      ),
    );
  }
}
