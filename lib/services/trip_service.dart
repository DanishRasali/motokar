import 'package:motokar/models/trip.dart';
import 'package:motokar/models/vehicle.dart';

import 'rest.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TripService {
  static final TripService _instance = TripService._constructor();
  factory TripService() {
    return _instance;
  }

  TripService._constructor();

  final CollectionReference _tripsRef =
      FirebaseFirestore.instance.collection('trips');

  Future<Trip> getTrip({String id}) async {
    final json = await Rest.get('trips/$id');
    return Trip.fromJson(json);
  }

  Future<List<Trip>> getTrips() async {
    final jsonList = await Rest.get('trips');
    final tripList = <Trip>[];

    if (jsonList != null) {
      for (int i = 0; i < jsonList.length; i++) {
        final json = jsonList[i];
        Trip trip = Trip.fromJson(json);
        tripList.add(trip);
      }
    }

    return tripList;
  }

  Future<List<Trip>> getTripsByProfileId(String profileId) async {
    QuerySnapshot snapshots = await _tripsRef
        // .where('profileId', isEqualTo: profileId)
        .orderBy("startDate", descending: true)
        .get();

    List<Trip> tripList =
        snapshots.docs.map((snapshot) => Trip.fromSnapshot(snapshot)).toList();
    List<Trip> returnTripList = [];

    for (Trip trip in tripList) {
      if (trip.profileId == profileId) {
        returnTripList.add(trip);
      }
    }

    // return snapshots.docs
    //     .map((snapshot) => Trip.fromSnapshot(snapshot))
    //     .toList();

    return returnTripList;
  }

  Future<List<Trip>> getTripsByVehicleIds(List<String> vehicleIds) async {
    QuerySnapshot snapshots = await _tripsRef
        // .where('vehicleId', whereIn: vehicleIds)
        .orderBy("startDate", descending: true)
        .get();

    List<Trip> tripList =
        snapshots.docs.map((snapshot) => Trip.fromSnapshot(snapshot)).toList();
    List<Trip> returnTripList = [];

    for (Trip trip in tripList) {
      if (vehicleIds.contains(trip.vehicleId)) {
        returnTripList.add(trip);
      }
    }

    // return snapshots.docs
    //     .map((snapshot) => Trip.fromSnapshot(snapshot))
    //     .toList();

    return returnTripList;
  }

  Future createTrip(Trip trip) async {
    await Rest.post(
      'trips/',
      data: {
        'startDate': trip.startDate,
        'endDate': trip.endDate,
        'totalPrice': trip.totalPrice,
        'vehicleId': trip.vehicleId,
        'profileId': trip.profileId,
      },
    );
  }
}
