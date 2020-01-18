import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobx/mobx.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_controller.g.dart';

class AuthController = _AuthController with _$AuthController;

abstract class _AuthController with Store {
  _AuthController() {
    getCurrentUser();
  }

  final _firebaseAuth = FirebaseAuth.instance;

  @computed
  ObservableStream<FirebaseUser> get authStream =>
      FirebaseAuth.instance.onAuthStateChanged.asObservable();

  @observable
  bool loading = false;

  @observable
  String error = '';

  @action
  Future<void> getCurrentUser() async {
    try {
      loading = true;

      await _firebaseAuth.currentUser();

      loading = false;
    } catch (e) {
      loading = false;

      throw e;
    }
  }

  @action
  Future<void> signInWithGoogle() async {
    try {
      loading = true;

      GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount googleAccount = await googleSignIn.signIn();

      if (googleAccount != null) {
        GoogleSignInAuthentication googleAuth =
            await googleAccount.authentication;

        await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.getCredential(
            idToken: googleAuth.idToken,
            accessToken: googleAuth.accessToken,
          ),
        );
      }

      loading = false;
    } catch (e) {
      loading = false;

      throw e;
    }
  }

  @action
  Future<void> signOut() async {
    try {
      loading = true;
      
      final googleSignIn = GoogleSignIn();
      googleSignIn.signOut();
      await _firebaseAuth.signOut();

      loading = false;
    } catch (e) {
      loading = false;

      error = 'Erro ao deslogar, tente novamente.';

      throw e;
    }
  }
}
