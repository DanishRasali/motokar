import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:motokar/models/post.dart';
import 'package:motokar/models/vehicle.dart';
import 'package:motokar/models/profile.dart';
import 'package:motokar/screens/host/host_explore/host_bookVehicle_view.dart';
import 'package:motokar/screens/host/host_post/host_updatePost_view.dart';
import 'package:motokar/screens/shared/colors.dart';
import 'package:motokar/screens/shared/topProfile.dart';

class HostPostWidget extends StatelessWidget {
  final Post post;
  final Profile postProfile;
  final String profileId;

  HostPostWidget({this.post, this.postProfile, this.profileId});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Material(
      child: Container(
        color: Color.fromRGBO(66, 73, 75, 1),
        margin: EdgeInsets.only(bottom: 10),
        child: InkWell(
            onTap: () {
              if (profileId == postProfile.id) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HostUpdatePostView(post: post)));
              }
            },
            child: Column(
              children: [
                awesomeTopProfile(context, screenWidth, postProfile),
                ListTile(
                    dense: true,
                    title: Expanded(
                        child: Row(
                      children: [
                        Text(
                          post.content,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 15),
                        ),
                      ],
                    ))),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: (post.postPicture != null && post.postPicture != '')
                      ? Image.network(post.postPicture)
                      : Image.asset('assets/images/myhouse.jpg'),
                ),
              ],
            )),
      ),
    );
  }
}
