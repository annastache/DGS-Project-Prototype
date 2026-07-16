import 'package:flutter/material.dart';
//import 'package:timed_widget/timed_widget.dart'; //currently unused, but useful
import '../core/app_colors.dart';
import '../models/meal.dart';
import '../state/app_state.dart';
import '../widgets/action_tile.dart';
import '../widgets/plant_buddy2.dart';
import '../widgets/top_brand_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AppStateScope.of(context);

    return SafeArea(
      bottom: false,
      /*child: ListView(
        physics: const NeverScrollableScrollPhysics(), // stop screen from scrolling
        padding: const EdgeInsets.fromLTRB(18, 4, 18, 112), */
        //start layout fix
        child: LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children:[
            Padding(
          padding: const EdgeInsets.fromLTRB(18, 4, 18, 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            // Ende außer Klammern
        children: [
          const TopBrandHeader(),
          const Divider(height: 1, color: AppColors.primary),
          const SizedBox(height: 8),
          const Center(
            child: Text(
              'Erkennungsphase',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.primary),
            ),
          ),
          const SizedBox(height: 8),
          //const Spacer(flex: 1),
          Center(
            child: Text(
              'Tag ${controller.currentDay} von 14',
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: AppColors.text),
            ),
          ),
          const SizedBox(height: 6),
          //const Spacer(flex: 1),
         /* Row(
            children: [
              const Icon(Icons.accessibility_new, color: Colors.redAccent, size: 24),
              const SizedBox(width: 8),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    value: controller.currentDay / 14,
                    minHeight: 12,
                    backgroundColor: AppColors.primaryLight,
                    color: const Color(0xFF7FD18E),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.flag, color: Color(0xFF7FD18E), size: 24),
            ],
          ),*/
          _BudProgressRow(currentDay: controller.currentDay),

          //const Spacer(flex: 2),
          const SizedBox(height: 16),
          _ProgressHint(controller: controller),
        
         // const Spacer(flex: 3),
         
          const SizedBox(height: 16),
          //const Spacer(flex: 3),
          _MealCard(controller: controller),
          //const Spacer(flex: 3),
          //if (controller.todayQuizUnlocked) _SpeechBubble(day: controller.currentDay),
          const SizedBox(height: 90), // 12
          //const Spacer(), // ← füllt den leeren Raum oberhalb
          SizedBox(
          height: 220, //318 ---------------------------------------------------------------------------------      
               child: Stack(
              clipBehavior: Clip.none, // clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: 0,
                  bottom: 0, // 10
                  child: Column(                   
                    children: [
                      ActionTile(
                        icon: Icons.add_circle,
                        label: 'Snack\nhinzufügen',
                        onTap: controller.openQuickAdd,
                      ),
                      const ActionTile(icon: Icons.health_and_safety, label: 'Symptom\nerfassen', iconColor: Colors.redAccent),
                        /*ActionTile(
                          icon: Icons.search,
                          label: 'Lebensmittel\nsuchen',
                          onTap: controller.openQuickAdd,
                        ),*/
                      ActionTile(
                        icon: Icons.signpost_outlined,
                        label: 'Zum\nWissenspfad',
                        onTap: () => controller.setSelectedIndex(4),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 15,
                  bottom: 15,
                  child: PlantBuddy(
                    stage: controller.plantStage,
                    day: controller.currentDay,
                    size: 152, // 152
                  ),
                ),
                //if (controller.todayQuizUnlocked && controller.starsForLesson(controller.currentDay) == 0)  
                  Positioned(                                                                               
                    right: 4,                                                                                 
                    bottom: 209,                                                                              
                    child: _SpeechBubble(day: controller.currentDay),                                          
                  ),   
                
              ],
            ),
          ),
          
        ],
          ),
        ),
        if (!controller.hintDismissed && !controller.todayQuizUnlocked)           
            Positioned(                                                            
              top: 235,                                                             
              left: 18,                                                            
              right: 18,      
              height: 200,                                                     
              child: GestureDetector(                                              
                onTap: controller.dismissHint,                                     
                child: Container(                                                  
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(                                       
                    color: AppColors.primaryLight,                                 
                    borderRadius: BorderRadius.circular(8),                        
                  ),                                                               
                  child: const Row(                                                
                    children: [                                                    
                      Expanded(                                                    
                        child: Text(                                               
                          'Dokumentiere täglich:\n\nFrühstück,\nMittagessen\nund Abendessen.\n\n\nNach der ersten Mahlzeit wird die Tageslektion freigeschaltet, nach der dritten Mahlzeit das passende Quiz.', 
                          style: TextStyle(fontSize: 12.5, color: AppColors.text), textAlign: TextAlign.center,
                        ),                                                         
                      ),                                                           
                      SizedBox(width: 8),                                         
                      Icon(Icons.close, size: 16, color: AppColors.text),          
                    ],                                                             
                  ),                                                              
                ),                                                                 
              ),                                                             
            ),                                                               
                                                                                                                                                      
          ]
        );
      },
      ),
    );
  }
}

class _ProgressHint extends StatelessWidget {
  const _ProgressHint({required this.controller});

  final AppController controller;

