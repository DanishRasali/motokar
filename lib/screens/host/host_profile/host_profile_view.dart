import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:motokar/screens/shared/colors.dart';
import 'package:motokar/screens/signin/signin_view.dart';
import 'package:motokar/services/authentication_service.dart';
import 'package:motokar/services/profile_service.dart';
import 'package:stacked/stacked.dart';
import 'package:provider/provider.dart';
import '../../shared/my_toast.dart';
import 'package:motokar/screens/shared/buttons.dart';

import 'host_profile_viewmodel.dart';

class HostProfileView extends StatefulWidget {
  HostProfileView();

  @override
  _HostProfileViewState createState() => _HostProfileViewState();
}

class _HostProfileViewState extends State<HostProfileView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return ViewModelBuilder<HostProfileViewModel>.reactive(
        disposeViewModel: false,
        viewModelBuilder: () => HostProfileViewModel(),
        builder: (context, model, child) => Scaffold(
              body: ListView(
                children: [
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    width: 150,
                    height: 150,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: 
                              (model.currentProfile.profilePicture == null || model.currentProfile.profilePicture == '')
                              ?
                              CircleAvatar(
                                radius: 50.0,
                                backgroundImage: AssetImage('assets/images/profile.png'),
                                backgroundColor: Colors.transparent,
                              )
                              :
                              CircleAvatar(
                                radius: 50.0,
                                backgroundImage: NetworkImage(model.currentProfile.profilePicture),
                                backgroundColor: Colors.transparent,
                              )
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    model.currentProfile.displayName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 30.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    model.currentProfile.email,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 15.0,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Padding(
                        padding: const EdgeInsets.all(25),
                        child: transparentButton("Edit Profile", () async {
                          model.navigateToUpdateProfile(context, model.currentProfile);
                        }, Color.fromRGBO(253, 121, 168, 1),
                            Color.fromRGBO(253, 121, 168, 1), screenWidth - 30,
                            textColor: Colors.white),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'ACCOUNT SETTINGS',
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey.shade500,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      model.navigateToUpdateProfile(
                                          context, model.currentProfile);
                                    },
                                    child: Text(
                                      'Personal Information',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40.0,
                                    child: Divider(
                                      color: accentColor,
                                    ),
                                  ),
                                  Text(
                                    'Payments and payouts',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40.0,
                                    child: Divider(
                                      color: accentColor,
                                    ),
                                  ),
                                  Text(
                                    'Notifications',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40.0,
                                    child: Divider(
                                      color: accentColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'PROMOTIONS',
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey.shade500,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Text(
                                    'Refer a renter',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40.0,
                                    child: Divider(
                                      color: accentColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'SUPPORT',
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey.shade500,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Text(
                                    'Safety Center',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40.0,
                                    child: Divider(
                                      color: accentColor,
                                    ),
                                  ),
                                  Text(
                                    'Get Help',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40.0,
                                    child: Divider(
                                      color: accentColor,
                                    ),
                                  ),
                                  Text(
                                    'Give us feedback',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40.0,
                                    child: Divider(
                                      color: accentColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'LEGAL',
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey.shade500,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Text(
                                    'Terms of service',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40.0,
                                    child: Divider(
                                      color: accentColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(9),
                          child: transparentButton("Sign Out", () async {
                            try {
                              model.signOut(context);
                              myToast('Signed Out');
                              return await _auth.signOut();
                            } catch (e) {
                              print(e.toString());
                            }
                          }, Colors.red,
                              Colors.red, screenWidth - 30,
                              textColor: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
  }
}
