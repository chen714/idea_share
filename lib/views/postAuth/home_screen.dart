import 'package:flutter/material.dart';
import 'package:idea_share/models/post.dart';
import 'package:idea_share/services/auth_service.dart';
import 'package:idea_share/services/database_service.dart';
import 'package:idea_share/views/postAuth/create_post.dart';
import 'package:idea_share/views/postAuth/post_list.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Post>>.value(
      value: DatabaseService().posts,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text(
            'Idea Share',
            style: TextStyle(fontFamily: 'Pacifico', fontSize: 50),
          ),
          actions: <Widget>[
            FlatButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(Icons.remove_circle_outline),
              label: Text('logout'),
            ),
          ],
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    alignment: Alignment.bottomCenter,
                    fit: BoxFit.fitWidth,
                    image: AssetImage('assets/ideas.png'))),
            child: PostList()),
        floatingActionButton: FloatingActionButton(
          elevation: 10,
          child: Text(
            '💡',
            style: TextStyle(fontSize: 30),
          ),
          backgroundColor: Colors.pinkAccent,
          onPressed: () {
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context) => SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: CreatePost(),
                      ),
                    ));
          },
        ),
      ),
    );
  }
}
