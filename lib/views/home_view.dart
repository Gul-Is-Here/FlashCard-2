import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/flashcard_controller.dart';
import '../models/flashcard_model.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';
import 'add_edit_flashcard_view.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/flashcard_controller.dart';
import '../models/flashcard_model.dart';
import '../utils/app_colors.dart';
import 'add_edit_flashcard_view.dart';

class HomeView extends StatelessWidget {
  final FlashcardController controller = Get.find();
  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = ''.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Flashcards',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              onChanged: (val) => searchQuery.value = val.toLowerCase(),
              decoration: InputDecoration(
                hintText: 'Search flashcards...',
                prefixIcon: Icon(Icons.search),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              final filtered =
                  controller.filteredFlashcards.where((f) {
                    final q = searchQuery.value;
                    return f.word.toLowerCase().contains(q) ||
                        f.translation.toLowerCase().contains(q);
                  }).toList();

              if (filtered.isEmpty) {
                return Center(
                  child: Text(
                    'No flashcards found.',
                    style: GoogleFonts.poppins(fontSize: 18),
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: filtered.length,
                itemBuilder:
                    (context, index) =>
                        FlashcardFlipWidget(flashcard: filtered[index]),
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          controller.editingFlashcard.value = null;
          Get.to(() => AddEditFlashcardView());
        },
        backgroundColor: AppColors.primary,
        icon: Icon(Icons.add),
        label: Text('Add Flashcard', style: GoogleFonts.poppins()),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}

class FlashcardFlipWidget extends StatefulWidget {
  final Flashcard flashcard;

  FlashcardFlipWidget({required this.flashcard});

  @override
  _FlashcardFlipWidgetState createState() => _FlashcardFlipWidgetState();
}

class _FlashcardFlipWidgetState extends State<FlashcardFlipWidget>
    with SingleTickerProviderStateMixin {
  bool showFront = true;
  late AnimationController _controller;
  late Animation<double> _animation;

  final FlashcardController controller = Get.find();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  void _flip() {
    if (showFront) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    showFront = !showFront;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _flip,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final isFront = _animation.value < 0.5;
          final displayText =
              isFront ? widget.flashcard.word : widget.flashcard.translation;
          return Transform(
            transform: Matrix4.rotationY(_animation.value * 3.1416),
            alignment: Alignment.center,
            child: Card(
              color: Theme.of(context).cardColor,
              margin: EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 5,
              child: ListTile(
                title: Text(
                  displayText,
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                trailing: Wrap(
                  spacing: 12,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: AppColors.accent),
                      onPressed: () {
                        controller.editingFlashcard.value = widget.flashcard;
                        Get.to(() => AddEditFlashcardView());
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () {
                        Get.defaultDialog(
                          title: 'Delete Flashcard',
                          middleText:
                              'Are you sure you want to delete this flashcard?',
                          textCancel: 'Cancel',
                          textConfirm: 'Delete',
                          confirmTextColor: Colors.white,
                          onConfirm: () {
                            controller.deleteFlashcard(widget.flashcard.id);
                            Get.back();
                            Get.snackbar(
                              'Deleted',
                              'Flashcard deleted',
                              backgroundColor: Colors.redAccent,
                              colorText: Colors.white,
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
