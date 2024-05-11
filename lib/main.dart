import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/features/add_lessons/add_exam/add_exam_view.dart';
import 'package:quiz_app/features/add_lessons/add_lessons_view.dart';
import 'package:quiz_app/features/authentication/authentication_view.dart';
import 'package:quiz_app/features/home/view/home_view.dart';
import 'package:quiz_app/features/home_tutor/home_tutor_view.dart';
import 'package:quiz_app/features/lesson/lesson_view.dart';
import 'package:quiz_app/features/result_exam/result_exam_view.dart';
import 'package:quiz_app/features/take_lesson/take_lesson_view.dart';
import 'package:quiz_app/firebase_options.dart';
import 'package:quiz_app/utils/models/exam_model.dart';
import 'package:quiz_app/utils/models/question_model.dart';
import 'package:quiz_app/utils/scheme/quiz_theme.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
  ]);
  runApp(const ProviderScope(child: MainApp()));
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
            home: AuthenticationView()
//             TakeLessonView(LessonModel(
//               lessonName: 'Matematik',
//               subtitle: 'Kesirlerin Temel Kavramları',
//               videoURL:
//                   'https://www.youtube.com/watch?v=v-k6u54UsOA&list=RDv-k6u54UsOA&start_radio=1',
//               description: '''
// Matematikte kesirler, bir tam sayıyı bölünebilen bir parça veya parçaların toplamı olarak temsil eder. Kesirler, bir pay ve bir payda olmak üzere iki bileşenden oluşur. Pay, kesirde kaç parça olduğunu belirtirken, payda ise parçaların toplamının kaçıncı bölüm olduğunu belirtir.

// Bu ders, matematikte kesirlerin temel kavramlarına genel bir giriş sunmaktadır. Dersin içeriği şunları içermektedir:
// - Kesirlerin tanımı ve temel kavramlar
// - Kesirlerin basit hali
// - Kesirleri karşılaştırma ve sıralama
// - Kesirlerin toplama, çıkarma, çarpma ve bölme işlemleri
// - Kesirlerin ondalık ve yüzde karşılıkları

// Bu dersi tamamladıktan sonra, kesirlerle ilgili temel kavramları anlayacak ve bu kavramları günlük hayatta ve matematik problemlerinde uygulayabileceksiniz.
// ''',
//               questionModel: [
//                 QuestionModel(
//                   question: '5/6 ile 2/3 kesirlerinin toplamı nedir?',
//                   answers: ['7/9', '1', '1 1/2', '3/4'],
//                   correctAnswer: 'A',
//                 ),
//                 QuestionModel(
//                   question: 'Bir kesirde payın sıfır olması durumu nedir?',
//                   answers: [
//                     'Sıfır kesiri',
//                     'Olasılık kesiri',
//                     'Birlik kesiri',
//                     'Negatif kesir'
//                   ],
//                   correctAnswer: 'A',
//                 ),
//                 QuestionModel(
//                   question: '3/4 kesrinin ondalık karşılığı nedir?',
//                   answers: ['0.75', '1.25', '0.5', '0.33'],
//                   correctAnswer: 'A',
//                 ),
//                 QuestionModel(
//                   question: '5/6 ile 2/3 kesirlerinin toplamı nedir?',
//                   answers: ['7/9', '1', '1 1/2', '3/4'],
//                   correctAnswer: 'A',
//                 ),
//                 QuestionModel(
//                   question: 'Bir kesirde payın sıfır olması durumu nedir?',
//                   answers: [
//                     'Sıfır kesiri',
//                     'Olasılık kesiri',
//                     'Birlik kesiri',
//                     'Negatif kesir'
//                   ],
//                   correctAnswer: 'A',
//                 ),
//                 QuestionModel(
//                   question: '3/4 kesrinin ondalık karşılığı nedir?',
//                   answers: ['0.75', '1.25', '0.5', '0.33'],
//                   correctAnswer: 'A',
//                 ),
//                 QuestionModel(
//                   question: '5/6 ile 2/3 kesirlerinin toplamı nedir?',
//                   answers: ['7/9', '1', '1 1/2', '3/4'],
//                   correctAnswer: 'A',
//                 ),
//                 QuestionModel(
//                   question: 'Bir kesirde payın sıfır olması durumu nedir?',
//                   answers: [
//                     'Sıfır kesiri',
//                     'Olasılık kesiri',
//                     'Birlik kesiri',
//                     'Negatif kesir'
//                   ],
//                   correctAnswer: 'A',
//                 ),
//                 QuestionModel(
//                   question: '3/4 kesrinin ondalık karşılığı nedir?',
//                   answers: ['0.75', '1.25', '0.5', '0.33'],
//                   correctAnswer: 'A',
//                 ),
//                 QuestionModel(
//                   question: '3/4 kesrinin ondalık karşılığı nedir?',
//                   answers: ['0.75', '1.25', '0.5', '0.33'],
//                   correctAnswer: 'A',
//                 ),
//               ],
//             ))
            );
      },
    );
  }
}
