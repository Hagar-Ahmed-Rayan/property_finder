import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

//    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

Future<User?> signInWithGoogle() async {
  final GoogleSignInAccount? googleUser = await googleSignIn.signIn(); //
  print(googleUser);
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  if (googleUser != null) {
    print("GoogleSignInAccounttttttttttttttttttttttttttttttttttttttttttttttttttt");
    print(googleAuth);
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    try {
      //  FirebaseAuth.instance.setLogLevel(LogLevel.verbose);
      final UserCredential userCredential = await _auth.signInWithCredential(credential);

      // Access the signed-in user's information here
      // final User? user = userCredential.user;

      return userCredential.user;
    } catch (e) {
      print("Sign in with Google failed: $e");

      // Handle sign-in errors if any
    }
  }

  throw Exception('Google sign-in was canceled or unsuccessful.');
}

Future<User?> authenticateWithGoogle() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication? googleSignInAuthentication = await googleSignInAccount?.authentication;
  if (googleSignInAccount != null) {
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication?.accessToken,
      idToken: googleSignInAuthentication?.idToken,
    );
    final UserCredential authResult = await auth.signInWithCredential(credential);
    return authResult.user;
  }
  return null;
}

////https://propertyfinder-e71fb.firebaseapp.com/__/auth/handler
void signOut() async {
  await _auth.signOut(); // Sign out from Firebase Auth

  await googleSignIn.signOut(); // Sign out from Google SignIn

  print('User signed out');
}

Future<UserCredential?> signInWithFacebook() async {
  try {
    // Trigger the Facebook sign-in flow
    final LoginResult result = await FacebookAuth.instance.login();

    // Obtain an access token from the signed-in user
    final OAuthCredential credential = FacebookAuthProvider.credential(result.accessToken!.token);

    // Sign in to Firebase with the Facebook credentials
    final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    return userCredential;
  } catch (e) {
    print('Sign in with Facebook failed: $e');
    return null;
  }
}

Future<void> verifyPhoneNumber(String phoneNumber) async {
  final PhoneVerificationCompleted verified = (AuthCredential authResult) {
    // Handle successful authentication (e.g., sign-in, navigation)
    print('Phone Verification Completed');
    signInWithCredential(authResult);
  };

  final PhoneVerificationFailed verificationFailed = (FirebaseAuthException authException) {
    // Handle error during verification process
    print('Phone Verification Failed - Error Code: ${authException.code}, Message: ${authException.message}');
  };

  final PhoneCodeSent smsSent = (String? verId, [int? forceResend]) {
    // Store verification ID for later use
    print('SMS Sent - Verification ID: $verId');
  };

  final PhoneCodeAutoRetrievalTimeout autoTimeout = (String? verId) {
    // Auto-retrieval timeout callback
    print('Auto-Retrieval Timeout - Verification ID: $verId');
  };

  await FirebaseAuth.instance.verifyPhoneNumber(phoneNumber: phoneNumber, verificationCompleted: verified, verificationFailed: verificationFailed, codeSent: smsSent, codeAutoRetrievalTimeout: autoTimeout);
}

Future<void> signInWithCredential(AuthCredential credential) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    // Handle successful sign-in (e.g., save user data, navigate to home screen)
    print('Sign In Successful - UID: ${userCredential.user?.uid}');
  } catch (e) {
    // Handle sign-in error
    print('Sign In Error - ${e.toString()}');
  }
}
