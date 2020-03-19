import 'package:firebase_auth/firebase_auth.dart';
import 'package:idea_share/models/user.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null
        ? User(uid: user.uid, email: user.email, name: user.displayName)
        : null;
  }

  //getCurrentLoggedInUser
  Future<User> currentUser() async {
    return _userFromFirebaseUser(await _auth.currentUser());
  }

  //auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  //register with email and password
  Future registerWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser fUser = await _auth.currentUser();
      UserUpdateInfo updateInfo = UserUpdateInfo();
      updateInfo.displayName = name;

      await fUser.updateProfile(updateInfo).whenComplete(() async {
        //relevant signout code below as user.reload won't update user object until signin/signout
        //forced and only way to ensure DisplayName is available immediately on first log in
        await _auth.signOut();
        AuthResult result2 = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        fUser = await _auth.currentUser();
      }).catchError((e) {
        _auth.signOut();
        Fluttertoast.showToast(
            msg: "An error has occured pleased sign in!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      });

      print('---------------------------------------${fUser.displayName}');
      //create new document for user with the uid
      return _userFromFirebaseUser(fUser);
    } catch (e) {
      print(e);
      e.code == 'ERROR_EMAIL_ALREADY_IN_USE'
          ? Fluttertoast.showToast(
              msg: "This email is in use choose another one!",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 3,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0)
          : Fluttertoast.showToast(
              msg: "An error has occured pleased check the fields!",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 3,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);

      return null;
    }
  }

  //signin with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser fUser = result.user;
      return _userFromFirebaseUser(fUser);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //logout
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
