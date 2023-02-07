import 'package:brew_crew/models/user.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  //get an instance of FirebaseAuth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create User object based on firebase user
  User? _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(uid: user.uid):null;
  }

  // auth change user stream
  Stream<User?> get user{
    return _auth.onAuthStateChanged.map(((FirebaseUser user) => _userFromFirebaseUser(user)));
  }

  Future signInAnon() async {
    try{
      AuthResult res = await _auth.signInAnonymously();
      FirebaseUser user = res.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }

  }
  
  // sign in anonymously

  //sign in with email and password

  //register with email and password

  //sign out
  Future signOut() async{
    try {
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}