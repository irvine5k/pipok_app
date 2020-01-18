import 'package:mobx/mobx.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_controller.g.dart';

class AuthController = _AuthController with _$AuthController;

abstract class _AuthController with Store {
  @observable
  FirebaseUser user;

  @action
  Future<void> signInAnonymously() async {
    try {
      final result = await FirebaseAuth.instance.signInAnonymously();

      user = result.user;
    } catch (e) {
      throw e;
    }
  }
}
