import 'package:flutter/material.dart';
import 'package:idea_share/services/database_service.dart';
import 'package:idea_share/shared_components/post_item.dart';
import 'package:idea_share/shared_components/shared_button_rectangle.dart';
import 'package:idea_share/views/postAuth/update_post.dart';
import 'package:provider/provider.dart';
import 'package:idea_share/models/post.dart';
import 'package:idea_share/models/user.dart';
import 'package:idea_share/views/postAuth/create_post.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PostList extends StatefulWidget {
  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<List<Post>>(context) ?? [];
    final user = Provider.of<User>(context);
    DatabaseService databaseService = DatabaseService(uid: user.uid);
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return GestureDetector(
            child: PostItem(post: posts[index]),
            onLongPress: () {
              posts[index].senderEmail == user.email
                  ? showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) => SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: SizedBox(
                                width: 300,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    SizedBox(
                                      width: 120,
                                      child: SharedButtonRectangle(
                                          value: 'Edit ✏',
                                          color: ThemeData.dark().buttonColor,
                                          onPressed: () {
                                            showModalBottomSheet(
                                                context: context,
                                                isScrollControlled: true,
                                                builder:
                                                    (BuildContext context) =>
                                                        SingleChildScrollView(
                                                          child: Container(
                                                            padding: EdgeInsets.only(
                                                                bottom: MediaQuery.of(
                                                                        context)
                                                                    .viewInsets
                                                                    .bottom),
                                                            child: UpdatePost(
                                                              post:
                                                                  posts[index],
                                                            ),
                                                          ),
                                                        ));
                                          }),
                                    ),
                                    SizedBox(
                                      width: 120,
                                      child: SharedButtonRectangle(
                                          value: 'Delete ✖',
                                          color: Colors.pinkAccent,
                                          onPressed: () {
                                            databaseService.deleteUserPost(
                                                sentOn: posts[index].sentOn);
                                            Navigator.pop(context);
                                          }),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ))
                  : Fluttertoast.showToast(
                      msg: "You cannot change other user's posts",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIos: 3,
                      backgroundColor: ThemeData.dark().cardColor,
                      textColor: Colors.white,
                      fontSize: 16.0);
            });
      },
    );
  }
}
