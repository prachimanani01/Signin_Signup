import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  AuthService._();

  static AuthService authService = AuthService._();
  var auth = FirebaseAuth.instance;

  Future<String> registerUser({
    required String email,
    required String password,
  }) async {
    String msg;
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      msg = "Success";
    } on FirebaseAuthException catch (e) {
      msg = e.code;
    }
    return msg;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String msg;
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      msg = "Success";
    } on FirebaseAuthException catch (e) {
      msg = e.code;
    }
    return msg;
  }

  Future<String> signInWithGoogle() async {
    String msg;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      auth.signInWithCredential(credential);
      msg = "Success";
    } on FirebaseAuthException catch (e) {
      msg = e.code;
    }
    return msg;
  }

  Future<void> logOut() async {
    await auth.signOut();
    await signInWithGoogle().signOut();
  }
}

extension on Future<String> {
  signOut() {}
}
