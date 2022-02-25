import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:motokar/app/locator.dart';
import 'package:motokar/screens/guest/guest_main/guest_main_screen.dart';
import 'package:motokar/screens/host/host_main/host_main_screen.dart';
import 'package:motokar/screens/signup/signup_view.dart';
import 'package:motokar/screens/viewmodel.dart';
import 'package:motokar/services/authentication_service.dart';
import 'package:motokar/screens/shared/toastAndDialog.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInViewModel extends ViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  Future signIn({
    @required String email,
    @required String password,
    @required context,
  }) async {
    setBusy(true);

    var result = await _authenticationService.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    setBusy(false);

    if (result is String) {
      awesomeSingleDialog(context, 'Sign-In Error', result,
          () => Navigator.of(context, rootNavigator: true).pop());
    } else {
      if (result) {
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
            'Sign-In Error',
            'General sign-in failure. Please try again later',
            () => Navigator.of(context, rootNavigator: true).pop());
      }
    }
  }

  void navigateToSignUp(context) {
    Navigator.of(context, rootNavigator: true)
        .pushReplacement(MaterialPageRoute(builder: (context) => SignUpView()));
  }
}
