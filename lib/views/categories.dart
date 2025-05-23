import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/flashcard_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';

class CategoriesView extends StatelessWidget {
  final FlashcardController controller = Get.find();

  final List<String> categories = ['Travel', 'Business', 'Food'];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(20),
      children: categories.map((category) {
        final count = controller.flashcards.where((f) => f.category == category).length;
        return Card(
          color: Theme.of(context).cardColor,
          margin: EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: ListTile(
            title: Text(category, style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primary)),
            trailing: Text('$count', style: GoogleFonts.poppins(fontSize: 18)),
          ),
        );
      }).toList(),
    );
  }
}
