import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:motokar/app/locator.dart';
import 'package:motokar/screens/guest/guest_main/guest_main_screen.dart';
import 'package:motokar/screens/host/host_main/host_main_screen.dart';
import 'package:motokar/screens/signin/signin_view.dart';
import 'package:motokar/screens/viewmodel.dart';
import 'package:motokar/services/authentication_service.dart';
import 'package:motokar/screens/shared/toastAndDialog.dart';

class SignUpViewModel extends ViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  Future signUp({
    @required String displayName,
    @required String email,
    @required String password,
    @required String phoneNumber,
    @required String type,
    @required context,
  }) async {
    setBusy(true);

    var result = await _authenticationService.registerWithEmailAndPassword(
      displayName: displayName,
      email: email,
      password: password,
      phoneNumber: phoneNumber,
      type: type,
    );

    setBusy(false);

    if (result is String) {
      awesomeSingleDialog(context, 'Sign-Up Error', result,
          () => Navigator.of(context, rootNavigator: true).pop());
    } else {
      if (result != null) {
          if (currentProfile.type.toString().toLowerCase() == 'host') {
          await Future.delayed(Duration(seconds: 1));
          await Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HostMainScreen(tab: 0)));
        } else {
          await Future.delayed(Duration(seconds: 1));
          await Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => GuestMainScreen(tab: 0)));
        }
      } else {
        awesomeSingleDialog(
            context,
            'Sign-Up Error',
            'General sign-up failure. Please try again later',
            () => Navigator.of(context, rootNavigator: true).pop());
      }
    }
  }

  void navigateToSignIn(context) {
    Navigator.of(context, rootNavigator: true).pushReplacement(
              MaterialPageRoute(builder: (context) => SignInView()));
  }
}