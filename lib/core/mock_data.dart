import '../models/lesson.dart';
import '../models/quiz_question.dart';

const demoLessons = <Lesson>[
  Lesson(
    index: 0,
    title: 'Einleitung',
    readingTime: '1 Minute Lesezeit',
    body: 'Willkommen in der Erkennungsphase. In den nächsten Tagen dokumentierst du Mahlzeiten und Symptome. Dadurch entsteht eine Grundlage, auf der dein Ernährungsberater eine aussagekräftige Analyse erstellen kann.',
  ),
  Lesson(
    index: 1,
    title: 'Verdauungsfördernde Essgewohnheiten',
    readingTime: '2 Minuten Lesezeit',
    body: 'Regelmäßige Mahlzeiten, bewusstes Kauen und ausreichend Zeit beim Essen können die Verdauung unterstützen. Kleine Routinen helfen dabei, Beschwerden genauer einzuordnen.',
  ),
  Lesson(
    index: 2,
    title: 'Lebensmittelallergie vs. Unverträglichkeiten',
    readingTime: '2 Minuten Lesezeit',
    body: 'Allergien und Unverträglichkeiten können ähnliche Beschwerden auslösen, unterscheiden sich aber in ihrer Ursache. Während Allergien das Immunsystem betreffen, hängen Unverträglichkeiten häufig mit Verdauung oder Aufnahme bestimmter Stoffe zusammen.',
  ),
  Lesson(
    index: 3,
    title: 'Atemtests zur Diagnose von Unverträglichkeiten',
    readingTime: '1 Minute Lesezeit',
    body: 'Der H₂-Atemtest ist eines der wichtigsten Verfahren zur Abklärung von Nahrungsmittelunverträglichkeiten. Für Fruktose- und Laktosemalabsorption gilt er als diagnostischer Goldstandard. Beim H₂-Atemtest wird gemessen, wie viel Wasserstoff in der Ausatemluft entsteht, nachdem eine festgelegte Menge eines Zuckers getrunken wurde. Kann dieser Zucker im Dünndarm nicht ausreichend aufgenommen werden, wird er von Darmbakterien vergoren. Die entstehenden Gase gelangen über das Blut in die Lunge und werden ausgeatmet.',
  ),
  Lesson(
    index: 4,
    title: 'Lebensmittelreaktionstest und IgG-Selbsttests',
    readingTime: '2 Minuten Lesezeit',
    body: 'Nicht jeder Test ist für jede Fragestellung geeignet. In dieser Lektion geht es darum, warum manche Selbsttests kritisch betrachtet werden sollten und wie man Testergebnisse sinnvoll einordnet.',
  ),
  Lesson(
    index: 5,
    title: 'Tipps zur Linderung von Bauchschmerzen',
    readingTime: '2 Minuten Lesezeit',
    body: 'Wärme, Ruhe, langsames Essen und das Beobachten wiederkehrender Muster können helfen, Beschwerden besser zu verstehen. Wichtig ist, starke oder anhaltende Beschwerden ärztlich abklären zu lassen.',
  ),
  Lesson(
    index: 6,
    title: 'Symptome richtig dokumentieren',
    readingTime: '2 Minuten Lesezeit',
    body: 'Notiere Symptome möglichst zeitnah, damit Auslöser später leichter erkannt werden können. Besonders hilfreich sind Zeitpunkt, Stärke und Dauer der Beschwerden.',
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
      answers: ['Wasserstoff in der Ausatemluft', 'Pulsfrequenz', 'Blutzucker dauerhaft', 'Schlafqualität'],
      correctIndex: 0,
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
      answers: ['Allergien betreffen das Immunsystem', 'Allergien sind immer ungefährlich', 'Unverträglichkeiten betreffen nur die Haut', 'Es gibt keinen Unterschied'],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: 'Womit hängen Unverträglichkeiten häufig zusammen?',
      answers: ['Mit dem Immunsystem', 'Mit Verdauung oder Aufnahme bestimmter Stoffe', 'Mit der Hautpflege', 'Mit dem Schlafrhythmus'],
      correctIndex: 1,
    ),
    QuizQuestion(
      question: 'Können Allergien und Unverträglichkeiten ähnliche Beschwerden auslösen?',
      answers: ['Nein, nie', 'Ja, das kann vorkommen', 'Nur bei Kindern', 'Nur bei schwerem Verlauf'],
      correctIndex: 1,
    ),
  ],
  3: [
    QuizQuestion(
      question: 'Für welche Unverträglichkeiten gilt der H₂-Atemtest als Goldstandard?',
      answers: ['Fruktose- und Laktosemalabsorption', 'Glutenunverträglichkeit', 'Histaminintoleranz', 'Nussallergien'],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: 'Was passiert, wenn der Zucker im Dünndarm nicht ausreichend aufgenommen wird?',
      answers: ['Er wird von Darmbakterien vergoren', 'Er wird sofort ausgeschieden', 'Er wird im Magen neutralisiert', 'Er wird in der Leber gespeichert'],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: 'Wie gelangen die entstehenden Gase in die Ausatemluft?',
      answers: ['Über das Blut in die Lunge', 'Über die Speiseröhre', 'Über die Haut', 'Über den Speichel'],
      correctIndex: 0,
    ),
  ],
  4: [
    QuizQuestion(
      question: 'Sind alle Tests für jede Fragestellung gleich gut geeignet?',
      answers: ['Ja, immer', 'Nein, nicht jeder Test passt zu jeder Frage', 'Nur Bluttests sind sinnvoll', 'Das spielt keine Rolle'],
      correctIndex: 1,
    ),
    QuizQuestion(
      question: 'Welche Art von Selbsttests sollte kritisch betrachtet werden?',
      answers: ['IgG-Selbsttests', 'H₂-Atemtests', 'Blutdruckmessungen', 'Gewichtskontrollen'],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: 'Worum geht es beim sinnvollen Einordnen von Testergebnissen?',
      answers: ['Ergebnisse richtig zu verstehen und einzuordnen', 'Ergebnisse zu ignorieren', 'Nur das positive Ergebnis zu beachten', 'Tests mehrfach zu wiederholen'],
      correctIndex: 0,
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
      answers: ['Wiederkehrende Muster beobachten', 'Beschwerden ignorieren', 'Nur auf ein Lebensmittel achten', 'Beschwerden nicht dokumentieren'],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: 'Was sollte bei starken oder anhaltenden Beschwerden passieren?',
      answers: ['Ärztliche Abklärung', 'Abwarten ohne Maßnahme', 'Nur die App nutzen', 'Ernährung sofort komplett umstellen'],
      correctIndex: 0,
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