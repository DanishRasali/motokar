import 'package:flutter/material.dart';
import 'package:motokar/screens/host/host_chat/host_chat_view.dart';
import 'package:motokar/screens/host/host_post/host_addPost_view.dart';
import 'package:motokar/screens/host/host_post/host_post_widget.dart';
import 'package:motokar/services/authentication_service.dart';
import 'package:motokar/services/profile_service.dart';
import 'package:stacked/stacked.dart';
import 'package:provider/provider.dart';
import '../../shared/my_toast.dart';
import 'package:motokar/screens/shared/appBar.dart';
import 'package:motokar/screens/shared/colors.dart';

import 'host_post_viewmodel.dart';

class HostPostView extends StatefulWidget {
  HostPostView();

  @override
  _HostPostViewState createState() => _HostPostViewState();
}

class _HostPostViewState extends State<HostPostView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HostPostViewModel>.reactive(
        disposeViewModel: false,
        viewModelBuilder: () => HostPostViewModel(),
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
                              builder: (context) => HostChatView()
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
                                  return HostPostWidget(
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
                      MaterialPageRoute(builder: (context) => HostAddPostView()));
                },
              ),
            ));
  }
}
