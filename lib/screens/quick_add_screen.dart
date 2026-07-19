import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../models/meal.dart';
import '../state/app_state.dart';
import '../widgets/top_brand_header.dart';
import '../widgets/symptom_picker.dart';

class QuickAddScreen extends StatelessWidget {
  const QuickAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AppStateScope.of(context);

    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 112),
        children: [
          const TopBrandHeader(),
          const Divider(height: 1, color: AppColors.primary),
          const SizedBox(height: 28),
          Text(
            'Hinzufügen',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColors.primary),
          ),
          const SizedBox(height: 8),
          Text(
            'Tag ${controller.currentDay}: ${controller.formattedCurrentDate}',
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.textSoft),
          ),
          const SizedBox(height: 24),
          _AddOption(
            icon: Icons.restaurant,
            label: 'Mahlzeit hinzufügen',
            subtitle: 'Frühstück, Mittagessen oder Abendessen eintragen',
            onTap: () => _showMealPicker(context),
          ),
          _AddOption(
            icon: Icons.add_circle,
            label: 'Snack hinzufügen',
            subtitle: 'Ein Ort für die kleinen Snacks',
            onTap: () => _addSnack(context),
          ),
           _AddOption(
            icon: Icons.health_and_safety,
            label: 'Symptom erfassen',
            subtitle: 'Bauchschmerzen, Müdigkeit und mehr eintragen',
            onTap: () => _goToHomeAndPickSymptom(context),
          ),
          const SizedBox(height: 20),
          const Text(
            'Für die Gamification zählt im Prototyp vor allem die Erfassung der drei Hauptmahlzeiten. Dadurch wächst die Pflanze und neue Inhalte werden freigeschaltet.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textSoft, height: 1.35),
          ),
        ],
      ),
    );
  }

   Future<void> _goToHomeAndPickSymptom(BuildContext context) async {   // TO
    final controller = AppStateScope.of(context);
    final selected = await showSymptomPicker(context);
    if (selected != null && context.mounted) {
      controller.requestPlantHearts();
      controller.setSelectedIndex(0);
    }
  }

  void _addSnack(BuildContext context) {
    final controller = AppStateScope.of(context);
    controller.requestPlantHearts();
    controller.setSelectedIndex(0);
  }

  void _showMealPicker(BuildContext context) {
    final controller = AppStateScope.of(context);
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      backgroundColor: AppColors.background,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Welche Mahlzeit möchtest du hinzufügen?',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.primary),
                ),
                const SizedBox(height: 12),
                for (var i = 0; i < controller.mealNames.length; i++)
                  Card(
                    color: AppColors.surface,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: ListTile(
                      leading: Icon(_mealIcon(i), color: AppColors.primary),
                      title: Text(
                        controller.mealNames[i],
                        style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.primary),
                      ),
                      subtitle: Text(controller.mealStatuses[i].label),
                      trailing: Icon(
                        controller.mealStatuses[i] == MealStatus.pending
                            ? Icons.add_circle
                            : Icons.check_circle_outline,
                        color: controller.mealStatuses[i] == MealStatus.pending
                            ? AppColors.accentYellow
                            : AppColors.primary,
                      ),
                      onTap: () {
                        controller.setMealStatus(i, MealStatus.eaten);
                        controller.requestPlantHearts();
                        Navigator.pop(sheetContext);
                        controller.setSelectedIndex(0);
                      },
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  IconData _mealIcon(int index) {
    return switch (index) {
      0 => Icons.free_breakfast,
      1 => Icons.lunch_dining,
      _ => Icons.dinner_dining,
    };
  }
}

class _AddOption extends StatelessWidget {
  const _AddOption({
    required this.icon,
    required this.label,
    required this.subtitle,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.surface,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        leading: Container(
          width: 44,
          height: 44,
          decoration: const BoxDecoration(color: AppColors.primaryLight, shape: BoxShape.circle),
          child: Icon(icon, color: AppColors.primary),
        ),
        title: Text(label, style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.primary)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right, color: AppColors.primary),
        onTap: onTap,
      ),
    );
  }
}
