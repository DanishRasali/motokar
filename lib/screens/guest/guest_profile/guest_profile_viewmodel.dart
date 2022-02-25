import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:motokar/app/locator.dart';
import 'package:motokar/screens/guest/guest_profile/guest_updateProfile_view.dart';
import 'package:motokar/screens/signin/signin_view.dart';
import 'package:motokar/screens/viewmodel.dart';
import 'package:motokar/services/authentication_service.dart';
import 'package:motokar/services/profile_service.dart';
import 'package:motokar/services/cloud_storage_service.dart';

class GuestProfileViewModel extends ViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final ProfileService _profileService = locator<ProfileService>();
  final CloudStorageService cloudStorageService =
      locator<CloudStorageService>();

  void updateProfile({
    @required String displayName,
    @required String phoneNumber,
    File imageFile,
  }) async {
    setBusy(true);

    if (imageFile == null) {
      print('is here 1');
      await _profileService.updateProfile(
          id: currentProfile.id,
          displayName: displayName,
          phoneNumber: phoneNumber);

      currentProfile.displayName = displayName;
      currentProfile.phoneNumber = phoneNumber;
    } else {
      print('is here 2');
      await cloudStorageService
          .updateProfile(
            imageToUpload: imageFile,
            title: displayName,
            displayName: displayName,
            phoneNumber: phoneNumber,
          )
          .whenComplete(() {});
    }

    setBusy(false);
  }

  void navigateToUpdateProfile(context, profile) {
    Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
        builder: (context) => GuestUpdateProfileView(profile: profile)));
  }

  void signOut(context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => SignInView()),
        (route) => false);
  }
}
