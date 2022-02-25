import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motokar/models/profile.dart';

import 'colors.dart';

awesomeTopProfile(BuildContext context, double screenWidth, Profile profile) {
  return InkWell(
    child: Container(
      padding: EdgeInsets.only(top: 5, bottom: 5, left: 15),
      height: 75,
      width: screenWidth,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Container(
                height: 45,
                width: 45,
                color: Colors.grey,
                child: profile.profilePicture == null ||
                        profile.profilePicture == ''
                    ? Icon(
                        Icons.person,
                        color: black,
                      )
                    : CachedNetworkImage(
                        imageUrl: profile.profilePicture,
                        fit: BoxFit.fill,
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
              ),
            ),
          ),
          SizedBox(width: 12.5),
          Center(
            child: FittedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(profile.displayName,
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                  SizedBox(height: 5),
                  Text(
                    profile.phoneNumber + ' / ' + profile.email,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
