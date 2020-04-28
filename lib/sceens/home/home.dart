import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_social/models/post.dart';
import 'package:my_social/sceens/home/add_post_dialog.dart';
import 'package:my_social/sceens/home/posts_list.dart';
import 'package:my_social/services/auth.dart';
import 'package:my_social/services/database.dart';
import 'package:my_social/util/utils.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  static String id = "home_screen";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final _currentUser = AuthService().getCurrentUser();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Post>>.value(
      value: DatabaseService().posts,
      child: Scaffold(
        appBar: AppBar(
          elevation: 4.0,
          title: Text("Home"),
        ),
        body: Container(
          color: Colors.white,
          child: PostsList(),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.green,
          onPressed: (){
            showDialog(context: context,builder: (context){
              return AddPostDialog();
            });
          },
        ),
      ),
    );
  }
}
