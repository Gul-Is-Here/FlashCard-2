class Flashcard {
  String id;
  String word;
  String translation;
  String category;
  int correctCount;
  int wrongCount;

  Flashcard({
    required this.id,
    required this.word,
    required this.translation,
    required this.category,
    this.correctCount = 0,
    this.wrongCount = 0,
  });
}
