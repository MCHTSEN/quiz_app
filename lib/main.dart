import 'package:flutter/material.dart';
import 'package:quiz_app/features/home/view/home_view.dart';
import 'package:quiz_app/utils/scheme/quiz_theme.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (BuildContext, Orientation, ScreenType) {
        return MaterialApp(
            theme: quizTheme,
            debugShowCheckedModeBanner: false,
            home: const HomeView());
      },
    );
  }
}
