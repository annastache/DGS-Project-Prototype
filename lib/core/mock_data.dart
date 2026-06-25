import '../models/lesson.dart';
import '../models/quiz_question.dart';

const demoLessons = <Lesson>[
  Lesson(
    index: 0,
    title: 'Einleitung',
    readingTime: '2 Minute Lesezeit',
    body: '''Willkommen in der Erkennungsphase. In den nächsten Tagen dokumentierst du Mahlzeiten und Symptome. Dadurch entsteht eine Grundlage, auf der dein Ernährungsberater eine aussagekräftige Analyse erstellen kann.
    
    Wie du deine Verdauung verbessern kannst

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
    index: 1,
    title: 'Atemtests zur Diagnose von Unverträglichkeiten',
    readingTime: '2 Minuten Lesezeit',
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
    readingTime: '2 Minuten Lesezeit',
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
    title: 'Symptome richtig dokumentieren',
    readingTime: '2 Minuten Lesezeit',
    body: '''Mahlzeitendokumentation

Über den „+"-Button kannst du bequem die Mahlzeiten-Eingabe aufrufen. Anschließend kannst du über den Button „+ Zutat hinzufügen" deine verzehrten Lebensmittel hinzufügen.

Erfasse Zutaten einzeln

Erfasse die Zutaten von Gerichten einzeln, damit unser Algorithmus sie richtig klassifizieren kann. Das wäre z.B. bei einem Nudelauflauf: Nudeln, Sahne, Paprika, Brokkoli und Käse. Gewürze müssen nicht erfasst werden, da sie aufgrund der geringen Menge in der Regel nicht im Zusammenhang mit Nahrungsmittelunverträglichkeiten stehen.

Nutze die Autovervollständigung

Bei der Eingabe hilft dir unsere smarte Autovervollständigung, die dir Zutaten aus unserer Datenbank mit über 10.000 Lebensmitteln vorschlägt. Bitte nutze die Vorschläge, wann immer möglich, damit deine Analyse möglichst genau wird. Solltest du ein bestimmtes Lebensmittel gar nicht finden, kannst du dieses manuell hinzufügen.

Falls du Spezial-Produkte, beispielsweise glutenfreie oder laktosefreie Lebensmittel, zu dir nimmst wähle explizit die entsprechende Variante aus den Vorschlägen aus. 

Mengenangaben

Erfasse bei der Eingabe deiner Lebensmittel jeweils die grobe Menge. Diese muss nicht unbedingt abgewogen werden, eine gute Schätzung reicht aus. Um dir das einfacher zu machen, haben wir für jede Zutat eine typische Standardportionsgröße hinterlegt. Nutze diese, wenn du dir beim genauen Gewicht unsicher bist. Falls es nicht explizit anders angegeben ist, nimm das Gewicht des Lebensmittels in rohem Zustand an.

Zeitpunkt der Mahlzeit

Trage deine Mahlzeiten täglich mit möglichst genauen Uhrzeiten in das digitale Ernährungstagebuch ein. Solltest du über einen längeren Zeitraum essen, wie es häufig bei Restaurantbesuchen der Fall sein kann, trage als Zeitpunkt die grobe Mitte des Zeitraums ein (z.B. Essen von 11 bis 12 Uhr → Zeitpunkt der Mahlzeit: 11:30 Uhr).

Dokumentiere kontinuierlich

Achte darauf, dein gewöhnliches Essverhalten beizubehalten und keine größeren Pausen bei der Dokumentation zu machen. Dokumentiere deine Mahlzeiten möglichst sofort nach dem Essen, um keine Einträge zu vergessen.

Symptomdokumentation

Über,+" → „Symptom erfassen" kannst du bequem Symptome in der App notieren.

Dokumentiere deine Beschwerden konsequent und mit dem genauen Zeitpunkt des Auftretens. Wir empfehlen, die Symptome umgehend nach dem Auftreten einzutragen, um den genauen Zeitpunkt zu erfassen und keinen Eintrag zu vergessen. Wähle zunächst das Datum und die Uhrzeit aus, wann das Symptom aufgetreten ist.

Erfasse Symptomstärke & -art

Teile uns anschließend mit, welches Symptom bei dir aufgetreten ist. Nutze dafür die Auswahlliste. Findest du ein Symptom nicht in der Liste, kannst du unter „Sonstiges, bitte spezifizieren" eigene Symptome eintragen. Zuletzt solltest du erfassen, wie stark dich deine Beschwerden beeinträchtigen.

Dokumentiere 14 Tage kontinuierlich

Wir verstehen, dass die Dokumentation all deiner Mahlzeiten und Symptome mit Zeitaufwand und Mühe verbunden ist. Trotzdem ist es wichtig, diese so detailliert wie möglich mit den exakten Zeitpunkten zu erfassen, um eine genaue Analyse zu ermöglichen. Dein persönlicher Ernährungsberater schaut sich diese Einträge am Ende der Erkennungsphase an. Jeder Eintrag bringt uns einen Schritt näher zur Linderung deiner Beschwerden.''',
  ),
  Lesson(
    index: 7,
    title: 'Mahlzeiten verständlich erfassen',
    readingTime: '2 Minuten Lesezeit',
    body: 'Je genauer Zutaten und Portionsgrößen erfasst werden, desto besser können Muster erkannt werden. Für den Prototyp reicht eine vereinfachte Eingabe.',
  ),
  Lesson(
    index: 8,
    title: 'Trinken und Verdauung',
    readingTime: '1 Minute Lesezeit',
    body: 'Ausreichend Flüssigkeit unterstützt alltägliche Körperfunktionen. Bei Beschwerden kann es hilfreich sein, auch Getränke mit zu dokumentieren.',
  ),
  Lesson(
    index: 9,
    title: 'Stress als Einflussfaktor',
    readingTime: '2 Minuten Lesezeit',
    body: 'Stress kann die Wahrnehmung von Beschwerden und die Verdauung beeinflussen. Deshalb kann ein kurzer Stimmungseintrag zusätzliche Hinweise liefern.',
  ),
  Lesson(
    index: 10,
    title: 'Bewegung im Alltag',
    readingTime: '1 Minute Lesezeit',
    body: 'Leichte Bewegung nach dem Essen kann manchen Menschen guttun. Entscheidend ist, eigene Muster zu beobachten und nicht alles auf einzelne Lebensmittel zurückzuführen.',
  ),
  Lesson(
    index: 11,
    title: 'Analyse vorbereiten',
    readingTime: '2 Minuten Lesezeit',
    body: 'Je vollständiger dein Tagebuch ist, desto besser kann die spätere Analyse Zusammenhänge sichtbar machen.',
  ),
  Lesson(
    index: 12,
    title: 'Lebensmittelguide verstehen',
    readingTime: '2 Minuten Lesezeit',
    body: 'Der Lebensmittelguide hilft dabei, Empfehlungen im Alltag leichter umzusetzen und passende Alternativen zu finden.',
  ),
  Lesson(
    index: 13,
    title: 'Empfehlungen anwenden',
    readingTime: '2 Minuten Lesezeit',
    body: 'Nach der Analyse geht es darum, Empfehlungen Schritt für Schritt in den Alltag zu übertragen.',
  ),
  Lesson(
    index: 14,
    title: 'Ziel erreicht',
    readingTime: '1 Minute Lesezeit',
    body: 'Du hast die Erkennungsphase abgeschlossen. Im nächsten Schritt können Ergebnisse und Empfehlungen besprochen werden.',
  ),
];

/// Quiz-Fragen gruppiert nach Lektion (Key = Lesson.index).
/// Jede Lektion hat genau 3 Fragen.
const demoQuizQuestionsByLesson = <int, List<QuizQuestion>>{
  0: [
    QuizQuestion(
      question: 'Was passiert, wenn du eine Antwort im Quiz auswählst?',
      answers: ['Sie wird sofort als richtig oder falsch markiert', 'Nichts, du musst erst bestätigen', 'Das Quiz startet neu', 'Die Frage wird übersprungen'],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: 'Wofür stehen die Sterne auf der Ergebnis-Seite?',
      answers: ['Für die Anzahl der Lektionen', 'Für dein Abschneiden im Quiz', 'Für die Lesezeit', 'Für deine Tagesserie'],
      correctIndex: 1,
    ),
    QuizQuestion(
      question: 'Was kannst du tun, wenn dir das Ergebnis nicht gefällt?',
      answers: ['Nichts, das Ergebnis ist final', 'Die App neu installieren', 'Das Quiz wiederholen', 'Den Support kontaktieren'],
      correctIndex: 2,
    ),
  ],
  1: [
    QuizQuestion(
      question: 'Was wird vor dem H₂-Atemtest getrunken?',
      answers: ['Wasser', 'Zucker', 'Mundspülung', 'Coke zero'],
      correctIndex: 1,
    ),
    QuizQuestion(
      question: 'Was misst der H₂-Atemtest?',
      answers: [ 'Pulsfrequenz', 'Blutzucker dauerhaft', 'Schlafqualität', 'Wasserstoff in der Ausatemluft'],
      correctIndex: 3,
    ),
    QuizQuestion(
      question: 'Warum kann H₂ als Marker geeignet sein?',
      answers: ['Er kommt im Stoffwechsel kaum vor', 'Er ist immer in Lebensmitteln', 'Er färbt den Urin', 'Er senkt automatisch Beschwerden'],
      correctIndex: 0,
    ),
  ],
  2: [
    QuizQuestion(
      question: 'Was unterscheidet Allergien von Unverträglichkeiten grundsätzlich?',
      answers: ['Allergien sind immer ungefährlich', 'Unverträglichkeiten betreffen nur die Haut', 'Allergien betreffen das Immunsystem', 'Es gibt keinen Unterschied'],
      correctIndex: 2,
    ),
    QuizQuestion(
      question: 'Womit hängen Unverträglichkeiten häufig zusammen?',
      answers: ['Mit dem Immunsystem', 'Mit Verdauung oder Aufnahme bestimmter Stoffe', 'Mit der Hautpflege', 'Mit dem Schlafrhythmus'],
      correctIndex: 1,
    ),
    QuizQuestion(
      question: 'Können Allergien und Unverträglichkeiten ähnliche Beschwerden auslösen?',
      answers: ['Ja, das kann vorkommen', 'Nein, nie', 'Nur bei Kindern', 'Nur bei schwerem Verlauf'],
      correctIndex: 0,
    ),
  ],
  3: [
    QuizQuestion(
      question: 'Für welche Unverträglichkeiten gilt der H₂-Atemtest als Goldstandard?',
      answers: ['Glutenunverträglichkeit', 'Histaminintoleranz', 'Nussallergien', 'Fruktose- und Laktosemalabsorption'],
      correctIndex: 3,
    ),
    QuizQuestion(
      question: 'Was passiert, wenn der Zucker im Dünndarm nicht ausreichend aufgenommen wird?',
      answers: ['Er wird von Darmbakterien vergoren', 'Er wird sofort ausgeschieden', 'Er wird im Magen neutralisiert', 'Er wird in der Leber gespeichert'],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: 'Wie gelangen die entstehenden Gase in die Ausatemluft?',
      answers: ['Über die Speiseröhre', 'Über das Blut in die Lunge', 'Über die Haut', 'Über den Speichel'],
      correctIndex: 1,
    ),
  ],
  4: [
    QuizQuestion(
      question: 'Sind alle Tests für jede Fragestellung gleich gut geeignet?',
      answers: ['Ja, immer', 'Nur Bluttests sind sinnvoll', 'Nein, nicht jeder Test passt zu jeder Frage', 'Das spielt keine Rolle'],
      correctIndex: 2,
    ),
    QuizQuestion(
      question: 'Welche Art von Selbsttests sollte kritisch betrachtet werden?',
      answers: ['IgG-Selbsttests', 'H₂-Atemtests', 'Blutdruckmessungen', 'Gewichtskontrollen'],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: 'Worum geht es beim sinnvollen Einordnen von Testergebnissen?',
      answers: ['Ergebnisse zu ignorieren', 'Nur das positive Ergebnis zu beachten', 'Tests mehrfach zu wiederholen', 'Ergebnisse richtig zu verstehen und einzuordnen'],
      correctIndex: 3,
    ),
  ],
  5: [
    QuizQuestion(
      question: 'Was kann laut Lektion bei Bauchschmerzen helfen?',
      answers: ['Wärme, Ruhe und langsames Essen', 'Schnelles Essen', 'Kälte und Bewegung', 'Längeres Hungern'],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: 'Was hilft dabei, Beschwerden besser zu verstehen?',
      answers: [ 'Beschwerden ignorieren', 'Nur auf ein Lebensmittel achten', 'Wiederkehrende Muster beobachten', 'Beschwerden nicht dokumentieren'],
      correctIndex: 2,
    ),
    QuizQuestion(
      question: 'Was sollte bei starken oder anhaltenden Beschwerden passieren?',
      answers: ['Abwarten ohne Maßnahme', 'Ärztliche Abklärung',  'Nur die App nutzen', 'Ernährung sofort komplett umstellen'],
      correctIndex: 1,
    ),
  ],
  6: [
    QuizQuestion(
      question: 'Wann sollten Symptome notiert werden?',
      answers: ['Möglichst zeitnah', 'Erst am nächsten Tag', 'Nur einmal pro Woche', 'Gar nicht'],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: 'Welche Angaben sind beim Dokumentieren besonders hilfreich?',
      answers: ['Zeitpunkt, Stärke und Dauer', 'Nur die Uhrzeit', 'Nur das Wetter', 'Nur die Mahlzeit'],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: 'Warum hilft zeitnahes Dokumentieren?',
      answers: ['Auslöser können später leichter erkannt werden', 'Es macht die App schneller', 'Es ersetzt den Arztbesuch', 'Es hat keinen Nutzen'],
      correctIndex: 0,
    ),
  ],
  7: [
    QuizQuestion(
      question: 'Was hilft dabei, Muster bei Mahlzeiten zu erkennen?',
      answers: ['Genaue Erfassung von Zutaten und Portionsgrößen', 'Mahlzeiten gar nicht erfassen', 'Nur die Uhrzeit notieren', 'Nur Fotos ohne Beschreibung'],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: 'Wie detailliert ist die Eingabe im Prototyp gehalten?',
      answers: ['Vereinfacht', 'Maximal komplex', 'Nur per Sprachsteuerung', 'Automatisch ohne Eingabe'],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: 'Was wird in dieser Lektion zum Thema Mahlzeiten erklärt?',
      answers: ['Wie Mahlzeiten verständlich erfasst werden', 'Wie man kocht', 'Wie man einkauft', 'Wie man Rezepte erstellt'],
      correctIndex: 0,
    ),
  ],
  8: [
    QuizQuestion(
      question: 'Was unterstützt ausreichende Flüssigkeitszufuhr laut Lektion?',
      answers: ['Alltägliche Körperfunktionen', 'Nur die Verdauung von Fett', 'Nur den Schlaf', 'Nur die Konzentration'],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: 'Was kann bei Beschwerden zusätzlich hilfreich sein?',
      answers: ['Getränke mitdokumentieren', 'Nur feste Nahrung dokumentieren', 'Getränke weglassen', 'Nur Wasser trinken'],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: 'Worum geht es in dieser Lektion primär?',
      answers: ['Trinken und Verdauung', 'Bewegung im Alltag', 'Stressbewältigung', 'Symptomdokumentation'],
      correctIndex: 0,
    ),
  ],
  9: [
    QuizQuestion(
      question: 'Was kann laut Lektion die Verdauung beeinflussen?',
      answers: ['Stress', 'Nur die Tageszeit', 'Nur die Raumtemperatur', 'Nur die Kleidung'],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: 'Was kann zusätzliche Hinweise liefern?',
      answers: ['Ein kurzer Stimmungseintrag', 'Ein Wetterbericht', 'Eine Gewichtsmessung', 'Ein Schrittzähler'],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: 'Was beeinflusst Stress laut Lektion zusätzlich zur Verdauung?',
      answers: ['Die Wahrnehmung von Beschwerden', 'Die Körpergröße', 'Den Geschmackssinn', 'Die Augenfarbe'],
      correctIndex: 0,
    ),
  ],
  10: [
    QuizQuestion(
      question: 'Was kann manchen Menschen nach dem Essen guttun?',
      answers: ['Leichte Bewegung', 'Sofortiges Hinlegen', 'Schweres Training', 'Langes Sitzen'],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: 'Worauf kommt es laut Lektion entscheidend an?',
      answers: ['Eigene Muster zu beobachten', 'Alles auf ein Lebensmittel zurückzuführen', 'Bewegung komplett zu vermeiden', 'Nur auf Empfehlungen anderer zu hören'],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: 'Sollte man Beschwerden immer auf einzelne Lebensmittel zurückführen?',
      answers: ['Nein, das wird in der Lektion nicht empfohlen', 'Ja, immer', 'Nur bei Allergien', 'Nur am Wochenende'],
      correctIndex: 0,
    ),
  ],
  11: [
    QuizQuestion(
      question: 'Was wirkt sich positiv auf die spätere Analyse aus?',
      answers: ['Ein möglichst vollständiges Tagebuch', 'Ein leeres Tagebuch', 'Nur ein Eintrag pro Woche', 'Tagebuch ohne Datum'],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: 'Was kann die Analyse sichtbar machen?',
      answers: ['Zusammenhänge', 'Nur das Wetter', 'Nur die Kalorienzahl', 'Nur die Schrittzahl'],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: 'Worum geht es in dieser Lektion?',
      answers: ['Die Analyse vorzubereiten', 'Das Quiz zu wiederholen', 'Eine neue Lektion freizuschalten', 'Den Wissenspfad zu starten'],
      correctIndex: 0,
    ),
  ],
  12: [
    QuizQuestion(
      question: 'Wobei hilft der Lebensmittelguide?',
      answers: ['Empfehlungen im Alltag umzusetzen', 'Rezepte zu erfinden', 'Kalorien zu zählen', 'Einkaufslisten zu drucken'],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: 'Was lässt sich mit dem Lebensmittelguide leichter finden?',
      answers: ['Passende Alternativen', 'Neue Symptome', 'Termine beim Arzt', 'Stressfaktoren'],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: 'Worum geht es in dieser Lektion?',
      answers: ['Den Lebensmittelguide zu verstehen', 'Symptome zu dokumentieren', 'Den H₂-Atemtest durchzuführen', 'Bewegung im Alltag zu steigern'],
      correctIndex: 0,
    ),
  ],
  13: [
    QuizQuestion(
      question: 'Wie sollten Empfehlungen nach der Analyse umgesetzt werden?',
      answers: ['Schritt für Schritt', 'Alle sofort gleichzeitig', 'Gar nicht', 'Nur am ersten Tag'],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: 'Worum geht es in dieser Lektion vor allem?',
      answers: ['Empfehlungen anzuwenden', 'Den Atemtest zu erklären', 'Stress zu reduzieren', 'Das Tagebuch zu starten'],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: 'Wann kommt diese Lektion im Ablauf?',
      answers: ['Nach der Analyse', 'Vor der Erkennungsphase', 'Direkt am ersten Tag', 'Unabhängig vom Ablauf'],
      correctIndex: 0,
    ),
  ],
  14: [
    QuizQuestion(
      question: 'Was hast du laut dieser Lektion abgeschlossen?',
      answers: ['Die Erkennungsphase', 'Den H₂-Atemtest', 'Den Lebensmittelguide', 'Das Tutorial-Quiz'],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: 'Was kann im nächsten Schritt passieren?',
      answers: ['Ergebnisse und Empfehlungen besprochen werden', 'Die Erkennungsphase neu beginnen', 'Das Tagebuch gelöscht werden', 'Die App deinstalliert werden'],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: 'Wie heißt diese letzte Lektion?',
      answers: ['Ziel erreicht', 'Stress als Einflussfaktor', 'Analyse vorbereiten', 'Bewegung im Alltag'],
      correctIndex: 0,
    ),
  ],
};