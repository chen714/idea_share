import 'package:flutter/material.dart';
import 'package:idea_share/models/post.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';

class PostItem extends StatelessWidget {
  final Post post;
  PostItem({this.post});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircularProfileAvatar(
            '',
            radius: 25,
            backgroundColor: Colors.blueGrey,
            initialsText: Text(
              post.sender[0],
              style: TextStyle(fontSize: 40, color: Colors.white),
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(post.sender),
              Text(
                post.sentOn.toString().substring(2, 16),
                style: TextStyle(
                    fontSize: 10, color: ThemeData.dark().disabledColor),
              )
            ],
          ),
          subtitle: Text(post.message),
        ),
      ),
    );
  }
}
