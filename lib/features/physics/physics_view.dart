import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/utils/constants/quiz_api_keys.dart';

class PhysicsView extends ConsumerStatefulWidget {
  const PhysicsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PhysicsViewState();
}

class _PhysicsViewState extends ConsumerState<PhysicsView> {
  @override
  Widget build(BuildContext context) {
    print(ApiKeys.iosFirebaseApi);
    return const Scaffold(
      body: Center(child: Text('jj')),
    );
  }
}
