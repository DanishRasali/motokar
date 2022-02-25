import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:motokar/models/post.dart';
import 'package:motokar/screens/guest/guest_main/guest_main_screen.dart';
import 'package:stacked/stacked.dart';
import 'package:motokar/screens/shared/appBar.dart';
import 'package:motokar/screens/shared/textField.dart';
import 'package:motokar/screens/shared/buttons.dart';

import 'package:motokar/screens/shared/colors.dart';
import 'package:motokar/screens/shared/divider.dart';
import 'package:motokar/screens/shared/toastAndDialog.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'guest_post_viewmodel.dart';

class GuestUpdatePostView extends StatefulWidget {
  const GuestUpdatePostView({this.post});
  final Post post;

  @override
  _GuestUpdatePostViewState createState() => _GuestUpdatePostViewState();
}

class _GuestUpdatePostViewState extends State<GuestUpdatePostView> {
  TextEditingController contentController = TextEditingController();

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
  void initState() {
    super.initState();
    contentController = TextEditingController(text: widget.post.content);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return ViewModelBuilder<GuestPostViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => GuestPostViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: buildSectionBar(context, 'Update Post'),
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
                                child: _imageFile == null &&
                                        (widget.post.postPicture == '' ||
                                            widget.post.postPicture ==
                                                null)
                                    ? Image.asset('assets/images/myhouse.jpg')
                                    : _imageFile != null &&
                                            (widget.post.postPicture ==
                                                    '' ||
                                                widget.post.postPicture ==
                                                    null)
                                        ? Image.file(
                                            _imageFile,
                                            fit: BoxFit.cover,
                                          )
                                        : CachedNetworkImage(
                                            imageUrl:
                                                widget.post.postPicture,
                                            fit: BoxFit.fill,
                                            placeholder: (context, url) => Center(
                                                child:
                                                    CircularProgressIndicator()),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
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
                      child: transparentButton("Update Post", () async {
                        if (_formKey.currentState.validate()) {
                          if (_imageFile == null) {
                            model.updatePost(
                              id: widget.post.id,
                              content: contentController.text,
                            );
                            await Future.delayed(Duration(seconds: 1));
                            awesomeToast('Post Updated!');
                            Navigator.of(context, rootNavigator: true)
                                .pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            GuestMainScreen(tab: 2)),
                                    (route) => false);
                          } else {
                            model.updatePost(
                              id: widget.post.id,
                              content: contentController.text,
                              postPicture: _imageFile,
                            );
                            await Future.delayed(Duration(seconds: 1));
                            awesomeToast('Post Updated!');
                            Navigator.of(context, rootNavigator: true)
                                .pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            GuestMainScreen(tab: 2)),
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
