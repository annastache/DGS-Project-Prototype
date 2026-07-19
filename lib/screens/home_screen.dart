import 'package:flutter/material.dart';
//import 'package:timed_widget/timed_widget.dart'; //currently unused, but useful
import '../core/app_colors.dart';
import '../models/meal.dart';
import '../state/app_state.dart';
import '../widgets/action_tile.dart';
import '../widgets/plant_buddy2.dart';
import '../widgets/top_brand_header.dart';
import 'lesson_detail_screen.dart'; 
import '../core/mock_data.dart';  
import '../widgets/symptom_picker.dart';
import 'dart:math' as math;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _plantKey = GlobalKey<PlantBuddyState>();   
 

  Future<void> _selectSymptom(BuildContext context) async {
     final controller = AppStateScope.of(context);
    final selected = await showSymptomPicker(context);
    if (selected != null) {
       controller.requestPlantHearts();
    }
  }
  /*Future<void> _selectSymptom(BuildContext context) async {   
    const symptoms = [
      'Bauchschmerzen',
      'Übelkeit',
      'Kopfschmerzen',
      'Müdigkeit',
      'Blähungen',
      'Sodbrennen',
    ];

    final selected = await showModalBottomSheet<String>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Welches Symptom möchtest du erfassen?',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                ),
              ),
              for (final symptom in symptoms)
                ListTile(
                  title: Text(symptom),
                  onTap: () => Navigator.pop(context, symptom),
                ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );

    if (selected != null) {
      _plantKey.currentState?.triggerHearts();
    }
  }*/
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final controller = AppStateScope.of(context);
    if (controller.pendingPlantHearts) {
      controller.consumePlantHeartsRequest();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _plantKey.currentState?.triggerHearts();
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    final controller = AppStateScope.of(context);
    final grassGrowth = ((controller.currentDay - 2) / 12).clamp(0.0, 1.0);

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
          const SizedBox(height: 6),
          //const Spacer(flex: 1),
          Center(
            child: Text(
              'Tag ${controller.currentDay} von 14',
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: AppColors.text),
            ),
          ),
          const SizedBox(height: 5),
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
          const SizedBox(height: 10),
          //_ProgressHint(controller: controller),
          GestureDetector(
            onTap: controller.todayStarted
                ? () => _goToTodaysLesson(context, controller)
                : null,
            child: _ProgressHint(controller: controller),
          ),
        
         // const Spacer(flex: 3),
         
          const SizedBox(height: 10),
          //const Spacer(flex: 3),
          _MealCard(controller: controller),
          //const Spacer(flex: 3),
          //if (controller.todayQuizUnlocked) _SpeechBubble(day: controller.currentDay),
          //const SizedBox(height: 90), // 12
          const Spacer(), // ← füllt den leeren Raum oberhalb
          //------------------------------------ Add-Boxen ---------------------------------------
          SizedBox(
          height: 220, //318  
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
                      ActionTile(                                                                                                 // TO
                        icon: Icons.health_and_safety,
                        label: 'Symptom\nerfassen',
                        iconColor: Colors.redAccent,
                        onTap: () => _selectSymptom(context),
                      ),
                      ActionTile(
                        icon: Icons.signpost_outlined,
                        label: 'Zum\nWissenspfad',
                        onTap: () => controller.setSelectedIndex(4),
                      ),
                    ],
                  ),
                ),
                //---------------------------------- Grass_Background ---------------------------------------------------
                if (controller.currentDay >= 5)                        
                  Positioned(
                    right: -13,
                    bottom: 45,
                    child: _GrassRow_background(growth: grassGrowth),
                  ),
                if (controller.currentDay >= 5)
                  Positioned(
                    right: -16,
                    bottom: 20,
                    child: _GrassRow_background_near(growth: grassGrowth),
                  ),
                //+++++++++++++++++++++++++++++++++++ plantBuddy ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                Positioned(
                  right: 15,
                  bottom: 15,
                  child: PlantBuddy(
                    key: _plantKey,
                    stage: controller.plantStage,
                    day: controller.currentDay,
                    size: 140, // 152
                  ),
                ),
                //----------------------------------- Butterfly --------------------------------------------------------
                 if (controller.currentDay == 2 || controller.currentDay == 7 || controller.currentDay == 13)                       
                  const Positioned(    
                    right:  85,
                    bottom: 140,
                    child: _Butterfly(),
                  ),
                  if (controller.currentDay == 14)                       
                  const Positioned(    
                    right:  85,
                    bottom: 125,
                    child: _Butterfly(),
                  ),
                  //----------------------------------- Bee --------------------------------------------------------
                  if (controller.currentDay == 4 || controller.currentDay == 10 || controller.currentDay == 14)  
                  const Positioned(                  
                    right: 15 + 76 - 6,
                    bottom: 184,
                    child: _Bee(),
                  ),   
                  //---------------------------------- Grass ---------------------------------------------------
                if (controller.currentDay >= 3)                          
                  Positioned(
                    right: - 30,
                    bottom: - 20,
                    child: _GrassRow(growth: grassGrowth),
                  ),
                //if (controller.todayQuizUnlocked && controller.starsForLesson(controller.currentDay) == 0)  
                 /* Positioned(                                                                               
                    right: 4,                                                                                 
                    bottom: 209,                                                                              
                    child: _SpeechBubble(day: controller.currentDay),                                          
                  ),   */
                
              ],
            ),
          ),
          
        ],
          ),
        ),
        //------------------------------------------- Onboarding Hinweis --------------------------------------------------------------
        if (!controller.hintDismissed && !controller.todayQuizUnlocked)           
            Positioned(                                                            
              top: 228,                                                             
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
                          'Dokumentiere hier täglich:\n\nFrühstück,\nMittagessen\nund Abendessen.\n\n\nNach der ersten Mahlzeit wird die Tageslektion freigeschaltet, nach der dritten Mahlzeit das passende Quiz.', 
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
            //---------------------------------------- Speech Bubble ----------------------------------------------------------                                                         
            Positioned(                                                        
          right: 19,                                                          
          top: 435,                                                          
          child: GestureDetector(
            onTap: controller.todayStarted
            ? () => _goToTodaysLesson(context, controller)
            : null,
            child: _SpeechBubble(day: controller.currentDay),
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

class _GrassRow extends StatelessWidget {
  const _GrassRow({required this.growth});

  final double growth;

  @override
  Widget build(BuildContext context) {
    final scale = 0.35 + 0.65 * growth;
    return IgnorePointer(   
      child: SizedBox(
        width: 190,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: List.generate(2, (i) {
            return Icon(
              Icons.grass,
              size: (i.isEven ? 78 : 68) * scale, // 22 : 16
              color: i.isEven ? const Color.fromARGB(255, 67, 141, 70) : const Color(0xFF6FBF73),
              
            );
          }),
        ),
      ),
    );
  }
}

class _GrassRow_background extends StatelessWidget {
  const _GrassRow_background({required this.growth});

   final double growth;

  @override
  Widget build(BuildContext context) {
    final scale = 0.35 + 0.65 * growth;
    return IgnorePointer(   
      child: SizedBox(
        width: 220,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: List.generate(9, (i) {
            return Icon(
              Icons.grass,
              size: (i.isEven ? 14 : 10) * scale,
              color: i.isEven ? const Color(0xFF6FBF73) : const Color(0xFF6FBF73),
              
            );
          }),
        ),
      ),
    );
  }
}

class _GrassRow_background_near extends StatelessWidget {
  const _GrassRow_background_near({required this.growth});

  final double growth;

  @override
  Widget build(BuildContext context) {
    final scale = 0.35 + 0.65 * growth;
    return IgnorePointer(   
      child: SizedBox(
        width: 240,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: List.generate(5, (i) {
            return Icon(
              Icons.grass,
              size: (i.isEven ? 26 : 32) * scale,
              color: i.isEven ? const Color(0xFF6FBF73) : const Color(0xFF6FBF73),
              
            );
          }),
        ),
      ),
    );
  }
}

