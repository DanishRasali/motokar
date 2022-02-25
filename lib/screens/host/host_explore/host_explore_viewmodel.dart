import 'package:motokar/app/locator.dart';
import 'package:motokar/models/profile.dart';
import 'package:motokar/models/rating.dart';
import 'package:motokar/models/vehicle.dart';
import 'package:motokar/screens/viewmodel.dart';
import 'package:motokar/services/authentication_service.dart';
import 'package:motokar/services/profile_service.dart';
import 'package:motokar/services/rating_service.dart';
import 'package:motokar/services/vehicle_service.dart';

class HostExploreViewModel extends ViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final VehicleService _vehicleService = locator<VehicleService>();
  final ProfileService _profileService = locator<ProfileService>();
  final RatingService _ratingService = locator<RatingService>();

  bool empty = false;

  List<Vehicle> _vehicleList;
  get vehicleList => _vehicleList;

  List<Profile> _profileList;
  get profileList => _profileList;

  List<Rating> _ratingList;
  get ratingList => _ratingList;

  Future initialise() async {
    setBusy(true);

    _vehicleList =
        await _vehicleService.getVehiclesByOtherProfileId(currentProfile.id);

    _profileList = await _profileService.getProfiles();
    _ratingList = await _ratingService.getRatings();

    if (_vehicleList.length == 0) empty = true;

    setBusy(false);
  }

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
}
