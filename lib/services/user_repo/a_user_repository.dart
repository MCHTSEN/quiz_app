import 'package:quiz_app/utils/models/my_user_model.dart';

abstract class UserRepository {
  Stream<MyUser?> get user;
  Future<MyUser> signUp(MyUser myUser, String password);
  Future<void> setUserData(MyUser myUser);
  Future<void> signIn(String email, String password);
  Future<void> logOut();
}
