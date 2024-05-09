import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as firebase;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/features/home/view/home_view.dart';
import 'package:quiz_app/features/home_tutor/home_tutor_view.dart';
import 'package:quiz_app/features/physics/physics_view.dart';

class AuthenticationView extends ConsumerStatefulWidget {
  const AuthenticationView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AuthenticationViewState();
}

class _AuthenticationViewState extends ConsumerState<AuthenticationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: firebase.FirebaseUIActions(actions: [
      AuthStateChangeAction<SignedIn>(
        (context, state) {
          if (state.user != null) {
            final bool isAdmin =
                (state.user!.uid == 'ke4vXB5HtfNejmIeVssGPC2pFDl1');
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  isAdmin ? const HomeTutorView() : const HomeView(),
            ));
          }
        },
      ),
      AuthStateChangeAction<SigningUp>((context, state) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomeView()));
      }),
    ], child: const firebase.SignInScreen()));
  }
}
