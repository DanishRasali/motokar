import 'package:flutter/material.dart';
import 'package:motokar/screens/guest/guest_chat/guest_chat_view.dart';
import 'package:motokar/screens/guest/guest_post/guest_addPost_view.dart';
import 'package:motokar/screens/guest/guest_post/guest_post_widget.dart';
import 'package:motokar/services/authentication_service.dart';
import 'package:motokar/services/profile_service.dart';
import 'package:stacked/stacked.dart';
import 'package:provider/provider.dart';
import '../../shared/my_toast.dart';
import 'package:motokar/screens/shared/appBar.dart';
import 'package:motokar/screens/shared/colors.dart';

import 'guest_post_viewmodel.dart';

class GuestPostView extends StatefulWidget {
  GuestPostView();

  @override
  _GuestPostViewState createState() => _GuestPostViewState();
}

class _GuestPostViewState extends State<GuestPostView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GuestPostViewModel>.reactive(
        disposeViewModel: false,
        viewModelBuilder: () => GuestPostViewModel(),
        onModelReady: (model) => model.initialise(),
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('assets/images/zen.png', fit: BoxFit.cover, height: 48),
                    InkWell(
                      child:Icon(Icons.chat_outlined, size: 40, color: accentColor),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GuestChatView()
                          )
                        );
                      },
                    ),
                  ],
                ),
              ),
              body: model.isBusy
                  ? Center(child: CircularProgressIndicator())
                  : model.empty
                      ? Column(
                          children: [
                            Expanded(child: Center(child: Text('No Posts'))),
                          ],
                        )
                      : Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: model.postList == null
                                    ? 1
                                    : model.postList.length,
                                itemBuilder: (context, index) {
                                  final post = model.postList[index];
                                  return GuestPostWidget(
                                      post: post,
                                      postProfile:
                                          model.getPostProfile(post.createdBy),
                                      profileId: model.currentProfile.id);
                                },
                              ),
                            ),
                          ],
                        ),
                        floatingActionButton: FloatingActionButton(
                          child: Icon(Icons.add, color: Colors.white),
                          backgroundColor: accentColor,
                          onPressed: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => GuestAddPostView()));
                          },
                        ),
            ));
  }
}
