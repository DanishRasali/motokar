import 'rest.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/profile.dart';

class ProfileService {
  static final ProfileService _instance = ProfileService._constructor();
  factory ProfileService() {
    return _instance;
  }

  ProfileService._constructor();

  final CollectionReference _profilesRef =
      FirebaseFirestore.instance.collection('profiles');

  Future<Profile> getProfile({String id}) async {
    final json = await Rest.get('profiles/$id');
    return Profile.fromJson(json);
  }

  Future<List<Profile>> getProfiles() async {
    final jsonList = await Rest.get('profiles');
    final profileList = <Profile>[];

    if (jsonList != null) {
      for (int i = 0; i < jsonList.length; i++) {
        final json = jsonList[i];
        Profile profile = Profile.fromJson(json);
        profileList.add(profile);
      }
    }

    return profileList;
  }

  Future<List<Profile>> getProfilesByOtherProfileId(String profileId) async {
    QuerySnapshot snapshots =
        await _profilesRef.where('id', isNotEqualTo: profileId).get();
    return snapshots.docs
        .map((snapshot) => Profile.fromSnapshot(snapshot))
        .toList();
  }

  Future createProfile(Profile profile) async {
    await Rest.post(
      'profiles/',
      data: {
        'id': profile.id,
        'displayName': profile.displayName,
        'email': profile.email,
        'phoneNumber': profile.phoneNumber,
        'type': profile.type,
      },
    );
  }

  Future<Profile> updateProfile(
      {String id,
      String displayName,
      String phoneNumber,
      String profilePicture}) async {
    if (profilePicture != null) {
      final json = await Rest.patch('profiles/$id', data: {
        'displayName': displayName,
        'phoneNumber': phoneNumber,
        'profilePicture': profilePicture
      });

      return Profile.fromJson(json);
    } else {
      final json = await Rest.patch('profiles/$id',
          data: {'displayName': displayName, 'phoneNumber': phoneNumber});

      return Profile.fromJson(json);
    }
  }

  Future deleteProfile(String id) async {
    await _profilesRef.doc(id).delete();
  }
}
