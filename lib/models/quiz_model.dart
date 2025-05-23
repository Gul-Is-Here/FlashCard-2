class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctOptionIndex;

  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctOptionIndex,
  });
}
final List<QuizQuestion> predefinedQuiz = [
  QuizQuestion(
    question: 'What is the capital of France?',
    options: ['Berlin', 'London', 'Paris', 'Rome'],
    correctOptionIndex: 2,
  ),
  QuizQuestion(
    question: 'Which language is used for Flutter development?',
    options: ['Java', 'Dart', 'Kotlin', 'Swift'],
    correctOptionIndex: 1,
  ),
  QuizQuestion(
    question: 'What is the synonym of "happy"?',
    options: ['Sad', 'Joyful', 'Angry', 'Tired'],
    correctOptionIndex: 1,
  ),
  QuizQuestion(
    question: 'Which of these is a fruit?',
    options: ['Run', 'Orange', 'Jump', 'Sleep'],
    correctOptionIndex: 1,
  ),
  QuizQuestion(
    question: 'Translate "Bonjour" from French to English.',
    options: ['Goodbye', 'Thank you', 'Hello', 'Please'],
    correctOptionIndex: 2,
  ),
  QuizQuestion(
    question: 'Which of the following is a noun?',
    options: ['Quickly', 'Beautiful', 'Apple', 'Go'],
    correctOptionIndex: 2,
  ),
  QuizQuestion(
    question: 'What is the antonym of "cold"?',
    options: ['Cool', 'Hot', 'Warm', 'Chilly'],
    correctOptionIndex: 1,
  ),
  QuizQuestion(
    question: 'How do you say "book" in Spanish?',
    options: ['Libro', 'Buch', 'Livre', 'Kniga'],
    correctOptionIndex: 0,
  ),
  QuizQuestion(
    question: 'What is the plural of "child"?',
    options: ['Childs', 'Children', 'Childes', 'Childer'],
    correctOptionIndex: 1,
  ),
  QuizQuestion(
    question: 'What part of speech is "quickly"?',
    options: ['Noun', 'Adjective', 'Verb', 'Adverb'],
    correctOptionIndex: 3,
  ),
  QuizQuestion(
    question: 'Which of these is a question word?',
    options: ['What', 'The', 'Book', 'Run'],
    correctOptionIndex: 0,
  ),
  QuizQuestion(
    question: 'Choose the correct spelling:',
    options: ['Definately', 'Definitely', 'Definatly', 'Defenetly'],
    correctOptionIndex: 1,
  ),
  QuizQuestion(
    question: 'What does "merci" mean in English?',
    options: ['Please', 'Excuse me', 'Thank you', 'Sorry'],
    correctOptionIndex: 2,
  ),
  QuizQuestion(
    question: 'Which word is an adjective?',
    options: ['Green', 'Quickly', 'Teacher', 'Sing'],
    correctOptionIndex: 0,
  ),
  QuizQuestion(
    question: 'Translate "gracias" from Spanish to English.',
    options: ['Goodbye', 'Hello', 'Thanks', 'Friend'],
    correctOptionIndex: 2,
  ),
  QuizQuestion(
    question: 'What is the opposite of "easy"?',
    options: ['Slow', 'Hard', 'Fast', 'Simple'],
    correctOptionIndex: 1,
  ),
  QuizQuestion(
    question: 'Which language uses the Cyrillic alphabet?',
    options: ['English', 'Russian', 'Spanish', 'Hindi'],
    correctOptionIndex: 1,
  ),
  QuizQuestion(
    question: 'What is the base form of the verb "went"?',
    options: ['Gone', 'Wenting', 'Go', 'Goes'],
    correctOptionIndex: 2,
  ),
  QuizQuestion(
    question: 'Which of these is used to ask permission?',
    options: ['Shall', 'Will', 'May', 'Might'],
    correctOptionIndex: 2,
  ),
  QuizQuestion(
    question: 'What does "guten Morgen" mean in German?',
    options: ['Good evening', 'Good night', 'Good afternoon', 'Good morning'],
    correctOptionIndex: 3,
  ),
];
