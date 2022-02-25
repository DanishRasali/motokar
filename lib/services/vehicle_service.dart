import 'package:flutter/widgets.dart';
import 'package:motokar/models/vehicle.dart';

import 'rest.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VehicleService {
  static final VehicleService _instance = VehicleService._constructor();
  factory VehicleService() {
    return _instance;
  }

  VehicleService._constructor();

  final CollectionReference _vehiclesRef =
      FirebaseFirestore.instance.collection('vehicles');

  Future<Vehicle> getVehicle({String id}) async {
    final json = await Rest.get('vehicles/$id');
    return Vehicle.fromJson(json);
  }

  Future<List<Vehicle>> getVehicles() async {
    final jsonList = await Rest.get('vehicles');
    final vehicleList = <Vehicle>[];

    if (jsonList != null) {
      for (int i = 0; i < jsonList.length; i++) {
        final json = jsonList[i];
        Vehicle vehicle = Vehicle.fromJson(json);
        vehicleList.add(vehicle);
      }
    }

    return vehicleList;
  }

  Future<List<Vehicle>> getVehiclesByProfileId(String profileId) async {
    QuerySnapshot snapshots =
        await _vehiclesRef.where('profileId', isEqualTo: profileId).get();
    return snapshots.docs
        .map((snapshot) => Vehicle.fromSnapshot(snapshot))
        .toList();
  }

  Future<List<Vehicle>> getVehiclesByOtherProfileId(String profileId) async {
    QuerySnapshot snapshots =
        await _vehiclesRef.where('profileId', isNotEqualTo: profileId).get();
    return snapshots.docs
        .map((snapshot) => Vehicle.fromSnapshot(snapshot))
        .toList();
  }

  Future createVehicle(Vehicle vehicle) async {
    if (vehicle.vehiclePicture != null && vehicle.vehiclePicture != '') {
      await Rest.post(
        'vehicles/',
        data: {
          'name': vehicle.name,
          'description': vehicle.description,
          'price': vehicle.price,
          'vehiclePicture': vehicle.vehiclePicture,
          'profileId': vehicle.profileId,
          'type': vehicle.type,
          'occupant': vehicle.occupant,
          'room': vehicle.room,
          'bed': vehicle.bed,
        },
      );
    } else {
      await Rest.post(
        'vehicles/',
        data: {
          'name': vehicle.name,
          'description': vehicle.description,
          'price': vehicle.price,
          'vehiclePicture': '',
          'profileId': vehicle.profileId,
          'type': vehicle.type,
          'occupant': vehicle.occupant,
          'room': vehicle.room,
          'bed': vehicle.bed,
        },
      );
    }
  }

  Future<Vehicle> updateVehicle(
      {String id,
      String name,
      String description,
      double price,
      String vehiclePicture,
      String type,
      String occupant,
      String room,
      String bed,}) async {
    if (vehiclePicture != null && vehiclePicture != '') {
      final json = await Rest.patch('vehicles/$id', data: {
        'name': name,
        'description': description,
        'price': price,
        'vehiclePicture': vehiclePicture,
        'type': type,
        'occupant': occupant,
        'room': room,
        'bed': bed,
      });

      return Vehicle.fromJson(json);
    } else {
      final json = await Rest.patch('vehicles/$id',
          data: {
            'name': name, 
            'description': description, 
            'price': price,
            'type': type,
            'occupant': occupant,
            'room': room,
            'bed': bed,
          });

      return Vehicle.fromJson(json);
    }
  }

  Future deleteVehicle(String id) async {
    await _vehiclesRef.doc(id).delete();
  }
}
