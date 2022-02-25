import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;
import 'package:flutter/cupertino.dart';
import 'package:motokar/models/cloud_storage_result.dart';
import 'package:motokar/services/profile_service.dart';

import 'package:motokar/screens/viewmodel.dart';
import 'package:motokar/app/locator.dart';

class CloudStorageService extends ViewModel {
  final ProfileService _profileService = locator<ProfileService>();
  static final CloudStorageService _instance =
      CloudStorageService._constructor();

  factory CloudStorageService() {
    return _instance;
  }

  CloudStorageService._constructor();

  Future<CloudStorageResult> updateProfile({
    @required File imageToUpload,
    @required String title,
    String displayName,
    String phoneNumber,
  }) async {
    var imageFileName =
        title + DateTime.now().millisecondsSinceEpoch.toString();

    final firebase_storage.Reference firebaseStorageRef = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('profilePictures/${Path.basename(imageFileName)}');

    firebase_storage.UploadTask task =
        firebaseStorageRef.putFile(imageToUpload);

    String url;
    task.whenComplete(() async {
      print('file uploaded!');
      await firebaseStorageRef.getDownloadURL().then((value) {
        url = value;
      }).whenComplete(() async {
        print('URL DPAT NI');
        print(url);

        await _profileService.updateProfile(
          id: currentProfile.id,
          displayName: displayName,
          phoneNumber: phoneNumber,
          profilePicture: url,
        );

        currentProfile.displayName = displayName;
        currentProfile.phoneNumber = phoneNumber;
        currentProfile.profilePicture = url;

        return CloudStorageResult(
          imageUrl: url,
          imageFileName: imageFileName,
        );
      });
    });

    return null;
  }

  Future deleteImage(String imageFileName) async {
    final firebase_storage.Reference firebaseStorageRef =
        firebase_storage.FirebaseStorage.instance.ref().child(imageFileName);

    try {
      await firebaseStorageRef.delete();
    } catch (e) {
      return e.toString();
    }
  }
}

final profileCloudStorageService = CloudStorageService();
