import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../state/app_state.dart';
import 'analysis_screen.dart';
import 'home_screen.dart';
import 'journal_screen.dart';
import 'knowledge_path_screen.dart';
import 'quick_add_screen.dart';

class MainShell extends StatelessWidget {
  const MainShell({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AppStateScope.of(context);
    final screens = <Widget>[
      const HomeScreen(),
      const JournalScreen(),
      const QuickAddScreen(),
      const AnalysisScreen(),
      const KnowledgePathScreen(),
    ];

    return Scaffold(
      extendBody: true,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 220),
        child: KeyedSubtree(
          key: ValueKey(controller.selectedIndex),
          child: screens[controller.selectedIndex],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 22),
        child: SizedBox(
          width: 54,
          height: 54,
          child: FloatingActionButton(
            heroTag: 'main-add-button',
            elevation: 7,
            highlightElevation: 4,
            backgroundColor: AppColors.fabMint,
            foregroundColor: AppColors.primary,
            shape: const CircleBorder(),
            onPressed: controller.openQuickAdd,
            child: const Icon(Icons.add_rounded, size: 30),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 70,
        color: AppColors.surface.withValues(alpha: 0.98),
        elevation: 16,
        notchMargin: 5,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _BottomTab(
              icon: Icons.home_outlined,
              selectedIcon: Icons.home,
              label: 'Home',
              selected: controller.selectedIndex == 0,
              onTap: () => controller.setSelectedIndex(0),
            ),
            _BottomTab(
              icon: Icons.calendar_month_outlined,
              selectedIcon: Icons.calendar_month,
              label: 'Journal',
              selected: controller.selectedIndex == 1,
              onTap: () => controller.setSelectedIndex(1),
            ),
            const SizedBox(width: 58),
            _BottomTab(
              icon: Icons.insights_outlined,
              selectedIcon: Icons.insights,
              label: 'Analyse',
              selected: controller.selectedIndex == 3,
              onTap: () => controller.setSelectedIndex(3),
            ),
            _BottomTab(
              icon: Icons.signpost_outlined,
              selectedIcon: Icons.signpost,
              label: 'Wissen',
              selected: controller.selectedIndex == 4,
              showBadge: controller.showKnowledgeBadge,
              onTap: () => controller.setSelectedIndex(4),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomTab extends StatelessWidget {
  const _BottomTab({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.selected,
    required this.onTap,
    this.showBadge = false,
  });

  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final bool selected;
  final bool showBadge;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.primary : AppColors.textSoft;

    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(selected ? selectedIcon : icon, color: color, size: 23),
                  if (showBadge)
                    Positioned(
                      right: -8,
                      top: -8,
                      child: Container(
                        width: 17,
                        height: 17,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Center(
                          child: Text(
                            '?',
                            style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w900),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 3),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 10, fontWeight: selected ? FontWeight.w800 : FontWeight.w600, color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
