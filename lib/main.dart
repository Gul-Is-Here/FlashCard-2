import 'package:flashcard/views/categories.dart';
import 'package:flashcard/views/home_view.dart';
import 'package:flashcard/views/progress.dart';
import 'package:flashcard/views/quiz.dart';
import 'package:flashcard/views/splash.dart';
import 'package:flashcard/widgets/bottom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/bottom_NAV.dart';
import 'controllers/theme_controller.dart';
import 'controllers/flashcard_controller.dart';
import 'controllers/quiz_controller.dart';
import 'models/quiz_model.dart';
import 'utils/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Put controllers
  Get.put(ThemeController());
  Get.put(FlashcardController());
  Get.put(QuizController());
  Get.put(BottomNavController());

  runApp(LanguageFlashcardsApp());
}

class LanguageFlashcardsApp extends StatelessWidget {
  final ThemeController themeController = Get.find();
  final BottomNavController bottomNavController = Get.find();

  final List<Widget> pages = [
    HomeView(),
    CategoriesView(),
    QuizScreen(questions: predefinedQuiz),
    ProgressView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Language Flashcards',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeController.theme,
        home: Obx(() {
          // Show Splash for 3 seconds then main app
          if (bottomNavController.isSplashFinished.value == false) {
            return SplashView();
          }
          return Scaffold(
            appBar: AppBar(
              title: Text('Language Flashcards'),
              actions: [
                IconButton(
                  icon: Icon(themeController.isDarkMode.value ? Icons.light_mode : Icons.dark_mode),
                  onPressed: () => themeController.toggleTheme(),
                )
              ],
            ),
            body: pages[bottomNavController.selectedIndex.value],
            bottomNavigationBar: BottomNavBar(
              selectedIndex: bottomNavController.selectedIndex,
              onTap: bottomNavController.changeIndex,
            ),
          );
        }),
      );
    });
  }
}
