import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
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
      try {
        googleSignInAuthentication = await googleSignInAccount.authentication;
      } catch (e, r) {
        print("$e, $r");
      }

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
  // Create an instance of FacebookLogin
  FacebookLogin facebookLogin;
  FacebookLoginResult facebookLoginResult;

  Future<FacebookLoginStatus> signInWithFacebook() async {
    facebookLogin = FacebookLogin();
    try {
      facebookLoginResult = await facebookLogin.expressLogin();
    } catch (e, r) {
      throw e;
    }

    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.cancel:
        print("CancelledByUser");
        return FacebookLoginStatus.cancel;
      case FacebookLoginStatus.success:
        print("LoggedIn");
        return FacebookLoginStatus.success;
      default:
        print("Error");
        return FacebookLoginStatus.error;
    }
  }

  Future<String> getFacebookUserPhotoURL() async {
    final imageUrl = await facebookLogin.getProfileImageUrl(width: 100);
    return imageUrl;
  }

  Future<String> getFacebookUserProfileName() async {
    // Get profile data
    final profile = await facebookLogin.getUserProfile();
    return profile.name;
  }

  Future<void> googleSignOut() async {
    await auth.signOut();
  }

  Future<void> facebookSignOut() async {
    await facebookLogin.logOut();
  }
}
