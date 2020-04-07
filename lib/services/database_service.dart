import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:idea_share/models/post.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

final encryptorKey = encrypt.Key.fromLength(32);
final initializationVector = encrypt.IV.fromLength(16);
final encrypter = encrypt.Encrypter(encrypt.AES(encryptorKey));

class DatabaseService {
  final String uid;
  DatabaseService({@required this.uid});

  //collection referance
  final CollectionReference _userPosts = Firestore.instance.collection('posts');

  Future updateUserPost({DateTime sentOn, String message}) async {
    return await _userPosts
        .document('$uid-${sentOn.toString().substring(0, 20)}')
        .updateData({
      'message': encrypter.encrypt(message, iv: initializationVector).base64,
    }).whenComplete(() {
      Fluttertoast.showToast(
          msg: "Post updated",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 3,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    }).catchError((e) {
      Fluttertoast.showToast(
          msg:
              "An error has occured while trying to update your post. \nPlease try again later. ",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  Future createUserPost({Post post}) async {
    return await _userPosts
        .document('$uid-${post.sentOn.toString().substring(0, 20)}')
        .setData({
      'sentOn': post.sentOn,
      'sender': post.sender,
      'senderEmail': post.senderEmail,
      'message':
          encrypter.encrypt(post.message, iv: initializationVector).base64,
    }).whenComplete(() {
      Fluttertoast.showToast(
          msg: "Post made",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 3,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    }).catchError((e) {
      Fluttertoast.showToast(
          msg:
              "An error has occured while trying to upload your post. \nPlease try again later. ",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  //create post list from snapshot
  List<Post> _postListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Post(
          sentOn: doc.data['sentOn'].toDate() ?? DateTime.now(),
          sender: doc.data['sender'] ?? ' ',
          senderEmail: doc.data['senderEmail'] ?? ' ',
          message: encrypter.decrypt64(doc.data['message'],
                  iv: initializationVector) ??
              ' ');
    }).toList();
  }

  //get post stream
  Stream<List<Post>> get posts {
    return _userPosts
        .orderBy('sentOn', descending: true)
        .snapshots()
        .map(_postListFromSnapshot)
        .handleError((e) {
      Fluttertoast.showToast(
          msg:
              "An error has occured while trying to retrive your feed. \nPlease try again later. ",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  Future deleteUserPost({DateTime sentOn}) async {
    return await _userPosts
        .document('$uid-${sentOn.toString().substring(0, 20)}')
        .delete()
        .whenComplete(() {
      Fluttertoast.showToast(
          msg: "Post deleted",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 3,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    }).catchError((e) {
      Fluttertoast.showToast(
          msg:
              "An error has occured while trying to delete your post. \nPlease try again later. ",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }
}
