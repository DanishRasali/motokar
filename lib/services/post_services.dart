import 'package:motokar/models/post.dart';

import 'rest.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostService {
  static final PostService _instance = PostService._constructor();
  factory PostService() {
    return _instance;
  }

  PostService._constructor();

  final CollectionReference _postsRef =
      FirebaseFirestore.instance.collection('posts');

  Future<Post> getPost({String id}) async {
    final json = await Rest.get('posts/$id');
    return Post.fromJson(json);
  }

  Future<List<Post>> getPosts() async {
    // final jsonList = await Rest.get('posts');
    // final postList = <Post>[];

    // if (jsonList != null) {
    //   for (int i = 0; i < jsonList.length; i++) {
    //     final json = jsonList[i];
    //     Post post = Post.fromJson(json);
    //     postList.add(post);
    //   }
    // }

    // return postList;

    QuerySnapshot snapshots =
        await _postsRef.orderBy("createdAt", descending: true).get();
    return snapshots.docs
        .map((snapshot) => Post.fromSnapshot(snapshot))
        .toList();
  }

  Future<List<Post>> getPostsByCreatedBy(String createdBy) async {
    QuerySnapshot snapshots =
        await _postsRef.where('createdBy', isEqualTo: createdBy).get();
    return snapshots.docs
        .map((snapshot) => Post.fromSnapshot(snapshot))
        .toList();
  }

  Future createPost(Post post) async {
    if (post.postPicture != null && post.postPicture != '') {
      await Rest.post(
        'posts/',
        data: {
          'content': post.content,
          'postPicture': post.postPicture,
          'createdBy': post.createdBy,
          'createdAt': DateTime.now().millisecondsSinceEpoch.toString()
        },
      );
    } else {
      await Rest.post(
        'posts/',
        data: {
          'content': post.content,
          'postPicture': '',
          'createdBy': post.createdBy,
          'createdAt': DateTime.now().millisecondsSinceEpoch.toString()
        },
      );
    }
  }

  Future<Post> updatePost(
      {String id,
      String content,
      String postPicture,
      String createdby,
      String createdAt}) async {
    if (postPicture != null && postPicture != '') {
      final json = await Rest.patch('posts/$id', data: {
        'content': content,
        'postPicture': postPicture,
        'createdby': createdby,
        'createdAt': createdAt
      });

      return Post.fromJson(json);
    } else {
      final json = await Rest.patch('posts/$id', data: {
        'content': content,
        'createdby': createdby,
        'createdAt': createdAt,
      });

      return Post.fromJson(json);
    }
  }
}
