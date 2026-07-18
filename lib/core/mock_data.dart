import '../models/lesson.dart';
import '../models/quiz_question.dart';

const demoLessons = <Lesson>[
  Lesson(
    index: 0,
    title: 'Einleitung',
    readingTime: '1 Minute Lesezeit',
    body: '''Willkommen in der Erkennungsphase. In den nächsten Tagen dokumentierst du Mahlzeiten und Symptome. Dadurch entsteht eine Grundlage, auf der dein Ernährungsberater eine aussagekräftige Analyse erstellen kann.
    Hier im Wissenspfad erhälts du dazu passende Lektionen: kurze, verständliche Einblicke rund um Lebensmittelunverträglichkeiten, Diagnostik und einen gesunden Alltag. Jede Lektion schaltest du frei, sobald du an dem Tag eine Mahlzeiten dokumentiert hast.
    Wenn du alle drei Mahlzeiten er Tages eingetragen hast wartet ein kurzes Quiz mit drei Fragen auf dich. Damit kannst du dein neues Wissen direkt anwenden und bis zu drei Sterne sammeln. 
    ''',
  ),
 
  Lesson(
    index: 1,
    title: 'Wie du deine Verdauung verbessern kannst',
    readingTime: '2 Minuten Lesezeit',
    body: '''Wie du deine Verdauung verbessern kannst

Lebensmittelunverträglichkeiten können zu vielfältigen unangenehmen Verdauungsbeschwerden führen. Gesunde Essgewohnheiten können dazu beitragen, die allgemeine Verdauung zu verbessern und Beschwerden zu lindern. Im Folgenden haben wir dir fünf Tipps zusammengestellt, wie auch du deine Verdauung fördern kannst:

1. Langsames Kauen

Kaue dein Essen gründlich und nimm dir Zeit dabei. Dadurch beginnt der Verdauungsprozess bereits im Mund, da die Nahrung besser zerkleinert und mit Speichel vermischt wird. Dies erleichtert die Arbeit deines Magen-Darm-Systems und kann Verdauungsbeschwerden reduzieren. Je gründlicher du kaust, desto besser.

2. Kleine Portionen

Vermeide es, riesige Portionen auf einmal zu essen. Nimm dir stattdessen kleinere Portionen und iss langsam. Dies hilft nicht nur, Überessen zu vermeiden, sondern unterstützt auch eine bessere Verdauung, da der Magen weniger stark belastet wird.

3. Regelmäßige Essenszeiten

Unser Darm arbeitet besser, wenn er eine gewisse Routine hat. Ein regelmäßiger Mahlzeitenrhythmus kann dazu beitragen, dass die Verdauungsprozesse effizienter ablaufen, wodurch Verdauungsbeschwerden reduziert werden.

4. Vielfältige Ernährung

Um alle Nährstoffe aufzunehmen, die für eine gesunde Darmflora und effiziente Verdauungsprozesse notwendig sind, ist eine vielfältige und ausgewogene Ernährung wichtig. Insbesondere die Aufnahme von Ballaststoffen ist unverzichtbar für eine gesunde Verdauung.

5. Ausreichend trinken

Während des Essens kann eine moderate Wasserzufuhr dabei helfen, die Nahrung zu verdünnen und den Transport durch den Verdauungstrakt zu erleichtern. Trinke dazu ruhig ab und zu einen Schluck Wasser. Vermeide jedoch übermäßiges Trinken während der Mahlzeiten, da dies zu einer Verdünnung der Verdauungssäfte und damit zu einer Beeinträchtigung der Verdauung führen kann.''',
  ),
  Lesson(
    index: 2,
    title: 'Lebensmittelallergie vs. Unverträglichkeiten',
    readingTime: '2 Minuten Lesezeit',
    body: '''Oft hört man die Begriffe "Allergie" und "Unverträglichkeit" und viele verwenden sie sogar synonym. Aber was bedeuten sie eigentlich genau und wie unterscheiden sie sich voneinander?

Allergie

Eine Nahrungsmittelallergie ist eine überempfindliche Reaktion des Immunsystems auf bestimmte Lebensmittelproteine. Dies führt zu einer sofortigen Reaktion, die oft schwerwiegend sein kann. Typische Symptome sind Hautausschläge, Juckreiz, Schwellungen, Atembeschwerden und sogar eine Anaphylaxie. Dabei handelt es sich um eine extrem schwere und lebensbedrohliche allergische Reaktion, die den gesamten Körper betrifft und eine schnelle Behandlung erfordert. Allergien werden durch spezifische Immunreaktionen verursacht, bei denen das Immunsystem fälschlicherweise ein harmloses Lebensmittelprotein als Bedrohung betrachtet und Antikörper gegen dieses Protein produziert

Unverträglichkeit

Eine Nahrungsmittelunverträglichkeit hingegen betrifft den Verdauungstrakt und ist meist weniger schwerwiegend als eine Allergie. Sie tritt auf, wenn der Körper Schwierigkeiten hat, bestimmte Nahrungsmittel zu verdauen oder zu verarbeiten. Symptome können Magenbeschwerden, Bauchschmerzen, Blähungen, Durchfall oder Verstopfung sein. Im Gegensatz zu Allergien sind Nahrungsmittelunverträglichkeiten oft verzögerte Reaktionen, die Stunden oder sogar Tage nach dem Verzehr des Lebensmittels auftreten können. Sie werden nicht durch das Immunsystem verursacht, sondern durch Probleme wie Enzymmangel (z.B. Laktoseintoleranz), Reizdarmsyndrom oder Nahrungsmittelintoleranz.

Fazit

Es ist überaus wichtig, zwischen einer Allergie und einer Unverträglichkeit zu unterscheiden, da sowohl die Auswirkungen als auch die Behandlung unterschiedlich sind. Allergien erfordern oft eine strikte Vermeidung des auslösenden Lebensmittels und möglicherweise die Verwendung von Notfallmedikamenten. Unverträglichkeiten können zwar sehr unangenehme Beschwerden verursachen, sind aber in der Regel nicht lebensbedrohlich. Oft können zudem kleine Mengen toleriert werden oder es stehen Enzympräparate zur Verfügung, die bei der Verdauung unterstützen können. Während nur 2-5% der Deutschen von Allergien betroffen sind, liegt bei etwa 25-30% der Bevölkerung eine Lebensmittelunverträglichkeit vor. Solltest du von einer Unverträglichkeit betroffen sein, werden wir diese erkennen und dich unterstützen. Bei allergischen Symptomen solltest du umgehend einen Arzt aufsuchen.
''',
  ),
  Lesson(
    index: 3,
    title: 'Atemtests zur Diagnose von Unverträglichkeiten 2',
    readingTime: '1 Minute Lesezeit',
    body: '''Der H2 Atemtest ist eines der wichtigsten Verfahren zur Abklärung von Nahrungsmittelunverträglichkeiten. Für Fruktose und Laktosemalabsorption gilt er als diagnostischer Goldstandard, auch eine Sorbitmalabsorption kann damit untersucht werden.

Was misst der H₂ Atemtest?

Beim H₂ Atemtest wird gemessen, wie viel Wasserstoff (H₂) - und teilweise auch Methan (CH4) - in der Ausatemluft entsteht, nachdem eine festgelegte Menge eines Zuckers getrunken wurde.

Kann dieser Zucker im Dünndarm nicht ausreichend aufgenommen werden, wird er von Darmbakterien vergoren. Die entstehenden Gase gelangen über das Blut in die Lunge und werden ausgeatmet.

Da Wasserstoff im menschlichen Stoffwechsel kaum vorkommt, eignet er sich gut als Marker für eine Malabsorption.

Was sind die Chancen und Grenzen des H2 Atemtests?

Studien zeigen, dass der H₂ Atemtest bei klarer Symptomatik und guter Vorbereitung in vielen Fällen hilfreiche Hinweise auf Unverträglichkeiten liefert.

Der Test wird in der Regel in gastroenterologischen oder spezialisierten internistischen Praxen durchgeführt, auch manche Hausärzt:innen und Kinderärtz:innen bieten ihn an. Allerdings ist er nicht überall verfügbar, und die Wartezeiten können je nach Region lang sein.

Wenngleich der H₂-Atemtest der Goldstandard ist, hat er wie alle diagnostischen Tests -seine Grenzen. Sowohl falsch negative als auch falsch positive Ergebnisse können vorkommen zum Beispiel bei Menschen, die sogenannte Non-H2-Producer sind oder eine Darmfehlbesiedelung (SIBO) haben.

Deshalb sollte ein Testergebnis nicht für sich allein, sondern im Zusammenhang mit Symptomen und im Gesamtbild bewertet werden.
''',
  ),
  Lesson(
    index: 4,
    title: 'Lebensmittelreaktionstest und IgG-Selbsttests',
    readingTime: '4 Minuten Lesezeit',
    body: '''Wenn du schon länger versuchst, die Ursache für diffuse Beschwerden einzugrenzen, bist du in der Drogerie oder im Internet vielleicht s einmal auf Selbsttests gestoßen. Sie versprechen, dass du ganz einfach selbst herausfinden kannst, was die Lösung ist kleiner Piks, dann deine Probe einschicker kurz darauf flattert dir eine Liste unverträg Lebensmittel ins Haus. Diese Selbsttests basieren in der Regel auf einer Messung sogenannter IgG- Antikörper im Blut.

Aus medizinischer Sicht bereiten IgG-Tests jedoch Sorgen: Denn dieser Antikörper-Typ zeigt nur an, womit der Körper in Kontakt war und nicht, was er tatsächlich verträgt oder nicht verträgt. Diese Lebensmittel wegzulassen, führt zu unnötigen Einschränkungen und verzögert die Suche nach den tatsächlichen Auslösern deiner Beschwerden.

Was meinen IgG-Tests mit Unverträglichkeit"?

Medizinisch wird unterschieden, ob das Immunsystem beteiligt ist oder nicht. Während etwa allergische Reaktionen immunologisch vermittelt sind, haben Unverträglichkeiten wie Malabsorptionen oder Intoleranzen eine andere, nicht-immunologische Ursache, etwa Enzymmangel oder eine eingeschränkte Transportkapazität der Darmwand.

IgG-Tests greifen hingegen auf eine alltagssprachliche Definition von „Unverträglichkeit" zurück, die immer greift, wenn du nach dem Essen etwas nicht verträgst. Dieses weit gefasste Verständnis macht die Tests anschlussfähiger für ein breites Zielpublikum, erschwert aber auch die Kommunikation über die Vielfalt tatsächlicher Beschwerden.

Was IgG-Tests messen nicht und was

Ganz konkret messen IgG-Selbsttests Immunmarker - die sogenannten Immunglobuline (Ig) der Klasse G. Diese treten im Blut auf, wenn dein Immunsystem mit einem bestimmten Stoff (zum Beispiel Milch- oder Erdnussproteinen) schon einmal in Berührung gekommen ist. Statt anzuzeigen, ob dein Körper allergisch auf einen Stoff reagiert oder nicht, geben sie also lediglich Aufschluss darüber, wie vertraut dein Körper mit dem Stoff ist.

Davon zu unterscheiden sind medizinische Blutanalysen auf IgE-Antikörper, also Immunglobuline der Klasse E. Anders als IgG-Antikörper, die als häufigster Antikörper-Typ im Blut als reine Kontaktmarker dienen, treten IgE-Antikörper bei tatsächlichen allergischen Reaktionen auf. Gerade deshalb gehört ihre Bestimmung in ärztliche Hände, ist entsprechend streng reguliert und nicht als Selbsttest erlaubt.

Unverträglichkeiten im Sinne von Intoleranzen oder Malabsorptionen lassen sich zurzeit hingegen nicht über das Blut bestimmen.
Der Trend zu Selbsttests aus der Drogerie hat in der Corona Pandemie an Fahrt aufgenommen. Das Prinzip „einfach selbst testen" wirkt inzwischen vertraut - und wird nun auf Bereiche übertragen, in denen die Zusammenhänge wesentlich komplexer sind. Anders als bei schlichten Fragen nach einem Ja/Nein Ergebnis bei Infektionen werden hier Antworten auf die Verträglichkeit tausender möglicher Lebensmittel gesucht.

IgG-Tests zielen darauf ab, ein Gefühl von Selbstwirksamkeit und Klarheit zu vermitteln, das inhaltlich nicht einlösbar ist. Geld und Zeit fließen in eine Spur, die sich im Rückblick oft nicht bewährt - während sich die Suche nach den tatsächlichen Auslösern der Beschwerden verzögert.

Die Logik von IgG-Tests läuft von vorneherein auf ein Missverständnis hinaus: Die Ergebnisse wirken wie eine persönliche Anleitung zur Eliminationsdiät, die man einhalten sollte, um Beschwerden zu vermeiden. Und da dein Körper mit häufig verzehrten Lebensmitteln besonders vertraut ist, tendieren IgG-Tests dazu, gerade auf deine Alltagsroutinen - dein Lieblingsessen besonders anzuschlagen.

All das kann zu unnötigen und starken Einschränkungen führen. Statt eine niedrigschwellige Lösung zu bieten, legen die Ergebnisse eine weniger ausgewogene
Ernährung nahe und verstärken potenziell ohnehin schon bestehende Unsicherheiten im Zusammenhang mit dem Essen.

Rechtlich fallen IgG-Selbsttests unter die In vitro Diagnostika Verordnung als „Produkte zur Eigenanwendung" (IVDR Art. 2 (5)). Hersteller müssen lediglich nachweisen, dass das Gerät oder der Test das misst, was er vorgibt - ob also IgG-Antikörper im Blut erhöht sind. Wie aussagekräftig dieser Wert medizinisch ist, spielt für die Zulassung hingegen keine Rolle.

Was stattdessen sinnvoll ist

Ein Ernährungs und Symptomtagebuch ist ein sinnvoller erster Schritt, um im Alltag mögliche Muster zwischen Lebensmitteln, Verzehrsmengen und der Intensität von Beschwerden sichtbar zu machen. In Leitlinien werden dabei mindestens zwei aufeinanderfolgende Wochen empfohlen -dabei unterstützen wir dich bei viatolea!

Für eine ärztliche Abklärung von Unverträglichkeiten sind gastroenterologische und internistische Praxen zuständig. Zur Diagnose kommen vor allem Atemtests zur Bestimmung von Wasserstoff (H2) oder Methan (CH4) zum Einsatz. Diese Gase entstehen bei der Verstoffwechselung von Zuckern durch Dickdarm-Bakterien und gelangen dann über das Blut in die Lunge. Ein Ernährungs- und Symptomtagebuch erleichtert die Diagnostik und gibt oft schnellere Erkenntnisse.

Um herauszufinden, ob eine Allergie vorliegt, wird üblicherweise ein Pricktest auf der Haut durchgeführt oder spezifische IgE-Antikörper im Blut bestimmt. Allergien können potenziell schwere Reaktionen auslösen - deshalb ist eine professionelle Abklärung in einer dermatologischen oder allergologischen''',
  ),
  Lesson(
    index: 5,
    title: 'Tipps zur Linderung von Bauchschmerzen',
    readingTime: '2 Minuten Lesezeit',
    body: '''Was dir bei Blähungen und Bauchschmerzen hilft

Nahrungsmittelunverträglichkeiten können unangenehme Symptome wie Blähungen und Bauchschmerzen verursachen und damit das tägliche Leben erheblich beeinträchtigen.

Heute möchten wir dir einige Tipps mitgeben, um akute Beschwerden lindern zu können:

Wärme anwenden

Lege dir eine Wärmflasche oder ein Heizkissen auf den schmerzenden Bauch. Die Wärme entspannt die Muskulatur und fördert die Durchblutung des Gewebes. Dies kann Krämpfe und Schmerzen lindern. Auch ein warmes Bad oder eine warme Dusche können helfen.

Tee trinken

Auch Kräutertees, wie Pfefferminz-, Kamillen-oder Fencheltee können dir dabei helfen, deine Beschwerden zu lindern. Sie haben beruhigende, entzündungshemmende und krampflösende Eigenschaften. Auch Ingwertee ist ein bewährtes Hausmittel bei Magenschmerzen, Blähungen, Übelkeit und Völlegefühl. Ingwer wirkt entzündungshemmend und krampflösend und regt die Verdauung an.

Leichte Bewegung

Ein kurzer Spaziergang kann die Verdauung anregen und möglicherweise helfen, eingeschlossene Gase zu lösen. Vermeide jedoch anstrengende Sportarten, da diese die Symptome verschlimmern könnten.

Atemübungen

Tiefe, langsame Bauchatmung kann dabei helfen, deinen Magen zu entspannen und deine Verdauungsbeschwerden zu lindern. Lege dazu deine Handflächen auf den Bereich des Magens. Atme tief ein und langsam wieder aus, sodass sich dein Bauch hebt und wieder senkt.

Dabei kannst du deine Hände mit sanftem Druck im Uhrzeigersinn auf dem Bauch kreisen lassen.

Diese Tipps können dir dabei helfen, akute Beschwerden wie Blähungen und Bauchschmerzen zu lindern. Probiere sie aus und finde heraus, was bei dir am besten wirkt.
''',
  ),
  Lesson(
    index: 6,
    title: 'Tipps bei Durchfall',
    readingTime: '2 Minuten Lesezeit',
    body: '''Durchfall zählt zu den häufigsten Verdauungsbeschwerden – und kann den Körper rasch aus dem Gleichgewicht bringen. Mit den folgenden Maßnahmen unterstützt du deine Darmgesundheit und hilfst deinem Körper, sich zu regenerieren.

1. Flüssigkeit ist jetzt besonders wichtig

Durchfall entzieht dem Körper viel Wasser. Trinke regelmäßig kleine Mengen stilles Wasser oder Kräutertee wie Kamille und Fenchel – beide beruhigen zusätzlich den Verdauungstrakt. Ein verbreiteter Irrtum ist, dass Cola bei Durchfall hilft – tatsächlich können Zucker und Koffein die Symptome sogar verschlimmern.

2. Elektrolyte auffüllen – so geht’s

Mit der Flüssigkeit verliert der Körper auch wichtige Mineralstoffe wie Natrium und Kalium. Elektrolytlösungen aus der Apotheke sind ideal, aber auch salzige Brühe oder Kokoswasser können helfen. Du kannst auch selbst eine einfache Lösung mischen: 1 Liter Wasser, ½ Teelöffel Salz und 4 Teelöffel Zucker. Diese Mischung stabilisiert den Kreislauf und stärkt die Darmbarriere.

3. Sanfte Ernährung für den gereizten Darm

Bei akutem Durchfall ist Schonkost das A und O. Leicht verdauliche Lebensmittel wie Bananen, Reis, gekochte Karotten, Kartoffeln oder Haferflocken schonen den Darm und unterstützen die Regeneration der Darmflora. Vermeide dagegen fettige, stark gewürzte oder schwer verdauliche Speisen sowie Milchprodukte – sie können die Symptome verschlimmern, besonders bei einer bestehenden Nahrungsmittelunverträglichkeit.

4. Ruhe hilft dem Darm, sich zu erholen

Stress kann Durchfall verstärken und die Verdauung zusätzlich belasten. Gönn dir Ruhe, lege dich hin, atme bewusst durch oder mache kurze Entspannungsübungen. So gibst du deinem Körper die Chance, wieder ins Gleichgewicht zu kommen.

5. Nicht ignorieren: Ein Fall für die Ärztin oder den Arzt

Beobachte deine Symptome aufmerksam. Wenn Durchfall länger als zwei Tage anhält, von Fieber oder Schmerzen begleitet wird oder regelmäßig wiederkehrt, solltest du ärztlichen Rat einholen. Das gilt auch bei auffälligen Veränderungen im Stuhlgang – um mögliche Infektionen oder chronische Verdauungserkrankungen rechtzeitig zu erkennen.

''',
  ),
  Lesson(
    index: 7,
    title: 'Sport und Unverträglichkeiten',
    readingTime: '2 Minuten Lesezeit',
    body: '''Eine intensive Trainingseinheit kann den Darm für einige Stunden empfindlicher machen. Längerfristig hat regelmäßige Bewegung insgesamt vor allem positive Effekte auf die Verdauung. Beides ist gut belegt und erklärt, warum du deinen Bauch an Trainingstagen manchmal stärker spürst.

Was passiert im Darm während intensiver Belastung?

Bei moderater bis hoher Intensität verlagert der Körper Blut und Sauerstoff in die arbeitenden Muskeln. Der Darm wird vorübergehend weniger durchblutet (,,splanchnische Hypoperfusion"). In Studien zeigt sich dabei, dass die Darmzellen kurzzeitig unter Stress geraten und die Darmwand etwas durchlässiger wird. Dadurch kann der Darm während intensiver Belastung sensibler reagieren - manche Menschen spüren dann eher Krämpfe, Druck, Übelkeit oder ein stärkeres Rumoren.

Wie Sport deinen Darm langfristig stärkt

Wenn du regelmäßig in einem für dich passenden Tempo trainierst, gewöhnt sich dein Darm an diese Belastung (Hormesis-Prinzip). Der leichte Stress während des Sports führt langfristig zu positiven Veränderungen: Die (,,Tight Darmzellen, ihre Verbindungen (,,T Junctions) und die schutzende Schleimschicht arbeiten besser zusammen. Die Darmbarriere kann dadurch wirksamer arbeiten. Das trägt langfristig dazu bei, dass du insgesamt weniger zu Magen-Darm-Beschwerden neigst.

Gut zu wissen: 

Die Darmbarriere trennt den Darminhalt vom Körperinneren. Sie sorgt dafür, dass Nährstoffe ins Blut gelangen, während unerwünschte Stoffe draußen bleiben. Dadurch spielt sie eine enorm wichtige Rolle für unser Immunsystem sowie unser gesamtes Wohlbefinden.


Drei Tipps für die Praxis

Ein kurzer Spaziergang kann die Verdauung anregen und möglicherweise helfen, eingeschlossene Gase zu lösen. Vermeide jedoch anstrengende Sportarten, da diese die Symptome verschlimmern könnten.

Gib dir Zeit zur Verdauung: 

Plane zwischen „größerer" Mahlzeit und intensiver Einheit 1-3 Stunden Abstand ein, damit sich dein Magen schon vorher in den Dünndarm entleeren kann. So vermeidest du, dass Essen während der Belastung im Magen „stehen bleibt". Das beugt Übelkeit und Bauchschmerzen vor.

Gut zu wissen: 

Generell solltest du vor dem Training eher kohlenhydratreiche Mahlzeiten zu dir nehmen, die nur eine Magenverweildauer von 1-3 Stunden haben, während fettreiche Mahlzeiten dir über 4-6 Stunden „schwer" im Magen liegen können.

Starte gut hydriert in deine Sporteinheit: Ausreichend zu trinken, hält das Blutvolumen und die Körpertemperatur stabiler. Da bei einer Sporteinheit sowieso schon weniger Blut in deinen Bauchraum fließt, ist dein Bauch durch bessere Flüssigkeitsversorgung besser vor Belastung geschützt.

Finde deine richtige Intensität: 

Wenn du an bestimmten Tagen empfindlicher reagierst, reduziere z.B. Tempo oder Dauer deiner Sporteinheit etwas. Leichter bis moderater Sport ist oft besser verträglich und hat trotzdem positive Effekte auf den Darm.''',
  ),
  Lesson(
    index: 8,
    title: 'Einfluss von stress auf deine Verdauung',
    readingTime: '5 Minute Lesezeit',
    body: 'Unsere Ernährungsexperten bearbeiten diese Lektion gerade für dich.',
  ),
  Lesson(
    index: 9,
    title: 'Gesunde Ernährung',
    readingTime: '3 Minuten Lesezeit',
    body: 'Unsere Ernährungsexperten bearbeiten diese Lektion gerade für dich.',
  ),
  Lesson(
    index: 10,
    title: 'Bewegung im Alltag',
    readingTime: '1 Minute Lesezeit',
    body: 'Unsere Ernährungsexperten bearbeiten diese Lektion gerade für dich.',
  ),
  Lesson(
    index: 11,
    title: 'Analyse vorbereiten',
    readingTime: '2 Minuten Lesezeit',
    body: 'Unsere Ernährungsexperten bearbeiten diese Lektion gerade für dich.',
  ),
  Lesson(
    index: 12,
    title: 'Lebensmittelguide verstehen',
    readingTime: '2 Minuten Lesezeit',
    body: 'Unsere Ernährungsexperten bearbeiten diese Lektion gerade für dich.',
  ),
  Lesson(
    index: 13,
    title: 'Empfehlungen anwenden',
    readingTime: '2 Minuten Lesezeit',
    body: 'Unsere Ernährungsexperten bearbeiten diese Lektion gerade für dich.',
  ),
  Lesson(
    index: 14,
    title: 'Ziel erreicht',
    readingTime: '1 Minute Lesezeit',
    body: 'Unsere Ernährungsexperten bearbeiten diese Lektion gerade für dich.',
  ),
];


