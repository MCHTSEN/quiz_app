import 'package:flutter/material.dart';
import 'package:quiz_app/features/home/view/home_view.dart';
import 'package:quiz_app/features/physics/physics_view.dart';
import 'package:quiz_app/utils/enums/assets_enums.dart';

mixin HomeViewModel {
  int selectedIndex = 0;

  final List<ListItem> listItems = [
    ListItem(
      title: 'Fizik',
      path: ImageEnums.physics.path,
      onTap: () {
        print('Öğe 1 tıklandı');
      },
    ),
    ListItem(
      title: 'Matematik',
      path: ImageEnums.math.path,
      onTap: () {},
    ),
  ];

  void navigate(BuildContext context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              index == 0 ? const PhysicsView() : const HomeView()),
    );
  }
}

class ListItem {
  final String title;
  final VoidCallback onTap;
  final String path;

  ListItem({
    required this.title,
    required this.onTap,
    required this.path,
  });
}
