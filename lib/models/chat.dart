import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  String _id;
  String _creatorId;
  String _receiverId;
  String _message;
  String _createdAt;

  get id => _id;
  set id(value) => _id = value;

  get creatorId => _creatorId;
  set creatorId(value) => _creatorId = value;

  get receiverId => _receiverId;
  set receiverId(value) => _receiverId = value;

  get message => _message;
  set message(value) => _message = value;

  get createdAt => _createdAt;
  set createdAt(value) => _createdAt = value;

  Chat(
      {String id,
      String creatorId = '',
      String receiverId = '',
      String message = '',
      String createdAt = ''})
      : _id = id,
        _creatorId = creatorId,
        _receiverId = receiverId,
        _message = message,
        _createdAt = createdAt;

  factory Chat.createNew(
          {String id,
          String creatorId,
          String receiverId,
          String message,
          String createdAt}) =>
      Chat(
        id: id,
        creatorId: creatorId,
        receiverId: receiverId,
        message: message,
        createdAt: createdAt
      );

  factory Chat.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> json = snapshot.data();
    json['id'] = snapshot.id;
    return Chat.fromJson(json);
  }

  Chat.copy(Chat from)
      : this(
            id: from.id,
            creatorId: from.creatorId,
            receiverId: from.receiverId,
            message: from.message,
            createdAt: from.createdAt);

  factory Chat.fromRawJson(String str) => Chat.fromJson(jsonDecode(str));

  Chat.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id'],
            creatorId: json['creatorId'],
            receiverId: json['receiverId'],
            message: json['message'],
            createdAt: json['createdAt']);

  String toRawJson() => jsonEncode(toJson());

  Map<String, dynamic> toJson() => {
        'creatorId': creatorId,
        'receiverId': receiverId,
        'message': message,
        'createdAt': createdAt
      };
}
