import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

AppBar buildAppBar(BuildContext context, String title) {
  return AppBar(
    centerTitle: true,
    title: Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
  );
}

AppBar buildSectionBar(BuildContext context, String title,
    {double elevation, Color bgColor}) {
  return AppBar(
    centerTitle: true,
    elevation: elevation,
    backgroundColor: Color.fromRGBO(253, 121, 168, 1),
    title: Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
    leading: Row(
      children: <Widget>[
        SizedBox(width: 2.0),
        Container(
          height: 37,
          width: 37,
          child: IconButton(
            icon: Icon(
              CupertinoIcons.chevron_left,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ],
    ),
  );
}
