import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:motokar/models/chat.dart';
import 'package:motokar/models/profile.dart';
import 'package:motokar/screens/shared/round_input.dart';
import 'package:stacked/stacked.dart';
import 'package:provider/provider.dart';
import 'package:motokar/screens/shared/appBar.dart';
import 'package:motokar/screens/shared/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:motokar/screens/shared/styles.dart';

import 'guest_chat_viewmodel.dart';

class ChattingView extends StatefulWidget {
  ChattingView({this.profile});

  final Profile profile;

  @override
  _ChattingViewState createState() => _ChattingViewState();
}

class _ChattingViewState extends State<ChattingView> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GuestChatViewModel>.reactive(
        disposeViewModel: false,
        viewModelBuilder: () => GuestChatViewModel(),
        onModelReady: (model) => model.initialise(),
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: InkWell(
                    child: Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                          height: 45,
                          width: 45,
                          color: Colors.grey,
                          child: widget.profile.profilePicture == null ||
                                  widget.profile.profilePicture == ''
                              ? Icon(
                                  Icons.person,
                                  color: black,
                                )
                              : CachedNetworkImage(
                                  imageUrl: widget.profile.profilePicture,
                                  fit: BoxFit.fill,
                                  placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
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
                            Text(widget.profile.displayName,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 18)),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
              ),
              body: model.isBusy
                  ? Center(child: CircularProgressIndicator())
                  : Center(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: _buildMessageDisplay(model),
                            // child: Container(),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: RoundInput(
                                      textController: _textController,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      var now = new DateTime.now();
                                      var formatter =
                                          new DateFormat('dd/MM/yyyy hh:mma');
                                      String createdAt = formatter.format(now);

                                      model.createChat(
                                          creatorId: model.currentProfile.id,
                                          receiverId: widget.profile.id,
                                          message: _textController.text,
                                          createdAt: createdAt);

                                      _textController.text = "";
                                    },
                                    child: CircleAvatar(
                                      child: Icon(Icons.send),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
            ));
  }

  Widget _buildMessageDisplay(model) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("chats").where(
            'creatorId',
            whereIn: [model.currentProfile.id, widget.profile.id]).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting)
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (ctx, index) {
                    return (snapshot.data.docs[index]['receiverId'] ==
                                model.currentProfile.id ||
                            snapshot.data.docs[index]['receiverId'] ==
                                widget.profile.id)
                        ? Padding(
                            padding: const EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 5.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 8.0,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                    boxShadow: [
                                      //BoxShadow
                                      BoxShadow(
                                        color: (snapshot.data.docs[index]
                                                    ['creatorId'] ==
                                                model.currentProfile.id)
                                            ? accentColor
                                            : Colors.grey[600],
                                        offset: const Offset(0.0, 0.0),
                                        blurRadius: 0.0,
                                        spreadRadius: 0.0,
                                      ), //BoxShadow
                                    ],
                                    border: Border.symmetric(
                                      horizontal: BorderSide(
                                        width: 0.5,
                                      ),
                                      vertical: BorderSide(
                                        width: 0.5,
                                      ),
                                    ),
                                  ),
                                  padding: EdgeInsets.only(bottom: 10.5),
                                  child: InkWell(
                                      child: Row(
                                    children: [
                                      Expanded(
                                        child: ListTile(
                                          dense: true,
                                          title: Text(
                                            snapshot.data.docs[index]
                                                ['message'],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17.0,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          subtitle: Container(
                                            padding: EdgeInsets.only(
                                                top: 10.0, bottom: 4.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Container(
                                                    child: Text(
                                                      snapshot.data.docs[index]
                                                          ['createdAt'],
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12.0,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                                ),
                              ],
                            ),
                          )
                        : Container();
                  },
                );
        });
  }
}
