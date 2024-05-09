import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:kartal/kartal.dart';
import 'package:quiz_app/features/add_lessons/add_lessons_view.dart';
import 'package:quiz_app/features/home/view_model/home_view_model.dart';
import 'package:quiz_app/utils/enums/assets_enums.dart';
import 'package:quiz_app/utils/enums/lesson_names.dart';
import 'package:quiz_app/utils/models/exam_model.dart';
import 'package:quiz_app/utils/scheme/color_scheme.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../services/firestore_service.dart';

class HomeTutorView extends ConsumerStatefulWidget {
  const HomeTutorView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeTutorView> with HomeViewModel {
  @override
  void initState() {
    super.initState();
    print(FirebaseAuth.instance.currentUser?.uid ?? 'null');
  }

  @override
  Widget build(BuildContext context) {
    const String lastLessons = 'Son Yüklediğin Dersler';
    const String lastExams = 'Son Sınavlar Sonuçları';

    return Scaffold(
      appBar: _appbar(context),
      bottomNavigationBar: _bottomNavigationBar(),
      body: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          children: [
            _lastLessons(lastLessons, context),
            _lastExams(lastExams, context),
            const Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton.icon(
                  onPressed: () async {
                    await FirestoneService.instance
                        .getExams(LessonNames.Matematik);
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Sinav Getir')),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton.icon(
                  onPressed: () async {
                    await FirestoneService.instance.uploadExam(ExamModel(
                        lessonName: 'fizik',
                        subtitle: 'isik',
                        description: 'descriptionn',
                        videoURL: 'url'));
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Yeni Sinav Ekle')),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          settings: const RouteSettings(),
                          builder: (context) => const AddLessonsView(),
                        ));
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Yeni Ders Ekle')),
            )
          ],
        ),
      ),
    );
  }

  Column _lastExams(String welcomeTitle, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          welcomeTitle,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        const Divider(),
        SizedBox(
          width: double.infinity,
          height: 17.h,
          child: ListView.builder(
            itemCount: 3,
            itemBuilder: (BuildContext context, int index) {
              return Text(
                'Alt konu başlığı',
                style: Theme.of(context).textTheme.headlineSmall,
              );
            },
          ),
        ),
      ],
    );
  }

  Column _lastLessons(String welcomeTitle, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          welcomeTitle,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        const Divider(),
        SizedBox(
          width: double.infinity,
          height: 25.h,
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              return Text(
                'Alt konu başlığı',
                style: Theme.of(context).textTheme.headlineSmall,
              );
            },
          ),
        ),
      ],
    );
  }

  AppBar _appbar(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: context.padding.low,
        child: const CircleAvatar(
          backgroundImage: NetworkImage('https://picsum.photos/200'),
        ),
      ),
      title: const Text(
        'Ahmet Canay',
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
    );
  }

  BottomNavigationBar _bottomNavigationBar() {
    return BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.add_task_rounded), label: 'Sinavlar'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Anasayfa'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ]);
  }
}
