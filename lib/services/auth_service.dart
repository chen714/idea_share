import 'package:firebase_auth/firebase_auth.dart';
import 'package:idea_share/models/user.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:password_compromised/password_compromised.dart';

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
        showToast("An error has occured pleased sign in!");
      });

      //create new document for user with the uid
      return _userFromFirebaseUser(fUser);
    } catch (e) {
      if (e.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
        showToast("This email is in use choose another one!");
      } else if (e.code == 'ERROR_NETWORK_REQUEST_FAILED') {
        showToast(
            "An error has occured while trying to connect to the internet. \nInternet connection is required to use this application. \nPlease try again later. ");
      } else {
        showToast("An error has occured pleased check the fields!");
      }

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
      if (e.code == 'ERROR_WRONG_PASSWORD' ||
          e.code == 'ERROR_USER_NOT_FOUND') {
        showToast(
            "Incorrect username or passowed \nplease check login credentials and try again.");
      } else if (e.code == 'ERROR_NETWORK_REQUEST_FAILED') {
        showToast(
            "An error has occured while trying to connect to the internet. \nInternet connection is required to use this application. \nPlease try again later. ");
      } else {
        showToast("An error has occured pleased try again later");
      }

      return null;
    }
  }

  //logout
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      showToast(
          "An error occurred while logging you out. \nPlease check internet connection and try again later. ");
      return null;
    }
  }

  void showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
