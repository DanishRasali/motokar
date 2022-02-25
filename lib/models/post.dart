import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String _id;
  String _content;
  String _postPicture;
  String _createdBy;
  String _createdAt;

  get id => _id;
  set id(value) => _id = value;

  get content => _content;
  set content(value) => _content = value;

  get postPicture => _postPicture;
  set postPicture(value) => _postPicture = value;

  get createdBy => _createdBy;
  set createdBy(value) => _createdBy = value;

  get createdAt => _createdAt;
  set createdAt(value) => _createdAt = value;

  Post(
      {String id,
      String content = '',
      String postPicture = '',
      String createdBy = '',
      String createdAt = ''})
      : _id = id,
        _content = content,
        _postPicture = postPicture,
        _createdBy = createdBy,
        _createdAt = createdAt;

  factory Post.createNew(
          {String id,
          String content,
          String postPicture,
          String createdBy,
          String createdAt}) =>
      Post(
        id: id,
        content: content,
        postPicture: postPicture,
        createdBy: createdBy,
        createdAt: createdAt
      );

  factory Post.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> json = snapshot.data();
    json['id'] = snapshot.id;
    return Post.fromJson(json);
  }

  Post.copy(Post from)
      : this(
            id: from.id,
            content: from.content,
            postPicture: from.postPicture,
            createdBy: from.createdBy,
            createdAt: from.createdAt);

  factory Post.fromRawJson(String str) => Post.fromJson(jsonDecode(str));

  Post.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id'],
            content: json['content'],
            postPicture: json['postPicture'],
            createdBy: json['createdBy'],
            createdAt: json['createdAt']);

  String toRawJson() => jsonEncode(toJson());

  Map<String, dynamic> toJson() => {
        'content': content,
        'postPicture': postPicture,
        'createdBy': createdBy,
        'createdAt': createdAt
      };
}