  @override
  Widget build(BuildContext context) {
    final text = switch (controller.completedMealEntries) {
      0 => 'Deine Pflanze startet wieder klein.',
      1 => 'Wissenslektion ${controller.currentDay} ist jetzt offen.',
      2 => 'Noch ein Mahlzeiteintag bis zum Quiz.',
      _ => 'Quiz ${controller.currentDay} ist freigeschaltet!',
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.mint,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.trending_up, color: AppColors.text),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: AppColors.text),
            ),
          ),
        ],
      ),
    );
  }
}

class _MealCard extends StatelessWidget {
  const _MealCard({required this.controller});

  final AppController controller;

  @override
  Widget build(BuildContext context) {
    return Card(
      //elevation: 2,
      color: AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.formattedCurrentDate,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.primary),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${controller.completedMealEntries}/3 Tages-Einträge erledigt',
                        style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: AppColors.textSoft),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.calendar_month, color: AppColors.primary),
              ],
            ),
            const SizedBox(height: 10),
            for (var i = 0; i < controller.mealNames.length; i++)
              _MealRow(
                name: controller.mealNames[i],
                status: controller.mealStatuses[i],
                onTap: () => _showMealSheet(context, i),
              ),
          ],
        ),
      ),
    );
  }

  void _showMealSheet(BuildContext context, int index) {
    final controller = AppStateScope.of(context);
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      backgroundColor: AppColors.background,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.mealNames[index],
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.primary),
                ),
                const SizedBox(height: 12),
                ListTile(
                  leading: const Icon(Icons.check_circle_outline, color: AppColors.primary),
                  title: const Text('Mahlzeit erfasst'),
                  onTap: () {
                    controller.setMealStatus(index, MealStatus.eaten);
                    Navigator.pop(sheetContext);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.check_circle_outline, color: AppColors.textSoft),
                  title: const Text('Nicht gegessen'),
                  onTap: () {
                    controller.setMealStatus(index, MealStatus.skipped);
                    Navigator.pop(sheetContext);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.refresh, color: AppColors.danger),
                  title: const Text('Zurücksetzen'),
                  onTap: () {
                    controller.resetMealStatus(index);
                    Navigator.pop(sheetContext);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _MealRow extends StatelessWidget {
  const _MealRow({required this.name, required this.status, required this.onTap});

  final String name;
  final MealStatus status;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final (icon, color) = switch (status) {
      MealStatus.pending => (Icons.add_circle, AppColors.accentYellow),
      MealStatus.eaten => (Icons.check_circle_outline, const Color(0xFF7BCB86)),
      MealStatus.skipped => (Icons.check_circle_outline, AppColors.muted),
    };
    final label = status == MealStatus.skipped ? '$name  ·  nicht gegessen' : name;

    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Icon(icon, color: color, size: 26),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.text),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BudProgressRow extends StatelessWidget {
  const _BudProgressRow({required this.currentDay});

  final int currentDay;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(14, (i) {
        final day = i + 1;
        final bloomed = day < currentDay;   
        final isToday = day == currentDay;

        return Icon(
          bloomed || isToday ? Icons.local_florist : Icons.spa,   
          size: isToday ? 26 : 18,
          color: bloomed
              ?    AppColors.primary
              : (isToday ?  const Color.fromARGB(255, 31, 109, 0) : const Color.fromARGB(255, 183, 201, 182)),
        );
      }),
    );
  }
}
 // static const primaryDark = Color(0xFF557255); AppColors.primary; const Color.fromARGB(255, 54, 100, 36)

class _SpeechBubble extends StatelessWidget {
  const _SpeechBubble({required this.day});

  final int day;
  String _bubbleText(AppController controller) {
    final unlocked = controller.todayQuizUnlocked;
    final stars = controller.starsForLesson(controller.currentDay);

    return switch ((unlocked, stars)) {
      (false, _) => 'Füge alle Mahlzeiten hinzu, um das Quiz freizuschalten!',
      (true, 0) => 'Klasse! Du hast alle Mahlzeiten hinzugefügt und Quiz $day freigeschaltet!',
      (true, 1) => 'Gut gemacht! Vielleicht schaffst du beim nächsten Versuch noch mehr Sterne?',
      (true, 2) => 'Fast perfekt! Nur noch ein Stern bis zur Bestleistung!',
      (true, 3) => 'Perfekt! Du hast alle Sterne für heute geholt!',
      (true, _) => 'Weiter so!',
    };
  }

   @override
  Widget build(BuildContext context) {
    final controller = AppStateScope.of(context);
    return InkWell(
      onTap: () => controller.setSelectedIndex(4),
      child: Column(                                   
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,     // tail hugs the right side, toward the plant
        children: [
          ConstrainedBox(                                  //  caps the bubble's width
            constraints: const BoxConstraints(maxWidth:350), 
          child: Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColors.primary, width: 2),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Text(
              _bubbleText(controller),
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700),
            ),
          ),
          ),
          Transform.translate(                        
            offset: const Offset(0, -2),
            child: Padding(
              padding: const EdgeInsets.only(right: 34),
              child: CustomPaint(
                size: const Size(22, 12),
                painter: const _BubbleTailPainter(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class _BubbleTailPainter extends CustomPainter {
  const _BubbleTailPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(size.width * 0.15, 0)
      ..lineTo(size.width * 0.75, 0)
      ..lineTo(size.width * 0.3, size.height)
      ..close();

    canvas.drawPath(path, Paint()..color = Colors.white);
    canvas.drawPath(
      path,
      Paint()
        ..color = AppColors.primary
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

