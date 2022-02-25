import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class Vehicle {
  String _id;
  String _name;
  String _description;
  double _price;
  String _vehiclePicture;
  String _profileId;
  String _type;
  String _occupant;
  String _room;
  String _bed;

  get id => _id;
  set id(value) => _id = value;

  get name => _name;
  set name(value) => _name = value;

  get description => _description;
  set description(value) => _description = value;

  get price => _price;
  set price(value) => _price = value;

  get vehiclePicture => _vehiclePicture;
  set vehiclePicture(value) => _vehiclePicture = value;

  get profileId => _profileId;
  set profileId(value) => _profileId = value;

  get type => _type;
  set type(value) => _type = value;

  get occupant => _occupant;
  set occupant(value) => _occupant = value;

  get room => _room;
  set room(value) => _room = value;

  get bed => _bed;
  set bed(value) => _bed = value;

  Vehicle(
      {String id,
      String name = '',
      String description = '',
      double price = 0.0,
      String vehiclePicture = '',
      String profileId = '',
      String type = '',
      String occupant = '',
      String room = '',
      String bed = '',})
      : _id = id,
        _name = name,
        _description = description,
        _price = price,
        _vehiclePicture = vehiclePicture,
        _profileId = profileId,
        _type = type,
        _occupant = occupant,
        _room = room,
        _bed = bed;

  factory Vehicle.createNew(
          {String id,
          String name,
          String description,
          double price,
          String vehiclePicture,
          String profileId,
          String type,
          String occupant,
          String room,
          String bed,}) =>
      Vehicle(
        id: id,
        name: name,
        description: description,
        price: price,
        vehiclePicture: vehiclePicture,
        profileId: profileId,
        type: type,
        occupant: occupant,
        room: room,
        bed: bed,
      );

  factory Vehicle.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> json = snapshot.data();
    json['id'] = snapshot.id;
    return Vehicle.fromJson(json);
  }

  Vehicle.copy(Vehicle from)
      : this(
            id: from.id,
            name: from.name,
            description: from.description,
            price: from.price,
            vehiclePicture: from.vehiclePicture,
            profileId: from.profileId,
            type: from.type,
            occupant: from.occupant,
            room: from.room,
            bed: from.bed,);

  factory Vehicle.fromRawJson(String str) => Vehicle.fromJson(jsonDecode(str));

  Vehicle.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id'],
            name: json['name'],
            description: json['description'],
            price: json['price'],
            vehiclePicture: json['vehiclePicture'],
            profileId: json['profileId'],
            type: json['type'],
            occupant: json['occupant'],
            room: json['room'],
            bed: json['bed'],);

  String toRawJson() => jsonEncode(toJson());

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'price': price,
        'vehiclePicture': vehiclePicture,
        'profileId': profileId,
        'type': type,
        'occupant': occupant,
        'room': room,
        'bed': bed,
      };
}
