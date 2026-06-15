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

const demoQuizQuestions = <QuizQuestion>[
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
];
