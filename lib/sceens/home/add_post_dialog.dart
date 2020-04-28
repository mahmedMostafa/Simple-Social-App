import 'package:flutter/material.dart';
import 'package:my_social/models/post.dart';
import 'package:my_social/models/user.dart';
import 'package:my_social/services/database.dart';
import 'package:my_social/util/utils.dart';

class AddPostDialog extends StatelessWidget {

  String _postTitle;
  String _postContent;
  User currentUser;

  void _onPressed(context){
    DatabaseService().createPost(_postTitle, _postContent);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 0.0,
      backgroundColor: Colors.white,
      child: Container(
        height: 300.0,
        width: 300.0,
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 250.0,
                child: TextFormField(
                  decoration: textInputDecoration.copyWith(labelText: "Post title"),
                  onChanged: (value) => _postTitle = value
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                width: 250.0,
                child: TextFormField(
                  decoration: textInputDecoration.copyWith(labelText: "Post Content"),
                  onChanged: (value) => _postContent = value,
                ),
              ),
              SizedBox(height: 20.0),
              ButtonTheme(
                buttonColor: Colors.green,
                minWidth: 250.0,
                height: 46.0,
                child: RaisedButton(
                  color: Colors.green,
                  child: Text(
                    "Add Post",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed:()=> _onPressed(context),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
