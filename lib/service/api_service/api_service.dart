import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class APIService {
  static APIService _apiService;

  static APIService get instance {
    if (_apiService == null) {
      _apiService = APIService();
      return _apiService;
    } else {
      return _apiService;
    }
  }

  /// Google
  FirebaseAuth auth = FirebaseAuth.instance;
  User currentGoogleUser;
  GoogleSignIn googleSignIn;
  GoogleSignInAccount googleSignInAccount;
  UserCredential userCredential;
  AuthCredential credential;
  GoogleSignInAuthentication googleSignInAuthentication;

  User get googleUser => currentGoogleUser;

  Future<User> signInWithGoogle() async {
    auth = FirebaseAuth.instance;

    googleSignIn = GoogleSignIn();
    googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      googleSignInAuthentication = await googleSignInAccount.authentication;

      credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        userCredential = await auth.signInWithCredential(credential);

        currentGoogleUser = userCredential.user;
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

    return currentGoogleUser;
  }

  /// Facebook
  FacebookLogin facebookLogin;
  FacebookLoginResult facebookLoginResult;

  Future<FacebookLoginStatus> signInWithFacebook() async {
    facebookLogin = FacebookLogin();
    facebookLoginResult = await facebookLogin.logIn(['email']);
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

  Future<void> googleSignOut() async {
    await auth.signOut();
  }

  Future<void> facebookSignOut() async {
    await facebookLogin.logOut();
  }
}
