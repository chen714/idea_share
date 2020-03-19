import 'package:flutter/material.dart';
import 'package:idea_share/models/post.dart';
import 'package:idea_share/models/user.dart';
import 'package:idea_share/services/database_service.dart';

import 'package:idea_share/shared_components/shared_button_rectangle.dart';
import 'package:provider/provider.dart';
import 'package:idea_share/shared_components/constants.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class UpdatePost extends StatefulWidget {
  Post post;
  UpdatePost({@required this.post});
  @override
  _UpdatePostState createState() => _UpdatePostState();
}

class _UpdatePostState extends State<UpdatePost> {
  //state
  final _formKey = GlobalKey<FormState>();

  //form values
  String _message;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    DatabaseService _databaseService = DatabaseService(uid: user.uid);
    return Container(
      color: Color(0xFF323230),
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: ThemeData.dark().scaffoldBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text(
                'Update Post',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                initialValue: widget.post.message,
                maxLength: 300,
                maxLines: 8,
                maxLengthEnforced: true,
                decoration: textFieldDecoration.copyWith(
                  hintText: 'Enter your update..',
                ),
                validator: Validators.compose([
                  Validators.required('Please enter your update'),
                  Validators.maxLength(300, 'Max update length 300'),
                  Validators.minLength(
                      5, 'Posts need to be longer then 5 characters.'),
                  Validators.patternRegExp(
                      RegExp("^[A-Za-z0-9_().,?/@!'--+*/ ]*\$"),
                      'Only alphanumeric characters, punctuation \nunderscores and at symbol are allowed')
                ]),
                onChanged: (value) {
                  setState(() {
                    _message = value;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              SharedButtonRectangle(
                color: ThemeData.dark().buttonColor,
                value: 'Update Post! 📧',
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    await _databaseService.updateUserPost(
                      sentOn: widget.post.sentOn,
                      message: _message,
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
