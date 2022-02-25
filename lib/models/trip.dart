import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class Trip {
  String _id;
  String _startDate;
  String _endDate;
  double _totalPrice;
  String _vehicleId;
  String _profileId;

  get id => _id;
  set id(value) => _id = value;

  get startDate => _startDate;
  set startDate(value) => _startDate = value;

  get endDate => _endDate;
  set endDate(value) => _endDate = value;

  get totalPrice => _totalPrice;
  set totalPrice(value) => _totalPrice = value;

  get vehicleId => _vehicleId;
  set vehicleId(value) => _vehicleId = value;

  get profileId => _profileId;
  set profileId(value) => _profileId = value;

  Trip(
      {String id,
      String startDate = '',
      String endDate = '',
      double totalPrice = 0.0,
      String vehicleId = '',
      String profileId = ''})
      : _id = id,
        _startDate = startDate,
        _endDate = endDate,
        _totalPrice = totalPrice,
        _vehicleId = vehicleId,
        _profileId = profileId;

  factory Trip.createNew(
          {String id,
          String startDate,
          String endDate,
          double totalPrice,
          String vehicleId,
          String profileId}) =>
      Trip(
        id: id,
        startDate: startDate,
        endDate: endDate,
        totalPrice: totalPrice,
        vehicleId: vehicleId,
        profileId: profileId,
      );

  factory Trip.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> json = snapshot.data();
    json['id'] = snapshot.id;
    return Trip.fromJson(json);
  }

  Trip.copy(Trip from)
      : this(
            id: from.id,
            startDate: from.startDate,
            endDate: from.endDate,
            totalPrice: from.totalPrice,
            vehicleId: from.vehicleId,
            profileId: from.profileId);

  factory Trip.fromRawJson(String str) => Trip.fromJson(jsonDecode(str));

  Trip.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id'],
            startDate: json['startDate'],
            endDate: json['endDate'],
            totalPrice: json['totalPrice'],
            vehicleId: json['vehicleId'],
            profileId: json['profileId']);

  String toRawJson() => jsonEncode(toJson());

  Map<String, dynamic> toJson() => {
        'startDate': startDate,
        'endDate': endDate,
        'totalPrice': totalPrice,
        'vehicleId': vehicleId,
        'profileId': profileId
      };
}
