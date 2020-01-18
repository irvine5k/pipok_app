import 'package:mobx/mobx.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_controller.g.dart';

class AuthController = _AuthController with _$AuthController;

abstract class _AuthController with Store {
  @observable
  FirebaseUser user;

  @observable
  bool loading = false;

  @observable
  String error = '';

  @action
  Future<void> signInAnonymously() async {
    try {
      loading = true;

      final result = await FirebaseAuth.instance.signInAnonymously();

      user = result.user;

      loading = false;
    } catch (e) {
      loading = false;

      error = 'Erro ao entrar anonimamente, tente novamente.';

      throw e;
    }
  }

  @action
  Future<void> signOut() async {
    try {
      loading = true;

      await FirebaseAuth.instance.signOut();

      user = null;

      loading = false;
    } catch (e) {
      loading = false;

      error = 'Erro ao deslogar, tente novamente.';

      throw e;
    }
  }
}