/// Quiz-Fragen gruppiert nach Lektion (Key = Lesson.index).
/// Jede Lektion hat genau 3 Fragen.
///
/// Fragetypen-Freischaltung: Lektion 0 ist die App-Einführung und bleibt
/// bewusst reines Multiple Choice, damit die Grundmechanik zuerst ohne
/// Überraschungen sitzt. Ab Lektion 1 wird in jeder Lektion GENAU EIN neuer
/// Fragetyp eingeführt (siehe _typeUnlockLesson in quiz_screen.dart), bevor
/// er ab Lektion 8 frei mit den bereits freigeschalteten Typen gemischt wird:
///   0 Baseline (App-Erklärung) · 1 Richtig/Falsch · 2 Was passt nicht? ·
///   3 Lückentext · 4 Mehrfachauswahl · 5 Zuordnen · 6 Reihenfolge ·
///   7 Schätzfrage
///
/// Lektionen 8-14: Inhalte sind noch nicht final (leerer/Platzhalter-Body),
/// deshalb bekommen sie bewusst neutrale "Kommt bald"-Platzhalterfragen
/// statt inhaltlicher Fragen. Sobald echter Lektionstext vorliegt, einfach
/// den jeweiligen Block ersetzen.
const demoQuizQuestionsByLesson = <int, List<QuizQuestion>>{
  // --- 0: App-Erklärung — reines Multiple Choice, keine Lektion-Inhalte,
  // sondern die Grundmechanik der App selbst ---
  0: [
    QuizQuestion(
      question: 'Was musst du an einem Tag erledigen, damit sich das Tages-Quiz freischaltet?',
      answers: ['Alle 3 Mahlzeiten dokumentieren', 'Nur eine Mahlzeit dokumentieren', 'Eine Lektion lesen', 'Nichts, es ist immer offen'],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: 'Wie viele Fragen hat ein Quiz zu einer Lektion normalerweise?',
      answers: ['Drei', 'Eine', 'Fünf', 'Zehn'],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: 'Wofür bekommst du Sterne im Quiz?',
      answers: ['Für richtig beantwortete Fragen', 'Für das Öffnen der App', 'Für das Lesen der Lektion', 'Für falsche Antworten'],
      correctIndex: 0,
    ),
  ],

  // --- 1: Unlock Richtig/Falsch ---
  1: [
    QuizQuestion(
      question: 'Was kann laut Lektion helfen, die Verdauung zu verbessern?',
      answers: ['Langsames Kauen', 'Sehr schnelles Essen', 'Große Portionen auf einmal', 'Essen ohne Pausen'],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: 'Wie viele Tipps zur Verdauung werden in der Lektion genannt?',
      answers: ['Fünf', 'Zwei', 'Zehn', 'Drei'],
      correctIndex: 0,
    ),
    QuizQuestion(
      type: QuestionType.trueFalse,
      question: 'Ausreichend zu trinken kann laut Lektion die Verdauung unterstützen.',
      answers: ['Richtig', 'Falsch'],
      correctIndex: 0,
    ),
  ],

  // --- 2: Unlock "Was passt nicht?" (Odd-one-out) ---
  2: [
    QuizQuestion(
      question: 'Was unterscheidet Allergien von Unverträglichkeiten grundsätzlich?',
      answers: ['Allergien sind immer ungefährlich', 'Unverträglichkeiten betreffen nur die Haut', 'Allergien betreffen das Immunsystem', 'Es gibt keinen Unterschied'],
      correctIndex: 2,
    ),
    QuizQuestion(
      type: QuestionType.trueFalse,
      question: 'Allergien und Unverträglichkeiten können ähnliche Beschwerden auslösen.',
      answers: ['Richtig', 'Falsch'],
      correctIndex: 0,
    ),
    QuizQuestion(
      type: QuestionType.oddOneOut,
      question: 'Welche Aussage passt NICHT zu Nahrungsmittelallergien?',
      answers: [
        'Sie werden vom Immunsystem ausgelöst',
        'Sie können bis zur Anaphylaxie reichen',
        'Sie betreffen etwa 2-5% der Deutschen',
        'Sie sind meist verzögerte Reaktionen, die erst Tage später auftreten',
      ],
      correctIndex: 3,
    ),
  ],

  // --- 3: Unlock Lückentext (Fill-in-blank) ---
  3: [
    QuizQuestion(
      question: 'Wofür gilt der H₂-Atemtest laut Lektion als diagnostischer Goldstandard?',
      answers: ['Fruktose- und Laktosemalabsorption', 'Glutenunverträglichkeit', 'Nussallergien', 'Histaminintoleranz'],
      correctIndex: 0,
    ),
    QuizQuestion(
      type: QuestionType.oddOneOut,
      question: 'Welche Aussage passt NICHT zum H₂-Atemtest?',
      answers: [
        'Er misst Wasserstoff in der Ausatemluft',
        'Er kann bei Non-H2-Producern falsch negativ ausfallen',
        'Er liefert immer ein hundertprozentig sicheres Ergebnis',
        'Er wird meist in gastroenterologischen oder internistischen Praxen durchgeführt',
      ],
      correctIndex: 2,
    ),
    QuizQuestion(
      type: QuestionType.fillBlank,
      question: 'Kann der Zucker im Dünndarm nicht ausreichend aufgenommen werden, wird er von ___ vergoren.',
      answers: ['Darmbakterien', 'Magensäure', 'Leberenzymen', 'Speichel'],
      correctIndex: 0,
    ),
  ],

  // --- 4: Unlock Mehrfachauswahl (Multi-select) ---
  4: [
    QuizQuestion(
      question: 'Was zeigen IgG-Antikörper laut Lektion an?',
      answers: ['Womit der Körper in Kontakt war', 'Ob eine Allergie vorliegt', 'Ob eine Unverträglichkeit vorliegt', 'Den Vitaminspiegel im Blut'],
      correctIndex: 0,
    ),
    QuizQuestion(
      type: QuestionType.fillBlank,
      question: 'IgG-Tests zeigen nur an, womit der Körper in ___ war, nicht was er tatsächlich verträgt.',
      answers: ['Kontakt', 'Widerspruch', 'Konkurrenz', 'Einklang'],
      correctIndex: 0,
    ),
    QuizQuestion(
      type: QuestionType.multiSelect,
      question: 'Was kritisiert die Lektion an IgG-Selbsttests? (Mehrfachauswahl)',
      answers: ['Sie können zu unnötigen Einschränkungen führen', 'Sie verzögern die Suche nach echten Auslösern', 'Sie sind gesetzlich verboten', 'Sie messen keine tatsächliche Verträglichkeit'],
      correctIndices: [0, 1, 3],
    ),
  ],

  // --- 5: Unlock Zuordnen (Matching) ---
  5: [
    QuizQuestion(
      question: 'Was kann laut Lektion bei akuten Bauchschmerzen helfen?',
      answers: ['Wärme, Tee und leichte Bewegung', 'Nur strenges Fasten', 'Kalte Duschen und Sport', 'Größere Mahlzeiten'],
      correctIndex: 0,
    ),
    QuizQuestion(
      type: QuestionType.multiSelect,
      question: 'Welche der folgenden Maßnahmen werden in der Lektion empfohlen? (Mehrfachauswahl)',
      answers: ['Wärmflasche auflegen', 'Kräutertee trinken', 'Anstrengendes Training', 'Tiefe Bauchatmung'],
      correctIndices: [0, 1, 3],
    ),
    QuizQuestion(
      type: QuestionType.matching,
      question: 'Ordne jeden Tipp seiner Wirkung zu.',
      pairs: [
        MatchPair(left: 'Wärme anwenden', right: 'Entspannt die Muskulatur'),
        MatchPair(left: 'Tee trinken', right: 'Wirkt krampflösend'),
        MatchPair(left: 'Leichte Bewegung', right: 'Regt die Verdauung an'),
        MatchPair(left: 'Atemübungen', right: 'Entspannt den Magen'),
      ],
    ),
  ],

  // --- 6: Unlock Reihenfolge (Sequence) ---
  6: [
    QuizQuestion(
      question: 'Was sollte man laut Lektion bei Durchfall vermeiden, obwohl es oft als Hausmittel gilt?',
      answers: ['Cola zur Flüssigkeitszufuhr', 'Stilles Wasser', 'Kräutertee', 'Elektrolytlösungen'],
      correctIndex: 0,
    ),
    QuizQuestion(
      type: QuestionType.trueFalse,
      question: 'Bei Durchfall verliert der Körper auch wichtige Mineralstoffe wie Natrium und Kalium.',
      answers: ['Richtig', 'Falsch'],
      correctIndex: 0,
    ),
    QuizQuestion(
      type: QuestionType.sequence,
      question: 'Bring die 5 Tipps bei Durchfall in die richtige Reihenfolge, wie sie in der Lektion vorgestellt werden.',
      sequenceItems: [
        'Flüssigkeit auffüllen',
        'Elektrolyte auffüllen',
        'Sanfte Ernährung wählen',
        'Ruhe gönnen',
        'Bei Alarmzeichen ärztlichen Rat einholen',
      ],
    ),
  ],

  // --- 7: Unlock Schätzfrage (Estimate) ---
  7: [
    QuizQuestion(
      question: 'Was passiert laut Lektion kurzfristig im Darm bei intensiver körperlicher Belastung?',
      answers: ['Er wird weniger durchblutet', 'Er wird stärker durchblutet', 'Er verdaut schneller', 'Er verändert sich nicht'],
      correctIndex: 0,
    ),
    QuizQuestion(
      type: QuestionType.multiSelect,
      question: 'Was empfiehlt die Lektion vor einer intensiven Trainingseinheit? (Mehrfachauswahl)',
      answers: ['Genug Zeit zur Verdauung einplanen', 'Gut hydriert starten', 'Direkt nach einer großen Mahlzeit trainieren', 'Die eigene Intensität finden'],
      correctIndices: [0, 1, 3],
    ),
    QuizQuestion(
      type: QuestionType.estimate,
      question: 'Wie viele Stunden Abstand solltest du laut Lektion zwischen einer größeren Mahlzeit und einer intensiven Trainingseinheit einplanen?',
      estimateMin: 0,
      estimateMax: 8,
      estimateTarget: 2,
      estimateUnit: 'Stunden',
      estimateTolerance: 0.2,
    ),
  ],

  // --- 8-14: Lektion noch nicht final — neutrale Platzhalterfragen ---
  8: [
    QuizQuestion(
      question: 'Diese Lektion ist bald verfügbar.',
      answers: ['Ok', 'Alles klar', 'Bin gespannt', 'Verstanden'],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: 'Unsere Ernährungsexperten arbeiten gerade an diesem Inhalt.',
      answers: ['Ok', 'Super', 'Danke', 'Klingt gut'],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: 'Schau bald wieder vorbei für neue Inhalte!',
      answers: ['Mach ich', 'Ok', 'Klar doch', 'Bin dabei'],
      correctIndex: 0,
    ),
  ],
  9: [
    QuizQuestion(
      question: 'Diese Lektion ist bald verfügbar.',
      answers: ['Ok', 'Alles klar', 'Bin gespannt', 'Verstanden'],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: 'Unsere Ernährungsexperten arbeiten gerade an diesem Inhalt.',
      answers: ['Ok', 'Super', 'Danke', 'Klingt gut'],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: 'Schau bald wieder vorbei für neue Inhalte!',
      answers: ['Mach ich', 'Ok', 'Klar doch', 'Bin dabei'],
      correctIndex: 0,
    ),
  ],
  10: [
    QuizQuestion(
      question: 'Diese Lektion ist bald verfügbar.',
      answers: ['Ok', 'Alles klar', 'Bin gespannt', 'Verstanden'],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: 'Unsere Ernährungsexperten arbeiten gerade an diesem Inhalt.',
      answers: ['Ok', 'Super', 'Danke', 'Klingt gut'],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: 'Schau bald wieder vorbei für neue Inhalte!',
      answers: ['Mach ich', 'Ok', 'Klar doch', 'Bin dabei'],
      correctIndex: 0,
    ),
  ],
  11: [
    QuizQuestion(
      question: 'Diese Lektion ist bald verfügbar.',
      answers: ['Ok', 'Alles klar', 'Bin gespannt', 'Verstanden'],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: 'Unsere Ernährungsexperten arbeiten gerade an diesem Inhalt.',
      answers: ['Ok', 'Super', 'Danke', 'Klingt gut'],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: 'Schau bald wieder vorbei für neue Inhalte!',
      answers: ['Mach ich', 'Ok', 'Klar doch', 'Bin dabei'],
      correctIndex: 0,
    ),
  ],
  12: [
    QuizQuestion(
      question: 'Diese Lektion ist bald verfügbar.',
      answers: ['Ok', 'Alles klar', 'Bin gespannt', 'Verstanden'],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: 'Unsere Ernährungsexperten arbeiten gerade an diesem Inhalt.',
      answers: ['Ok', 'Super', 'Danke', 'Klingt gut'],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: 'Schau bald wieder vorbei für neue Inhalte!',
      answers: ['Mach ich', 'Ok', 'Klar doch', 'Bin dabei'],
      correctIndex: 0,
    ),
  ],
  13: [
    QuizQuestion(
      question: 'Diese Lektion ist bald verfügbar.',
      answers: ['Ok', 'Alles klar', 'Bin gespannt', 'Verstanden'],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: 'Unsere Ernährungsexperten arbeiten gerade an diesem Inhalt.',
      answers: ['Ok', 'Super', 'Danke', 'Klingt gut'],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: 'Schau bald wieder vorbei für neue Inhalte!',
      answers: ['Mach ich', 'Ok', 'Klar doch', 'Bin dabei'],
      correctIndex: 0,
    ),
  ],
  14: [
    QuizQuestion(
      question: 'Diese Lektion ist bald verfügbar.',
      answers: ['Ok', 'Alles klar', 'Bin gespannt', 'Verstanden'],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: 'Unsere Ernährungsexperten arbeiten gerade an diesem Inhalt.',
      answers: ['Ok', 'Super', 'Danke', 'Klingt gut'],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: 'Schau bald wieder vorbei für neue Inhalte!',
      answers: ['Mach ich', 'Ok', 'Klar doch', 'Bin dabei'],
      correctIndex: 0,
    ),
  ],
};