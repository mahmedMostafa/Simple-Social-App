import 'package:flutter/material.dart';
import 'package:my_social/models/post.dart';
import 'package:my_social/sceens/home/post_tile.dart';
import 'package:provider/provider.dart';

class PostsList extends StatefulWidget {
  @override
  _PostsListState createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<List<Post>>(context) ?? [];

    return ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return PostTile(post: posts[index]);
        });
  }
}
