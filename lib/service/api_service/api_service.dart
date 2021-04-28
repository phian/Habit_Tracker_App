import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class APIService {
  Future<User> signInWithGoogle() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential = await auth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
        } else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        // handle the error here
        throw e;
      }
    }

    return user;
  }

  Future<FacebookLoginStatus> signInWithFacebook() async {
    var facebookLogin = FacebookLogin();
    var facebookLoginResult = await facebookLogin.logIn(['email']);
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.cancelledByUser:
        print("CancelledByUser");
        return FacebookLoginStatus.cancelledByUser;
      case FacebookLoginStatus.loggedIn:
        print("LoggedIn");
        return FacebookLoginStatus.loggedIn;
      default:
        print("Error");
        return FacebookLoginStatus.error;
    }
  }
}
