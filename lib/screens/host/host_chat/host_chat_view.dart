import 'package:flutter/material.dart';
import 'package:motokar/screens/host/host_chat/host_chat_widget.dart';
import 'package:motokar/screens/shared/colors.dart';
import 'package:stacked/stacked.dart';
import '../../shared/my_toast.dart';
import 'package:motokar/screens/shared/appBar.dart';

import '../host_chat/host_chat_viewmodel.dart';

class HostChatView extends StatefulWidget {
  HostChatView();

  @override
  _HostChatViewState createState() => _HostChatViewState();
}

class _HostChatViewState extends State<HostChatView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HostChatViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => HostChatViewModel(),
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
                        return HostChatWidget(
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
