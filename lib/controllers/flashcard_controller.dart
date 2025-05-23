import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../models/flashcard_model.dart';
import '../utils/app_colors.dart';

class FlashcardController extends GetxController {
  var flashcards = <Flashcard>[].obs;
  var editingFlashcard = Rxn<Flashcard>();

  List<Flashcard> get filteredFlashcards => flashcards;

  void addFlashcard(String word, String translation, String category) {
    final newFlashcard = Flashcard(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      word: word,
      translation: translation,
      category: category,
    );
    flashcards.add(newFlashcard);

    Get.snackbar(
      'Flashcard Added',
      'Your new flashcard has been added!',
      backgroundColor: AppColors.primary,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
      icon: const Icon(Icons.check_circle, color: Colors.white),
    );
  }

  void deleteFlashcard(String id) {
    flashcards.removeWhere((f) => f.id == id);
  }

  void updateFlashcard(Flashcard updated) {
    final index = flashcards.indexWhere((f) => f.id == updated.id);
    if (index != -1) {
      flashcards[index] = updated;
      flashcards.refresh();

      Get.snackbar(
        'Flashcard Updated',
        'Your flashcard has been updated!',
        backgroundColor: AppColors.primary,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        duration: const Duration(seconds: 2),
        icon: const Icon(Icons.check_circle, color: Colors.white),
      );
    }
  }
}
