import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_social/models/post.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  final Firestore root = Firestore.instance;

  Future createUser(String name, String email, String phoneNumber) async {
    return await root
        .collection("users")
        .document(uid)
        .setData({"name": name, "email": email, "phone": phoneNumber});
  }

  Future createPost(String postTitle, String postContent) async {
    final Map<String,dynamic> post = {
      "postTitle": postTitle,
      "postContent": postContent
    };

    await root
        .collection("users")
        .document(uid)
        .collection("posts")
        .document()
        .setData(post);
    return await root.collection("posts").document().setData(post);
  }

  List<Post> _postsFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.documents.map((post) {
      return Post(
          postTitle: post.data['postTitle'] ?? "",
          postContent: post.data['postContent'] ?? "");
    }).toList();
  }

  Stream<List<Post>> get posts {
    return root.collection("posts").snapshots().map(_postsFromSnapshot);
  }
}
