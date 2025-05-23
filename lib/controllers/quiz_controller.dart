import 'package:get/get.dart';
import '../models/flashcard_model.dart';
import 'flashcard_controller.dart';

class QuizController extends GetxController {
  var isQuizActive = false.obs;
  var currentFlashcard = Rxn<Flashcard>();
  var currentOptions = <Flashcard>[].obs;
  var correctAnswers = 0.obs;
  var totalQuestions = 0.obs;

  List<Flashcard> _allFlashcards = [];
  List<Flashcard> _quizFlashcards = [];

  int _currentIndex = 0;

  void startQuiz(String category) {
    isQuizActive.value = true;
    correctAnswers.value = 0;
    totalQuestions.value = 0;
    _currentIndex = 0;

    _allFlashcards = Get.find<FlashcardController>().flashcards.toList();

    if (category == 'All') {
      _quizFlashcards = _allFlashcards;
    } else {
      _quizFlashcards = _allFlashcards.where((f) => f.category == category).toList();
    }

    if (_quizFlashcards.isEmpty) {
      isQuizActive.value = false;
      currentFlashcard.value = null;
      currentOptions.clear();
      return;
    }

    _quizFlashcards.shuffle();
    loadQuestion();
  }

  void loadQuestion() {
    if (_currentIndex >= _quizFlashcards.length) {
      isQuizActive.value = false;
      currentFlashcard.value = null;
      currentOptions.clear();
      return;
    }

    currentFlashcard.value = _quizFlashcards[_currentIndex];
    totalQuestions.value = _quizFlashcards.length;

    // Prepare options: 1 correct + 3 random wrong
    List<Flashcard> options = [];
    options.add(currentFlashcard.value!);

    final wrongOptions = _allFlashcards.where((f) => f.id != currentFlashcard.value!.id).toList()..shuffle();
    options.addAll(wrongOptions.take(3));
    options.shuffle();

    currentOptions.assignAll(options);
  }

  void answerQuiz(Flashcard selected) {
    if (!isQuizActive.value) return;
    if (selected.id == currentFlashcard.value!.id) {
      correctAnswers.value++;
      currentFlashcard.value!.correctCount++;
    } else {
      currentFlashcard.value!.wrongCount++;
    }
    updateFlashcardStats();
    nextQuestion();
  }

  void nextQuestion() {
    _currentIndex++;
    if (_currentIndex >= _quizFlashcards.length) {
      isQuizActive.value = false;
      currentFlashcard.value = null;
      currentOptions.clear();
    } else {
      loadQuestion();
    }
  }

  void updateFlashcardStats() {
    final flashcardController = Get.find<FlashcardController>();
    flashcardController.updateFlashcard(currentFlashcard.value!);
  }
}
