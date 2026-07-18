import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../models/lesson.dart';
import '../state/app_state.dart';
import 'quiz_screen.dart';

class LessonDetailScreen extends StatelessWidget {
  const LessonDetailScreen({required this.lesson, super.key});

  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    final controller = AppStateScope.of(context);
    final quizAvailable = controller.isQuizAvailable(lesson.index);
    final hasQuizConcept = true;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.primary,
        titleSpacing: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              lesson.title,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
            ),
            Text(
              lesson.readingTime,
              style: const TextStyle(fontSize: 12, color: AppColors.textSoft),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(22, 14, 22, 28),
        children: [
          if (quizAvailable)
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 14),
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => QuizScreen(lesson: lesson),
                    ),
                  );
                },
                child: Text(
                  controller.starsForLesson(lesson.index) > 0 ? 'Quiz wiederholen' : 'Quiz starten',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          if (!quizAvailable && hasQuizConcept)
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Text(
                'Das Quiz zu dieser Lektion wird freigeschaltet, sobald an diesem Tag Frühstück, Mittagessen und Abendessen erledigt sind.',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.primaryDark),
              ),
            ),
          if (quizAvailable || hasQuizConcept) const SizedBox(height: 26),
          Text(
            'Lektion ${lesson.index}',
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: AppColors.textSoft),
          ),
          const SizedBox(height: 4),
          Text(
            lesson.title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColors.primary),
          ),
          const SizedBox(height: 12),
          Text(
            lesson.body,
            style: const TextStyle(fontSize: 17, height: 1.45, color: AppColors.text),
          ),
          const SizedBox(height: 22),
          if (lesson.index == 0) ...[
            Text(
              'So funktioniert die Erkennungsphase',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.primary),
            ),
            const SizedBox(height: 8),
            const Text(
              'Jeden Tag startet deine Pflanze klein. Durch die Tagesdokumentation wächst sie in vier Stufen. Der Wissenspfad begleitet dich parallel und schaltet neue Inhalte passend zu deinem Fortschritt frei.',

              style: TextStyle(fontSize: 17, height: 1.45, color: AppColors.text),
            ),
          ],
          if (lesson.index == 1) ...[
            Text('', style: TextStyle(fontSize: 17, height: 2)),
            Text(
              '1. Langsames Kauen',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.primary),
            ),
            const SizedBox(height: 8),
            const Text(
              'Kaue dein Essen gründlich und nimm dir Zeit dabei. Dadurch beginnt der Verdauungsprozess bereits im Mund, da die Nahrung besser zerkleinert und mit Speichel vermischt wird. Dies erleichtert die Arbeit deines Magen-Darm-Systems und kann Verdauungsbeschwerden reduzieren. Je gründlicher du kaust, desto besser.',
              style: TextStyle(fontSize: 17, height: 1.45, color: AppColors.text),
            ),
            Text('', style: TextStyle(fontSize: 17, height: 2)),
            Text(
              '2. Kleine Portionen',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.primary),
            ),
            const SizedBox(height: 8),
            const Text(
              'Vermeide es, riesige Portionen auf einmal zu essen. Nimm dir stattdessen kleinere Portionen und iss langsam. Dies hilft nicht nur, Überessen zu vermeiden, sondern unterstützt auch eine bessere Verdauung, da der Magen weniger stark belastet wird.',
              style: TextStyle(fontSize: 17, height: 1.45, color: AppColors.text),
            ),
            Text('', style: TextStyle(fontSize: 17, height: 2)),
            Image.asset('lib/pictures/overview_image_15749785_3496557.png'),
            Text(
              '3. Regelmäßige Essenszeiten',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.primary),
            ),
            const SizedBox(height: 8),
            const Text(
              'Unser Darm arbeitet besser, wenn er eine gewisse Routine hat. Ein regelmäßiger Mahlzeitenrhythmus kann dazu beitragen, dass die Verdauungsprozesse effizienter ablaufen, wodurch Verdauungsbeschwerden reduziert werden.',
              style: TextStyle(fontSize: 17, height: 1.45, color: AppColors.text),
            ),
            Text('', style: TextStyle(fontSize: 17, height: 2)),
            Text(
              '4. Vielfältige Ernährung',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.primary),
            ),
            const SizedBox(height: 8),
            const Text(
              'Um alle Nährstoffe aufzunehmen, die für eine gesunde Darmflora und effiziente Verdauungsprozesse notwendig sind, ist eine vielfältige und ausgewogene Ernährung wichtig. Insbesondere die Aufnahme von Ballaststoffen ist unverzichtbar für eine gesunde Verdauung.',
              style: TextStyle(fontSize: 17, height: 1.45, color: AppColors.text),
            ),
            Text('', style: TextStyle(fontSize: 17, height: 2)),
            Text(
              '5. Ausreichend trinken',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.primary),
            ),
            const SizedBox(height: 8),
            const Text(
              'Während des Essens kann eine moderate Wasserzufuhr dabei helfen, die Nahrung zu verdünnen und den Transport durch den Verdauungstrakt zu erleichtern. Trinke dazu ruhig ab und zu einen Schluck Wasser. Vermeide jedoch übermäßiges Trinken während der Mahlzeiten, da dies zu einer Verdünnung der Verdauungssäfte und damit zu einer Beeinträchtigung der Verdauung führen kann.',
              style: TextStyle(fontSize: 17, height: 1.45, color: AppColors.text),
            ),
          ],
          if (lesson.index == 2) ...[
            Text(
              'Allergie',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.primary),
            ),
            const SizedBox(height: 8),
            const Text(
              'Eine Nahrungsmittelallergie ist eine überempfindliche Reaktion des Immunsystems auf bestimmte Lebensmittelproteine. Dies führt zu einer sofortigen Reaktion, die oft schwerwiegend sein kann. Typische Symptome sind Hautausschläge, Juckreiz, Schwellungen, Atembeschwerden und sogar eine Anaphylaxie. Dabei handelt es sich um eine extrem schwere und lebensbedrohliche allergische Reaktion, die den gesamten Körper betrifft und eine schnelle Behandlung erfordert. Allergien werden durch spezifische Immunreaktionen verursacht, bei denen das Immunsystem fälschlicherweise ein harmloses Lebensmittelprotein als Bedrohung betrachtet und Antikörper gegen dieses Protein produziert.',
              style: TextStyle(fontSize: 17, height: 1.45, color: AppColors.text),
            ),
            Text('', style: TextStyle(fontSize: 17, height: 1.45)),
            Image.asset('lib/pictures/overview_image_259444708_3409114.png'),
            Text(
              'Unverträglichkeit',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.primary),
            ),
            const SizedBox(height: 8),
            const Text(
              'Eine Nahrungsmittelunverträglichkeit hingegen betrifft den Verdauungstrakt und ist meist weniger schwerwiegend als eine Allergie. Sie tritt auf, wenn der Körper Schwierigkeiten hat, bestimmte Nahrungsmittel zu verdauen oder zu verarbeiten. Symptome können Magenbeschwerden, Bauchschmerzen, Blähungen, Durchfall oder Verstopfung sein. Im Gegensatz zu Allergien sind Nahrungsmittelunverträglichkeiten oft verzögerte Reaktionen, die Stunden oder sogar Tage nach dem Verzehr des Lebensmittels auftreten können. Sie werden nicht durch das Immunsystem verursacht, sondern durch Probleme wie Enzymmangel (z.B. Laktoseintoleranz), Reizdarmsyndrom oder Nahrungsmittelintoleranz.',
              style: TextStyle(fontSize: 17, height: 1.45, color: AppColors.text),
            ),
            Text('', style: TextStyle(fontSize: 17, height: 1.45)),
            Text(
              'Fazit',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.primary),
            ),
            const SizedBox(height: 8),
            const Text(
              'Eine Nahrungsmittelunverträglichkeit hingegen betrifft den Verdauungstrakt und ist meist weniger schwerwiegend als eine Allergie. Sie tritt auf, wenn der Körper Schwierigkeiten hat, bestimmte Nahrungsmittel zu verdauen oder zu verarbeiten. Symptome können Magenbeschwerden, Bauchschmerzen, Blähungen, Durchfall oder Verstopfung sein. Im Gegensatz zu Allergien sind Nahrungsmittelunverträglichkeiten oft verzögerte Reaktionen, die Stunden oder sogar Tage nach dem Verzehr des Lebensmittels auftreten können. Sie werden nicht durch das Immunsystem verursacht, sondern durch Probleme wie Enzymmangel (z.B. Laktoseintoleranz), Reizdarmsyndrom oder Nahrungsmittelintoleranz.',
              style: TextStyle(fontSize: 17, height: 1.45, color: AppColors.text),
            ),
          ],
          if (lesson.index == 3) ...[
            Text(
              'Was misst der H₂ Atemtest?',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.primary),
            ),
            const SizedBox(height: 8),
            const Text(
              'Beim H₂ Atemtest wird gemessen, wie viel Wasserstoff (H₂) - und teilweise auch Methan (CH4) - in der Ausatemluft entsteht, nachdem eine festgelegte Menge eines Zuckers getrunken wurde. Kann dieser Zucker im Dünndarm nicht ausreichend aufgenommen werden, wird er von Darmbakterien vergoren. Die entstehenden Gase gelangen über das Blut in die Lunge und werden ausgeatmet. Da Wasserstoff im menschlichen Stoffwechsel kaum vorkommt, eignet er sich gut als Marker für eine Malabsorption.',
               style: TextStyle(fontSize: 17, height: 1.45, color: AppColors.text),
            ),
            Text('', style: TextStyle(fontSize: 17, height: 1.45)),
            Image.asset('lib/pictures/wissen01.png'),
            Text(
              'Was sind die Chancen und Grenzen des H₂ Atemtests?',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.primary),
            ),
            const SizedBox(height: 8),
            const Text(
              'Studien zeigen, dass der H₂ Atemtest bei klarer Symptomatik und guter Vorbereitung in vielen Fällen hilfreiche Hinweise auf Unverträglichkeiten liefert. Der Test wird in der Regel in gastroenterologischen oder spezialisierten internistischen Praxen durchgeführt, auch manche Hausärzt:innen und Kinderärtz:innen bieten ihn an. Allerdings ist er nicht überall verfügbar, und die Wartezeiten können je nach Region lang sein.',
              style: TextStyle(fontSize: 17, height: 1.45, color: AppColors.text),
            ),
          ],
          if (lesson.index == 4) ...[
            Image.asset('lib/pictures/wissen04.png'),
            Text(
              'Was meinen IgG-Tests mit "Unverträglichkeit"?',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.primary),
            ),
            const SizedBox(height: 8),
            const Text(
              'Medizinisch wird unterschieden, ob das Immunsystem beteiligt ist oder nicht. Während etwa allergische Reaktionen immunologisch vermittelt sind, haben Unverträglichkeiten wie Malabsorptionen oder Intoleranzen eine andere, nicht-immunologische Ursache, etwa Enzymmangel oder eine eingeschränkte Transportkapazität der Darmwand. IgG-Tests greifen hingegen auf eine alltagssprachliche Definition von „Unverträglichkeit" zurück, die immer greift, wenn du nach dem Essen etwas nicht verträgst. Dieses weit gefasste Verständnis macht die Tests anschlussfähiger für ein breites Zielpublikum, erschwert aber auch die Kommunikation über die Vielfalt tatsächlicher Beschwerden.',
               style: TextStyle(fontSize: 17, height: 1.45, color: AppColors.text),
            ),
            Text('', style: TextStyle(fontSize: 17, height: 1.45)),
            Text(
              'Was IgG-Tests messen - und was nicht',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.primary),
            ),
            const SizedBox(height: 8),
            const Text(
              'Ganz konkret messen IgG-Selbsttests Immunmarker - die sogenannten Immunglobuline (Ig) der Klasse G. Diese treten im Blut auf, wenn dein Immunsystem mit einem bestimmten Stoff (zum Beispiel Milch- oder Erdnussproteinen) schon einmal in Berührung gekommen ist. Statt anzuzeigen, ob dein Körper allergisch auf einen Stoff reagiert oder nicht, geben sie also lediglich Aufschluss darüber, wie vertraut dein Körper mit dem Stoff ist.',
              style: TextStyle(fontSize: 17, height: 1.45, color: AppColors.text),
            ),
            Text('', style: TextStyle(fontSize: 17, height: 1)),
            const Text(
              'Davon zu unterscheiden sind medizinische Blutanalysen auf IgE-Antikörper, also Immunglobuline der Klasse E. Anders als IgG-Antikörper, die als häufigster Antikörper-Typ im Blut als reine Kontaktmarker dienen, treten IgE-Antikörper bei tatsächlichen allergischen Reaktionen auf. Gerade deshalb gehört ihre Bestimmung in ärztliche Hände, ist entsprechend streng reguliert und nicht als Selbsttest erlaubt. Unverträglichkeiten im Sinne von Intoleranzen oder Malabsorptionen lassen sich zurzeit hingegen nicht über das Blut bestimmen.',
              style: TextStyle(fontSize: 17, height: 1.45, color: AppColors.text),
            ),
            Text('', style: TextStyle(fontSize: 17, height: 1.45)),
            Text(
              'Risiken von IgG-Tests',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.primary),
            ),
            const SizedBox(height: 8),
            const Text(
              'Der Trend zu Selbsttests aus der Drogerie hat in der Corona Pandemie an Fahrt aufgenommen. Das Prinzip „einfach selbst testen" wirkt inzwischen vertraut - und wird nun auf Bereiche übertragen, in denen die Zusammenhänge wesentlich komplexer sind. Anders als bei schlichten Fragen nach einem Ja/Nein Ergebnis bei Infektionen werden hier Antworten auf die Verträglichkeit tausender möglicher Lebensmittel gesucht.',
              style: TextStyle(fontSize: 17, height: 1.45, color: AppColors.text),
            ),
            Text('', style: TextStyle(fontSize: 17, height: 1)),
            const Text(
              'IgG-Tests zielen darauf ab, ein Gefühl von Selbstwirksamkeit und Klarheit zu vermitteln, das inhaltlich nicht einlösbar ist. Geld und Zeit fließen in eine Spur, die sich im Rückblick oft nicht bewährt - während sich die Suche nach den tatsächlichen Auslösern der Beschwerden verzögert.',
              style: TextStyle(fontSize: 17, height: 1.45, color: AppColors.text),
            ),
            Text('', style: TextStyle(fontSize: 17, height: 1)),
            const Text(
              'Die Logik von IgG-Tests läuft von vorneherein auf ein Missverständnis hinaus: Die Ergebnisse wirken wie eine persönliche Anleitung zur Eliminationsdiät, die man einhalten sollte, um Beschwerden zu vermeiden. Und da dein Körper mit häufig verzehrten Lebensmitteln besonders vertraut ist, tendieren IgG-Tests dazu, gerade auf deine Alltagsroutinen - dein Lieblingsessen besonders anzuschlagen.',
              style: TextStyle(fontSize: 17, height: 1.45, color: AppColors.text),
            ),
            Text('', style: TextStyle(fontSize: 17, height: 1)),
            const Text(
              'All das kann zu unnötigen und starken Einschränkungen führen. Statt eine niedrigschwellige Lösung zu bieten, legen die Ergebnisse eine weniger ausgewogene Ernährung nahe und verstärken potenziell ohnehin schon bestehende Unsicherheiten im Zusammenhang mit dem Essen.',
              style: TextStyle(fontSize: 17, height: 1.45, color: AppColors.text),
            ),
            Text('', style: TextStyle(fontSize: 17, height: 1)),
            const Text(
              'Rechtlich fallen IgG-Selbsttests unter die In vitro Diagnostika Verordnung als „Produkte zur Eigenanwendung" (IVDR Art. 2 (5)). Hersteller müssen lediglich nachweisen, dass das Gerät oder der Test das misst, was er vorgibt - ob also IgG-Antikörper im Blut erhöht sind. Wie aussagekräftig dieser Wert medizinisch ist, spielt für die Zulassung hingegen keine Rolle.',
              style: TextStyle(fontSize: 17, height: 1.45, color: AppColors.text),
            ),
             Text('', style: TextStyle(fontSize: 17, height: 1.45)),
             Text(
              'Was stattdessen sinnvoll ist',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.primary),
            ),
            const SizedBox(height: 8),
            const Text(
              'Ein Ernährungs und Symptomtagebuch ist ein sinnvoller erster Schritt, um im Alltag mögliche Muster zwischen Lebensmitteln, Verzehrsmengen und der Intensität von Beschwerden sichtbar zu machen. In Leitlinien werden dabei mindestens zwei aufeinanderfolgende Wochen empfohlen -dabei unterstützen wir dich bei viatolea!',
              style: TextStyle(fontSize: 17, height: 1.45, color: AppColors.text),
            ),
            Text('', style: TextStyle(fontSize: 17, height: 1)),
            const Text(
              'Für eine ärztliche Abklärung von Unverträglichkeiten sind gastroenterologische und internistische Praxen zuständig. Zur Diagnose kommen vor allem Atemtests zur Bestimmung von Wasserstoff (H2) oder Methan (CH4) zum Einsatz. Diese Gase entstehen bei der Verstoffwechselung von Zuckern durch Dickdarm-Bakterien und gelangen dann über das Blut in die Lunge. Ein Ernährungs- und Symptomtagebuch erleichtert die Diagnostik und gibt oft schnellere Erkenntnisse.',
              style: TextStyle(fontSize: 17, height: 1.45, color: AppColors.text),
            ),
            Text('', style: TextStyle(fontSize: 17, height: 1)),
            const Text(
              'Um herauszufinden, ob eine Allergie vorliegt, wird üblicherweise ein Pricktest auf der Haut durchgeführt oder spezifische IgE-Antikörper im Blut bestimmt. Allergien können potenziell schwere Reaktionen auslösen - deshalb ist eine professionelle Abklärung in einer dermatologischen oder allergologischen.',
              style: TextStyle(fontSize: 17, height: 1.45, color: AppColors.text),
            ),
          ],
          if (lesson.index == 5) ...[
            Image.asset('lib/pictures/wissen03.png'),
            Text(
              'Wärme anwenden',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.primary),
            ),
            const SizedBox(height: 8),
            const Text(
              'Lege dir eine Wärmflasche oder ein Heizkissen auf den schmerzenden Bauch. Die Wärme entspannt die Muskulatur und fördert die Durchblutung des Gewebes. Dies kann Krämpfe und Schmerzen lindern. Auch ein warmes Bad oder eine warme Dusche können helfen.',
              style: TextStyle(fontSize: 17, height: 1.45, color: AppColors.text),
            ),
            Text('', style: TextStyle(fontSize: 17, height: 1.45)),
            Text(
              'Tee trinken',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.primary),
            ),
            const SizedBox(height: 8),
            const Text(
              'Auch Kräutertees, wie Pfefferminz-, Kamillen-oder Fencheltee können dir dabei helfen, deine Beschwerden zu lindern. Sie haben beruhigende, entzündungshemmende und krampflösende Eigenschaften. Auch Ingwertee ist ein bewährtes Hausmittel bei Magenschmerzen, Blähungen, Übelkeit und Völlegefühl. Ingwer wirkt entzündungshemmend und krampflösend und regt die Verdauung an.',
              style: TextStyle(fontSize: 17, height: 1.45, color: AppColors.text),
            ),
            Text('', style: TextStyle(fontSize: 17, height: 1.45)),
            Text(
              'Leichte Bewegung',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.primary),
            ),
            const SizedBox(height: 8),
            const Text(
              'Ein kurzer Spaziergang kann die Verdauung anregen und möglicherweise helfen, eingeschlossene Gase zu lösen. Vermeide jedoch anstrengende Sportarten, da diese die Symptome verschlimmern könnten.',
              style: TextStyle(fontSize: 17, height: 1.45, color: AppColors.text),
            ),
            Text('', style: TextStyle(fontSize: 17, height: 1.45)),
            Text(
              'Atemübungen',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.primary),
            ),
            const SizedBox(height: 8),
            const Text(
              'Tiefe, langsame Bauchatmung kann dabei helfen, deinen Magen zu entspannen und deine Verdauungsbeschwerden zu lindern. Lege dazu deine Handflächen auf den Bereich des Magens. Atme tief ein und langsam wieder aus, sodass sich dein Bauch hebt und wieder senkt. Dabei kannst du deine Hände mit sanftem Druck im Uhrzeigersinn auf dem Bauch kreisen lassen. Diese Tipps können dir dabei helfen, akute Beschwerden wie Blähungen und Bauchschmerzen zu lindern. Probiere sie aus und finde heraus, was bei dir am besten wirkt.',
              style: TextStyle(fontSize: 17, height: 1.45, color: AppColors.text),
            ),
          ],
        ],
      ),
    );
  }
}