import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  //get an instance of FirebaseAuth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signInAnon() async {
    try{
      AuthResult res = await _auth.signInAnonymously();
      FirebaseUser user = res.user;
      return user;
    }catch(e){
      print(e.toString());
      return null;
    }

  }
  
  // sign in anonymously

  //sign in with email and password

  //register with email and password

  //sign out
}