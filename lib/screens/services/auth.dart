import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/models/userR.dart';
import 'package:flutter_app/screens/services/database.dart';

/* 
For those who are watching this in 2020 , you should change part of code:
AuthResult ---> UserCredential
FirebaseUser --> User
 UserCredential userCredential = await _auth.signInAnonymously();
 User user = userCredential.user;
*/ 

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  //create user obj based on FirebaseUser
  UserR _userFromFirebaseUser(User user) {
    return user != null ? UserR(uid: user.uid) : null;

  }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  //auth  change user stream
  Stream<UserR> get user {
    return _auth.authStateChanges()
      //.map((User user) => _userFromFirebaseUser(user));
      .map(_userFromFirebaseUser);
  }

  // sign in with email & password
    // ignore: non_constant_identifier_names
    Future SignInWhitEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email.trim(), password: password.trim());
      User user = result.user;
      FirebaseAuthException(message:'error');
      return _userFromFirebaseUser(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  // register with email & password
  Future registerWhitEmailAndPassword(String email, String password, String nombre, int documento) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email.trim(), password: password.trim());
      User user = result.user;

      //create a new dcument for the user whit the uid
      await DatabaseService(uid: user.uid).updateUserData(email,nombre,documento);

      return _userFromFirebaseUser(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      print('Cerrando sesion');
      return await _auth.signOut();
    } catch(e){
      print(e.toString());
      return null;
    }
  }
}