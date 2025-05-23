import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/flashcard_controller.dart';
import '../models/flashcard_model.dart';
import '../utils/app_colors.dart';

class AddEditFlashcardView extends StatelessWidget {
  final FlashcardController controller = Get.find();

  final TextEditingController wordController = TextEditingController();
  final TextEditingController translationController = TextEditingController();
  final RxString selectedCategory = 'Travel'.obs;

  final List<String> categories = ['Travel', 'Business', 'Food'];

  AddEditFlashcardView({super.key}) {
    final editing = controller.editingFlashcard.value;
    if (editing != null) {
      wordController.text = editing.word;
      translationController.text = editing.translation;
      selectedCategory.value = editing.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = controller.editingFlashcard.value != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? 'Edit Flashcard' : 'Add Flashcard',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Word",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 6),
            _buildInputField(wordController, "Enter the word"),

            const SizedBox(height: 20),
            Text(
              "Translation",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 6),
            _buildInputField(translationController, "Enter the translation"),

            const SizedBox(height: 20),
            Text(
              "Category",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 6),
            Obx(
              () => DropdownButtonFormField<String>(
                value: selectedCategory.value,
                decoration: _inputDecoration(),
                items:
                    categories
                        .map(
                          (cat) =>
                              DropdownMenuItem(value: cat, child: Text(cat)),
                        )
                        .toList(),
                onChanged: (val) => selectedCategory.value = val!,
              ),
            ),

            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: _handleSave,
              icon: Icon(
                isEditing ? Icons.save : Icons.add,
                color: Colors.white,
              ),
              label: Text(
                isEditing ? 'Update Flashcard' : 'Add Flashcard',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      style: GoogleFonts.poppins(fontSize: 16),
      decoration: _inputDecoration(hintText: hint),
    );
  }

  InputDecoration _inputDecoration({String? hintText}) {
    return InputDecoration(
      hintText: hintText,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }

  void _handleSave() {
    final word = wordController.text.trim();
    final translation = translationController.text.trim();
    final category = selectedCategory.value;
    final isEditing = controller.editingFlashcard.value != null;

    if (word.isEmpty || translation.isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Both fields are required',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
      return;
    }

    if (isEditing) {
      final old = controller.editingFlashcard.value!;
      controller.updateFlashcard(
        Flashcard(
          id: old.id,
          word: word,
          translation: translation,
          category: category,
          correctCount: old.correctCount,
          wrongCount: old.wrongCount,
        ),
      );
    } else {
      controller.addFlashcard(word, translation, category);
    }

    Get.snackbar(
      isEditing ? 'Flashcard Updated' : 'Flashcard Added',
      isEditing
          ? 'Your flashcard has been updated successfully!'
          : 'Your new flashcard has been added!',
      backgroundColor: AppColors.primary,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
      icon: const Icon(Icons.check_circle, color: Colors.white),
    );

    controller.editingFlashcard.value = null;
    Get.back();
  }
}
