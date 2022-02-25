import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:motokar/models/profile.dart';
import 'package:motokar/screens/guest/guest_chat/chatting_view.dart';
import 'package:motokar/screens/shared/colors.dart';
import 'package:motokar/screens/shared/topProfile.dart';

class GuestChatWidget extends StatelessWidget {
  final Profile profile;

  GuestChatWidget({this.profile});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Material(
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(66, 73, 75, 1),
          border: Border.symmetric(
            horizontal: BorderSide(
              width: 0.5,
              color: dividerColor,
            ),
          ),
        ),
        // margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(5),
        child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChattingView(profile: profile)
                  )
              );
            },
            child: Column(
              children: [
                Container(
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
                              height: 55,
                              width: 55,
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
                                        TextStyle(fontWeight: FontWeight.w400, fontSize: 20)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                ),
              ],
            )),
      ),
    );
  }
}