class _Butterfly extends StatefulWidget {
  const _Butterfly();

  @override
  State<_Butterfly> createState() => _ButterflyState();
}

class _ButterflyState extends State<_Butterfly> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(  
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          const activeFraction = 1;   
          final v = _controller.value;

          final t = v < activeFraction   
              ? (v / activeFraction) * 2 * math.pi   
              : 0.0;
          final dx = 24 * math.cos(t); 
          final dy = 14 * math.sin(t * 2);
          final movingLeft = math.sin(t) < 0;

          return Transform.translate(
            offset: Offset(dx, dy),
            child: Transform.flip(
              flipX: movingLeft,
              child: CustomPaint(                                        
                size: const Size(26, 22),
                painter: _CuteButterflyPainter(wingFlap: math.sin(v * 30 * math.pi)),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CuteButterflyPainter extends CustomPainter {
  const _CuteButterflyPainter({required this.wingFlap});

  final double wingFlap;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // Flügel: zwei Paare, oben größer, unten kleiner
    final wingFill = Paint()..color = const Color(0xFFFFC9E0);
    final wingStroke = Paint()
      ..color = const Color(0xFFE58AB5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

     void drawWingPair(double dxOffset, double dyOffset, double w, double h) {
      final closeAmount = wingFlap.abs();        
      final widthScale = 0.35 + 0.65 * closeAmount; 
      final xOffset = dxOffset * (0.4 + 0.6 * closeAmount); 
      for (final side in [-1.0, 1.0]) {
        canvas.save();
        canvas.translate(center.dx + side * xOffset, center.dy + dyOffset);   
        canvas.scale(side * widthScale, 1);                                   
        final oval = Rect.fromCenter(center: Offset.zero, width: w, height: h);
        canvas.drawOval(oval, wingFill);
        canvas.drawOval(oval, wingStroke);
        canvas.restore();
      }
    }

    drawWingPair(6, -2, 12, 11);
    drawWingPair(5, 5, 8, 7); 

    // Körper: schmales rundes Oval in der Mitte
    final bodyRect = Rect.fromCenter(center: center, width: 4, height: 14);
    canvas.drawRRect(
      RRect.fromRectAndRadius(bodyRect, const Radius.circular(2)),
      Paint()..color = const Color(0xFF6B4A3A),
    );

    // Süße Punktaugen und Fühler
    final facePaint = Paint()..color = const Color(0xFF3A3A3A);
    canvas.drawCircle(Offset(center.dx - 1.2, center.dy - 5), 1.0, facePaint);
    canvas.drawCircle(Offset(center.dx + 1.2, center.dy - 5), 1.0, facePaint);

    final antennaPaint = Paint()
      ..color = const Color(0xFF6B4A3A)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(center.dx - 1, center.dy - 7), Offset(center.dx - 3, center.dy - 10), antennaPaint);
    canvas.drawLine(Offset(center.dx + 1, center.dy - 7), Offset(center.dx + 3, center.dy - 10), antennaPaint);
    canvas.drawCircle(Offset(center.dx - 3, center.dy - 10), 1.2, Paint()..color = const Color(0xFF6B4A3A));
    canvas.drawCircle(Offset(center.dx + 3, center.dy - 10), 1.2, Paint()..color = const Color(0xFF6B4A3A));
  }

  @override
  bool shouldRepaint(covariant _CuteButterflyPainter oldDelegate) => oldDelegate.wingFlap != wingFlap;
}

class _Bee extends StatefulWidget {
  const _Bee();

  @override
  State<_Bee> createState() => _BeeState();
}

class _BeeState extends State<_Bee> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          const activeFraction = 1;
          final v = _controller.value;

          final t = v < activeFraction
              ? (v / activeFraction) * 2 * math.pi
              : 0.0;

          final dx = 22 * math.cos(t);        // radius um blüte
          final dy = 12 * math.sin(t * 2);
          final movingLeft = math.sin(t) < 0;
          final wingFlap = math.sin(v * 40 * math.pi);

          return Transform.translate(
            offset: Offset(dx, dy),
            child: Transform.flip(
              flipX: movingLeft,
              child: CustomPaint(                                
                size: const Size(22, 18),
                painter: _CuteBeePainter(wingFlap: wingFlap),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CuteBeePainter extends CustomPainter {
  const _CuteBeePainter({required this.wingFlap});

  final double wingFlap;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2 + 2);

    // Flügel (leicht hinter dem Körper, flattern per Skalierung)
    final wingFill = Paint()..color = const Color(0xFFEAF6FF); 
    final wingStroke = Paint()                                               
      ..color = const Color(0xFFB8DDF2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    final wingScale = 0.7 + 0.3 * wingFlap.abs();
    canvas.save();
    canvas.translate(center.dx - 3, center.dy - 5);
    canvas.scale(1, wingScale);
    canvas.drawOval(const Rect.fromLTWH(-6, -4, 7, 6), wingFill);
    canvas.drawOval(const Rect.fromLTWH(-6, -4, 7, 6), wingStroke);
    canvas.restore();
    canvas.save();
    canvas.translate(center.dx + 3, center.dy - 5);
    canvas.scale(1, wingScale);
    canvas.drawOval(const Rect.fromLTWH(-1, -4, 7, 6), wingFill);
    canvas.drawOval(const Rect.fromLTWH(-1, -4, 7, 6), wingStroke); 
    canvas.restore();

    // Körper (rundlich, gelb-schwarz gestreift)
    const bodyRadius = 8.0;
    canvas.drawCircle(center, bodyRadius, Paint()..color = const Color(0xFFFFC94D));

    canvas.save();
    canvas.clipPath(Path()..addOval(Rect.fromCircle(center: center, radius: bodyRadius)));
    final stripePaint = Paint()..color = const Color(0xFF3A3A3A);
    for (final dy in [0.5, 5.0]) {
      canvas.drawRect(
        Rect.fromCenter(center: Offset(center.dx, center.dy + dy), width: 18, height: 2.6),
        stripePaint,
      );
    }
    canvas.restore();

    // Süße Punktaugen
    final eyePaint = Paint()..color = const Color(0xFF3A3A3A);
    canvas.drawCircle(Offset(center.dx - 3.5, center.dy - 3), 1.3, eyePaint);
    canvas.drawCircle(Offset(center.dx + 3.5, center.dy - 3), 1.3, eyePaint);

    // Kleiner Stachel
    final path = Path()
      ..moveTo(center.dx, center.dy + 6)
      ..lineTo(center.dx - 1.5, center.dy + 9)
      ..lineTo(center.dx + 1.5, center.dy + 9)
      ..close();
    canvas.drawPath(path, Paint()..color = const Color(0xFF3A3A3A));
  }

  @override
  bool shouldRepaint(covariant _CuteBeePainter oldDelegate) => oldDelegate.wingFlap != wingFlap;
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
    return Column(                                     
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 350),
          child: Material(                              
            color: Colors.transparent,                  
            child: /*InkWell(                             
              borderRadius: BorderRadius.circular(24),   
              onTap: () {
                if (controller.todayStarted) {
                  _goToTodaysLesson(context, controller);
                }
              },
              child: */Container(
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
              //),
            ),
          ),
        ),
        Transform.translate(
          offset: const Offset(0, -2),
          child: Padding(
            padding: const EdgeInsets.only(right: 34),
            child: CustomPaint(
              size: const Size(22, 12),
              painter: const _BubbleTailPainter()
              ),
            ),
          ),
        ],
       
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

void _goToTodaysLesson(BuildContext context, AppController controller) {
  final lesson = demoLessons.firstWhere(
    (l) => l.index == controller.currentDay,
    orElse: () => demoLessons.first,
  );
  Navigator.of(context).push(
    MaterialPageRoute<void>(
      builder: (_) => LessonDetailScreen(lesson: lesson),
    ),
  );
}