import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:quiz_app/features/add_lessons/add_exam/add_exam_view.dart';
import 'package:quiz_app/features/add_lessons/add_lessons_view.dart';
import 'package:quiz_app/features/home/view/home_view.dart';
import 'package:quiz_app/features/home_tutor/home_tutor_view.dart';
import 'package:quiz_app/features/physics/physics_view.dart';
import 'package:quiz_app/firebase_options.dart';
import 'package:quiz_app/utils/scheme/quiz_theme.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
            home: const AddLessonsView());
      },
    );
  }
}
