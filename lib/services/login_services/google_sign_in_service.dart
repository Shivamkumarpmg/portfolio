import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider{
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWithGoogle()async{
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if(googleUser == null)  return null;
    final GoogleSignInAuthentication authentication  = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: authentication.accessToken,
      idToken: authentication.idToken
    );

    final UserCredential userCredential = await _auth.signInWithCredential(credential);
    return userCredential.user;


  }

}