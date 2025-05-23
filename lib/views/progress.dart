import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/flashcard_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';

class ProgressView extends StatelessWidget {
  final FlashcardController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.flashcards.isEmpty) {
        return Center(
          child: Text('No flashcards yet.', style: GoogleFonts.poppins(fontSize: 18)),
        );
      }

      final totalCorrect = controller.flashcards.fold<int>(0, (sum, f) => sum + f.correctCount);
      final totalWrong = controller.flashcards.fold<int>(0, (sum, f) => sum + f.wrongCount);
      final totalAttempts = totalCorrect + totalWrong;
      final accuracy = totalAttempts == 0 ? 0.0 : totalCorrect / totalAttempts;

      return Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Learning Progress', style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.primary)),
            SizedBox(height: 40),
            Text('Total Attempts: $totalAttempts', style: GoogleFonts.poppins(fontSize: 18)),
            SizedBox(height: 8),
            Text('Correct Answers: $totalCorrect', style: GoogleFonts.poppins(fontSize: 18, color: Colors.green)),
            SizedBox(height: 8),
            Text('Wrong Answers: $totalWrong', style: GoogleFonts.poppins(fontSize: 18, color: Colors.red)),
            SizedBox(height: 30),
            LinearProgressIndicator(
              value: accuracy,
              minHeight: 20,
              backgroundColor: Colors.redAccent.withOpacity(0.3),
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            ),
            SizedBox(height: 10),
            Text('Accuracy: ${(accuracy * 100).toStringAsFixed(1)}%', style: GoogleFonts.poppins(fontSize: 20)),
          ],
        ),
      );
    });
  }
}
