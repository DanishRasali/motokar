import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class Rating {
  String _id;
  String _profileId;
  String _vehicleId;
  double _rate;

  get id => _id;
  set id(value) => _id = value;

  get profileId => _profileId;
  set profileId(value) => _profileId = value;

  get vehicleId => _vehicleId;
  set vehicleId(value) => _vehicleId = value;

  get rate => _rate;
  set rate(value) => _rate = value;

  Rating(
      {String id,
      String profileId = '',
      String vehicleId = '',
      double rate = 0.0})
      : _id = id,
        _profileId = profileId,
        _vehicleId = vehicleId,
        _rate = rate;

  factory Rating.createNew(
          {String id,
          String profileId,
          String vehicleId,
          double rate}) =>
      Rating(
        id: id,
        profileId: profileId,
        vehicleId: vehicleId,
        rate: rate
      );

  factory Rating.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> json = snapshot.data();
    json['id'] = snapshot.id;
    return Rating.fromJson(json);
  }

  Rating.copy(Rating from)
      : this(
            id: from.id,
            profileId: from.profileId,
            vehicleId: from.vehicleId,
            rate: from.rate);

  factory Rating.fromRawJson(String str) => Rating.fromJson(jsonDecode(str));

  Rating.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id'],
            profileId: json['profileId'],
            vehicleId: json['vehicleId'],
            rate: double.parse(json['rate'].toString()));

  String toRawJson() => jsonEncode(toJson());

  Map<String, dynamic> toJson() => {
        'profileId': profileId,
        'vehicleId': vehicleId,
        'rate': rate
      };
}
