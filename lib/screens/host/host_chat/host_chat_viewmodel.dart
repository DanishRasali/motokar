import 'package:motokar/app/locator.dart';
import 'package:motokar/models/chat.dart';
import 'package:motokar/models/profile.dart';
import 'package:motokar/screens/viewmodel.dart';
import 'package:motokar/services/chat_service.dart';
import 'package:motokar/services/profile_service.dart';

class HostChatViewModel extends ViewModel {
  final ProfileService _profileService = locator<ProfileService>();
  final ChatService _chatService = locator<ChatService>();

  bool empty = false;

  List<Profile> _profileList;
  get profileList => _profileList;

  Future initialise() async {
    setBusy(true);

    _profileList = await _profileService.getProfilesByOtherProfileId(currentProfile.id);

    if (_profileList.length == 0) empty = true;

    setBusy(false);
  }

  Future createChat({creatorId, receiverId, message, createdAt}) async {
    setBusy(true);

    Chat chat = Chat(
        creatorId: creatorId,
        receiverId: receiverId,
        message: message,
        createdAt: createdAt);

    await _chatService.createChat(chat);

    setBusy(false);
  }

  Profile getVehicleProfile(String profileId) =>
      profileList.firstWhere((profile) => profile.id == profileId);
}
