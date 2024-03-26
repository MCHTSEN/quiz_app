import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:kartal/kartal.dart';
import 'package:quiz_app/utils/enums/assets_enums.dart';
import 'package:quiz_app/utils/scheme/color_scheme.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../view_model/home_view_model.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> with HomeViewModel {
  final String welcomeTitle = 'Hoşgeldin!\nDers çalışmaya hemen başla.';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(context),
      bottomNavigationBar: _bottomNavigationBar(),
      body: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Gap(1.h),
            Text(
              welcomeTitle,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Gap(1.h),
            SizedBox(
              width: 90.w,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: listItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      navigate(context, index);
                    },
                    child: Container(
                      height: 20.h,
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: context.border.normalBorderRadius,
                        border: Border.all(
                          color: QuizColorScheme.fourthColor,
                          width: 0.5,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            listItems[index].path,
                            height: 15.h,
                          ),
                          Text(
                            listItems[index].title,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          const Icon(Icons.chevron_right)
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
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
