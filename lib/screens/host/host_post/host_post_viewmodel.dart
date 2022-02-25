import 'package:firebase_storage/firebase_storage.dart';
import 'package:motokar/api/firebase_api.dart';
import 'package:path/path.dart';
import 'package:motokar/app/locator.dart';
import 'package:motokar/models/post.dart';
import 'package:motokar/models/profile.dart';
import 'package:motokar/screens/viewmodel.dart';
import 'package:motokar/services/authentication_service.dart';
import 'package:motokar/services/post_services.dart';
import 'package:motokar/services/profile_service.dart';

class HostPostViewModel extends ViewModel {
  final AuthenticationService _authenticationService = locator<AuthenticationService>();
  final PostService _postService = locator<PostService>();
  final ProfileService _profileService = locator<ProfileService>();

  bool empty = false;

  List<Post> _postList;
  get postList => _postList;

  List<Profile> _profileList;
  get profileList => _profileList;

  Future initialise() async {
    setBusy(true);

    _postList =
        await _postService.getPosts();

    _profileList = await _profileService.getProfiles();

    if (_postList.length == 0) empty = true;

    setBusy(false);
  }

  Profile getPostProfile(String profileId) =>
      profileList.firstWhere((profile) => profile.id == profileId);

  void createPost(
      {
      content,
      createdBy,
      postPicture,
      }) async {
    setBusy(true);

    if (postPicture == null || postPicture == '') {
      Post post = Post(
        content: content,
        createdBy: createdBy,
        createdAt: ''
      );

      await _postService.createPost(post);
    } else {
      final fileName = basename(postPicture.path);
      final destination = 'files/$fileName';

      UploadTask task = FirebaseApi.uploadFile(destination, postPicture);

      String fileUrl = '';

      if (task != null) {
        final snapshot = await task.whenComplete(() => {});
        fileUrl = await snapshot.ref.getDownloadURL();
      }

      Post post = Post(
        content: content,
        postPicture: fileUrl,
        createdBy: createdBy,
        createdAt: ''
      );

      await _postService.createPost(post);
    }

    setBusy(false);
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
