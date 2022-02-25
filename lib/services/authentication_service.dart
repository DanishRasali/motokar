import 'rest.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/foundation.dart';

import '../app/locator.dart';
import '../models/profile.dart';
import '../services/profile_service.dart';

class AuthenticationService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  final ProfileService _profileService = locator<ProfileService>();

  var _currentProfile;
  get currentProfile => _currentProfile;

  Future signInAnonymously() async {
    try {
      auth.UserCredential userCredential =
          await _firebaseAuth.signInAnonymously();
      auth.User profile = userCredential.user;
      return profile != null;
    } catch (e) {
      return e.message;
    }
  }

  Future signInWithEmailAndPassword(
      {@required String email, @required String password}) async {
    try {
      auth.UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      auth.User profile = userCredential.user;
      await _populateCurrentProfile(profile);

      return profile != null;
    } catch (e) {
      return e.message;
    }
  }

  Future registerWithEmailAndPassword({
    @required String displayName,
    @required String email,
    @required String password,
    @required String phoneNumber,
    @required String type,
  }) async {
    try {
      auth.UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      auth.User profile = userCredential.user;

      _currentProfile = Profile.createNew(
        id: profile.uid,
        displayName: displayName,
        email: email,
        phoneNumber: phoneNumber,
        type: type,
      );

      await _profileService.createProfile(_currentProfile);
      return profile != null;
    } catch (e) {
      return e.message;
    }
  }

  Future signOut() async {
    try {
      await _firebaseAuth.signOut();
      return _populateCurrentProfile(null);
    } catch (e) {
      return e.message;
    }
  }

  Future<bool> isUserSignedIn() async {
    auth.User profile = _firebaseAuth.currentUser;
    await _populateCurrentProfile(profile);
    return profile != null;
  }

  Future<void> _populateCurrentProfile(auth.User profile) async {
    if (profile != null) {
      _currentProfile = await _profileService.getProfile(id: profile.uid);
    } else
      _currentProfile = null;
  }

  Future<bool> validatePassword(String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: currentProfile.email, password: password);
      return true;
    } catch (e) {
      print(e.message);
      return false;
    }
  }

  Future<void> updatePassword(String password) async {
    var firebaseUser = _firebaseAuth.currentUser;
    firebaseUser.updatePassword(password);
  }
}
