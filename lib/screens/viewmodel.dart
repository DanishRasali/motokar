import 'package:stacked/stacked.dart';
import 'package:motokar/app/locator.dart';
import 'package:motokar/models/profile.dart';
import 'package:motokar/services/authentication_service.dart';

class ViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  Profile get currentProfile => _authenticationService.currentProfile;
}