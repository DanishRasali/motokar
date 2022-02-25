import 'package:motokar/app/locator.dart';
import 'package:motokar/models/profile.dart';
import 'package:motokar/models/rating.dart';
import 'package:motokar/models/trip.dart';
import 'package:motokar/models/vehicle.dart';
import 'package:motokar/screens/viewmodel.dart';
import 'package:motokar/services/authentication_service.dart';
import 'package:motokar/services/profile_service.dart';
import 'package:motokar/services/rating_service.dart';
import 'package:motokar/services/trip_service.dart';
import 'package:motokar/services/vehicle_service.dart';

class GuestTripsViewModel extends ViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  final TripService _tripService = locator<TripService>();
  final VehicleService _vehicleService = locator<VehicleService>();
  final ProfileService _profileService = locator<ProfileService>();
  final RatingService _ratingService = locator<RatingService>();

  bool empty = false;

  List<Trip> _tripList;
  get tripList => _tripList;

  List<Vehicle> _vehicleList;
  get vehicleList => _vehicleList;

  List<Profile> _profileList;
  get profileList => _profileList;

  List<Rating> _ratingList;
  get ratingList => _ratingList;

  Future initialise() async {
    setBusy(true);

    _tripList = await _tripService.getTripsByProfileId(currentProfile.id);
    _vehicleList = await _vehicleService.getVehicles();
    _profileList = await _profileService.getProfiles();
    _ratingList = await _ratingService.getRatings();

    if (_tripList.length == 0) empty = true;

    setBusy(false);
  }

  void createTrip(
      {startDate, endDate, totalPrice, vehicleId, profileId, context}) async {
    setBusy(true);

    Trip trip = Trip(
        startDate: startDate,
        endDate: endDate,
        totalPrice: totalPrice,
        vehicleId: vehicleId,
        profileId: profileId);

    await _tripService.createTrip(trip);

    setBusy(false);
  }

  Vehicle getVehicle(String vehicleId) =>
      vehicleList.firstWhere((vehicle) => vehicle.id == vehicleId);

  Profile getVehicleProfile(String profileId) =>
      profileList.firstWhere((profile) => profile.id == profileId);

  double getVehicleRating(String vehicleId) {
    double totalRating = 0.0;
    double countRating = 0;

    for (Rating rating in ratingList) {
      if (rating.vehicleId == vehicleId) {
        countRating++;
        totalRating += rating.rate;
      }
    }

    if (countRating != 0) {
      totalRating = totalRating / countRating;
    }

    return totalRating;
  }

  void createRating(
      {profileId, rate, vehicleId}) async {
    setBusy(true);

    Rating rating = Rating(
        profileId: profileId,
        rate: rate,
        vehicleId: vehicleId);

    await _ratingService.createRating(rating);

    setBusy(false);
  }
}
