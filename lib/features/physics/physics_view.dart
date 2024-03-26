import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhysicsView extends ConsumerStatefulWidget {
  const PhysicsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PhysicsViewState();
}

class _PhysicsViewState extends ConsumerState<PhysicsView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('jj')),
    );
  }
}
