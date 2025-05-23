import 'package:flutter/material.dart';
import '../models/flashcard_model.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';

class FlashcardWidget extends StatelessWidget {
  final Flashcard flashcard;

  FlashcardWidget({required this.flashcard});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 5,
      child: ListTile(
        title: Text(
          flashcard.word,
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary),
        ),
        subtitle: Text(
          flashcard.translation,
          style: GoogleFonts.poppins(fontSize: 18, color: AppColors.secondary),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('✅ ${flashcard.correctCount}', style: TextStyle(color: Colors.green)),
            Text('❌ ${flashcard.wrongCount}', style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
