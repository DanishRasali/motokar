import 'package:firebase_storage/firebase_storage.dart';
import 'package:motokar/api/firebase_api.dart';
import 'package:path/path.dart';
import 'package:motokar/app/locator.dart';
import 'package:motokar/models/vehicle.dart';
import 'package:motokar/screens/viewmodel.dart';
import 'package:motokar/services/authentication_service.dart';
import 'package:motokar/services/vehicle_service.dart';

class HostGarageViewModel extends ViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  final VehicleService _vehicleService = locator<VehicleService>();

  bool empty = false;

  List<Vehicle> _vehicleList;
  get vehicleList => _vehicleList;

  Future initialise() async {
    setBusy(true);

    _vehicleList =
        await _vehicleService.getVehiclesByProfileId(currentProfile.id);

    if (_vehicleList.length == 0) empty = true;

    setBusy(false);
  }

  void createVehicle(
      {name,
      description,
      price,
      vehiclePicture,
      profileId,
      type,
      occupant,
      room,
      bed}) async {
    setBusy(true);

    if (vehiclePicture == null || vehiclePicture == '') {
      Vehicle vehicle = Vehicle(
        name: name,
        description: description,
        price: price,
        profileId: profileId,
        type: type,
        occupant: occupant,
        room: room,
        bed: bed,
      );

      await _vehicleService.createVehicle(vehicle);
    } else {
      final fileName = basename(vehiclePicture.path);
      final destination = 'files/$fileName';

      UploadTask task = FirebaseApi.uploadFile(destination, vehiclePicture);

      String fileUrl = '';

      if (task != null) {
        final snapshot = await task.whenComplete(() => {});
        fileUrl = await snapshot.ref.getDownloadURL();
      }

      Vehicle vehicle = Vehicle(
        name: name,
        description: description,
        price: price,
        vehiclePicture: fileUrl,
        profileId: profileId,
        type: type,
        occupant: occupant,
        room: room,
        bed: bed,
      );

      await _vehicleService.createVehicle(vehicle);
    }

    setBusy(false);
  }

  void updateVehicle(
      {id,
      name,
      description,
      price,
      vehiclePicture,
      type,
      occupant,
      room,
      bed}) async {
    setBusy(true);

    if (vehiclePicture == null || vehiclePicture == '') {
      await _vehicleService.updateVehicle(
        id: id,
        name: name,
        description: description,
        price: price,
        vehiclePicture: vehiclePicture,
        type: type,
        occupant: occupant,
        room: room,
        bed: bed,
      );
    } else {
      final fileName = basename(vehiclePicture.path);
      final destination = 'files/$fileName';

      UploadTask task = FirebaseApi.uploadFile(destination, vehiclePicture);

      String fileUrl = '';

      if (task != null) {
        final snapshot = await task.whenComplete(() => {});
        fileUrl = await snapshot.ref.getDownloadURL();
      }

      await _vehicleService.updateVehicle(
        id: id,
        name: name,
        description: description,
        price: price,
        vehiclePicture: fileUrl,
        type: type,
        occupant: occupant,
        room: room,
        bed: bed,
      );
    }

    setBusy(false);
  }
}
