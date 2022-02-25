import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:motokar/api/firebase_api.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:motokar/app/locator.dart';
import 'package:motokar/models/post.dart';
import 'package:motokar/models/profile.dart';
import 'package:motokar/screens/host/host_profile/host_updateProfile_view.dart';
import 'package:motokar/screens/signin/signin_view.dart';
import 'package:motokar/screens/viewmodel.dart';
import 'package:motokar/services/authentication_service.dart';
import 'package:motokar/services/post_services.dart';
import 'package:motokar/services/profile_service.dart';
import 'package:motokar/services/cloud_storage_service.dart';

class HostProfileViewModel extends ViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final ProfileService _profileService = locator<ProfileService>();
  final CloudStorageService cloudStorageService =
      locator<CloudStorageService>();
  final PostService _postService = locator<PostService>();

  bool empty = false;

  List<Post> _postList;
  get postList => _postList;

  List<Profile> _profileList;
  get profileList => _profileList;

  Future initialise() async {
    setBusy(true);

    _postList = await _postService.getPosts();

    _profileList = await _profileService.getProfiles();

    if (_postList.length == 0) empty = true;

    setBusy(false);
  }

  Profile getPostProfile(String profileId) =>
      profileList.firstWhere((profile) => profile.id == profileId);

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
        builder: (context) => HostUpdateProfileView(profile: profile)));
  }

  void signOut(context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => SignInView()),
        (route) => false);
  }

  void updatePost(
      {id,
      content,
      postPicture,
      }) async {
    setBusy(true);

    if (postPicture == null || postPicture == '') {
      await _postService.updatePost(
        id: id,
        content: content,
        postPicture: postPicture,
        createdAt: ''
      );
    } else {
      final fileName = basename(postPicture.path);
      final destination = 'files/$fileName';

      UploadTask task = FirebaseApi.uploadFile(destination, postPicture);

      String fileUrl = '';

      if (task != null) {
        final snapshot = await task.whenComplete(() => {});
        fileUrl = await snapshot.ref.getDownloadURL();
      }

      await _postService.updatePost(
        id: id,
        content: content,
        postPicture: fileUrl,
        createdAt: ''
      );
    }

    setBusy(false);
  }
}
