import 'dart:io';

import 'package:flutter/material.dart';
import 'package:motokar/screens/host/host_main/host_main_screen.dart';
import 'package:stacked/stacked.dart';
import 'package:motokar/screens/shared/appBar.dart';
import 'package:motokar/screens/shared/textField.dart';
import 'package:motokar/screens/shared/buttons.dart';

import 'package:motokar/screens/shared/colors.dart';
import 'package:motokar/screens/shared/divider.dart';
import 'package:motokar/screens/shared/toastAndDialog.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'host_post_viewmodel.dart';

class HostAddPostView extends StatefulWidget {
  const HostAddPostView();

  @override
  _HostAddPostViewState createState() => _HostAddPostViewState();
}

class _HostAddPostViewState extends State<HostAddPostView> {
  final contentController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  File _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    PickedFile selected = await ImagePicker().getImage(source: source);

    setState(() {
      _imageFile = File(selected.path);
    });
  }

  void _clear() {
    setState(() {
      _imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return ViewModelBuilder<HostPostViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => HostPostViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: buildSectionBar(context, 'Add Post'),
        body: Stack(
          children: [
            Container(
              height: screenHeight,
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          top: 15, bottom: 5, left: 15, right: 15),
                      width: screenWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Image:',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 18),
                          ),
                          SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: InkWell(
                                onTap: () {
                                  awesomeDoubleButtonDialog(
                                      context,
                                      'Snap it or Pick it?',
                                      'A decent home picture works best',
                                      'Camera',
                                      () {
                                        _pickImage(ImageSource.camera);
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop();
                                      },
                                      'Gallery',
                                      () {
                                        _pickImage(ImageSource.gallery);
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop();
                                      });
                                },
                                child: _imageFile == null
                                    ? Image.asset('assets/images/myhouse.jpg')
                                    : Image.file(
                                        _imageFile,
                                        fit: BoxFit.cover,
                                      )),
                          ),
                        ],
                      ),
                    ),
                    _imageFile != null
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  icon: Icon(Icons.cancel_outlined),
                                  onPressed: _clear)
                            ],
                          )
                        : SizedBox(height: 31),
                    Container(
                      padding: EdgeInsets.only(
                          top: 15, bottom: 5, left: 15, right: 15),
                      width: screenWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Content:',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 18),
                          ),
                          SizedBox(height: 5),
                          awesomeTextField(
                            contentController,
                            'Tap to enter content...',
                            6,
                            10,
                            screenWidth,
                            TextInputType.multiline,
                            'content',
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: transparentButton("Add Post", () async {
                        if (_formKey.currentState.validate()) {
                          if (_imageFile == null) {
                            model.createPost(
                              content: contentController.text,
                              createdBy: model.currentProfile.id,
                            );
                            await Future.delayed(Duration(seconds: 1));
                            awesomeToast('Post Added!');
                            Navigator.of(context, rootNavigator: true)
                                .pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            HostMainScreen(tab: 3)),
                                    (route) => false);
                          } else {
                            model.createPost(
                              content: contentController.text,
                              postPicture: _imageFile,
                              createdBy: model.currentProfile.id,
                            );
                            await Future.delayed(Duration(seconds: 1));
                            awesomeToast('Post Added!');
                            Navigator.of(context, rootNavigator: true)
                                .pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            HostMainScreen(tab: 3)),
                                    (route) => false);
                          }
                        }
                      }, Color.fromRGBO(253, 121, 168, 1),
                          Color.fromRGBO(253, 121, 168, 1), screenWidth - 30,
                          textColor: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
