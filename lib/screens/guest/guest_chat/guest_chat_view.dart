import 'package:flutter/material.dart';
import 'package:motokar/screens/guest/guest_chat/guest_chat_widget.dart';
import 'package:motokar/screens/shared/colors.dart';
import 'package:stacked/stacked.dart';
import '../../shared/my_toast.dart';
import 'package:motokar/screens/shared/appBar.dart';

import '../guest_chat/guest_chat_viewmodel.dart';

class GuestChatView extends StatefulWidget {
  GuestChatView();

  @override
  _GuestChatViewState createState() => _GuestChatViewState();
}

class _GuestChatViewState extends State<GuestChatView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GuestChatViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => GuestChatViewModel(),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) => Scaffold(
        appBar: buildSectionBar(context, 'Chats'),
        body: model.isBusy
        ? Center(child: CircularProgressIndicator())
        : model.empty
            ? Column(
                children: [
                  Expanded(child: Center(child: Text('No Profiles'))),
                ],
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: model.profileList == null
                      ? 1
                      : model.profileList.length,
                      itemBuilder: (context, index) {
                        final profile = model.profileList[index];
                        return GuestChatWidget(
                          profile: profile
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
