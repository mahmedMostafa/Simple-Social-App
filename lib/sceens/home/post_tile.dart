import 'package:flutter/material.dart';
import 'package:my_social/models/post.dart';

class PostTile extends StatelessWidget {
  final Post post;

  PostTile({this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: Card(
        elevation: 6.0,
        margin: EdgeInsets.all(4.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundImage: AssetImage('assets/profile_image.png'),
          ),
          title: Text(post.postTitle),
          subtitle: Text(post.postContent)
        ),
      ),
    );
  }
}
