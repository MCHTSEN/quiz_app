import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:kartal/kartal.dart';
import 'package:quiz_app/features/add_lessons/add_lessons_view.dart';
import 'package:quiz_app/features/authentication/authentication_view.dart';
import 'package:quiz_app/features/home/view_model/home_view_model.dart';
import 'package:quiz_app/features/profile/profile_view.dart';
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

class _HomeViewState extends ConsumerState<HomeTutorView>
    with HomeViewModel, SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    print(FirebaseAuth.instance.currentUser?.uid ?? 'null');
  }

  @override
  Widget build(BuildContext context) {
    const String lastLessons = 'Son Yüklediğin Dersler';
    const String lastExams = 'Son Sınavlar Sonuçları';

    return Scaffold(
      appBar: _appbar(context),
      // bottomNavigationBar: _bottomNavigationBar(),
      bottomNavigationBar: BottomAppBar(
        height: 10.h,
        // padding: EdgeInsets.zero,

        child: TabBar(
          labelPadding: EdgeInsetsDirectional.zero,
          controller: _tabController,
          tabs: const [
            Tab(
              icon: Icon(Icons.home),
              text: 'Ana Sayfa',
            ),
            Tab(
              icon: Icon(Icons.person),
              text: 'Profil',
            ),
          ],
        ),
      ),
      body: TabBarView(controller: _tabController, children: [
        Padding(
          padding: EdgeInsets.all(4.w),
          child: Column(
            children: [
              _lastLessons(lastLessons, context),
              _lastExams(lastExams, context),
              const Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddLessonsView(),
                          ));
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Yeni Ders Ekle')),
              )
            ],
          ),
        ),
        const ProfileView()
      ]),
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
      actions: [
        IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AuthenticationView(),
                  ));
            },
            icon: const Icon(Icons.logout))
      ],
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

class BackgroundImageFb1 extends StatelessWidget {
  final Widget child;
  final String imageUrl;
  const BackgroundImageFb1(
      {required this.child, required this.imageUrl, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Place as the child widget of a scaffold
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/backgrounds%2Fgradienta-26WixHTutxc-unsplash.jpg?alt=media&token=4b3d4985-d8fb-40e9-928f-cf7b4502a858"),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
