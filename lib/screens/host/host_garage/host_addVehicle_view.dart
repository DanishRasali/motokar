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

import 'host_garage_viewmodel.dart';

class HostAddVehicleView extends StatefulWidget {
  const HostAddVehicleView();

  @override
  _HostAddVehicleViewState createState() => _HostAddVehicleViewState();
}

class _HostAddVehicleViewState extends State<HostAddVehicleView> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final typeController = TextEditingController();
  final occupantController = TextEditingController();
  final roomController = TextEditingController();
  final bedController = TextEditingController();

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

    return ViewModelBuilder<HostGarageViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => HostGarageViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: buildSectionBar(context, 'Add Homestay'),
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
                    // awesomeDivider(0.8, dividerColor),
                    Container(
                      padding: EdgeInsets.only(
                          top: 15, bottom: 5, left: 15, right: 15),
                      width: screenWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name:',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 18),
                          ),
                          SizedBox(height: 5),
                          awesomeTextField(
                            nameController,
                            'Tap to enter homestay name...',
                            1,
                            10,
                            screenWidth,
                            TextInputType.multiline,
                            'name',
                          ),
                        ],
                      ),
                    ),
                    // awesomeDivider(0.8, dividerColor),
                    Container(
                      padding: EdgeInsets.only(
                          top: 15, bottom: 5, left: 15, right: 15),
                      width: screenWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Description:',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 18),
                          ),
                          SizedBox(height: 5),
                          awesomeTextField(
                            descriptionController,
                            'Tap to enter description...',
                            6,
                            10,
                            screenWidth,
                            TextInputType.multiline,
                            'description',
                          ),
                        ],
                      ),
                    ),
                    // awesomeDivider(0.8, dividerColor),
                    Container(
                      padding: EdgeInsets.only(
                          top: 15, bottom: 5, left: 15, right: 15),
                      width: screenWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Price (RM):',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 18),
                          ),
                          SizedBox(height: 5),
                          awesomeTextField(
                            priceController,
                            '00.00',
                            1,
                            10,
                            screenWidth,
                            TextInputType.number,
                            'price',
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 15, bottom: 5, left: 15, right: 15),
                      width: screenWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Type:',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 18),
                          ),
                          SizedBox(height: 5),
                          awesomeTextField(
                            typeController,
                            '00.00',
                            1,
                            10,
                            screenWidth,
                            TextInputType.multiline,
                            'type',
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 15, bottom: 5, left: 15, right: 15),
                      width: screenWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Max Occupants:',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 18),
                          ),
                          SizedBox(height: 5),
                          awesomeTextField(
                            occupantController,
                            '00.00',
                            1,
                            10,
                            screenWidth,
                            TextInputType.number,
                            'occupant',
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 15, bottom: 5, left: 15, right: 15),
                      width: screenWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Rooms:',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 18),
                          ),
                          SizedBox(height: 5),
                          awesomeTextField(
                            roomController,
                            '00.00',
                            1,
                            10,
                            screenWidth,
                            TextInputType.number,
                            'rooms',
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 15, bottom: 5, left: 15, right: 15),
                      width: screenWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Beds:',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 18),
                          ),
                          SizedBox(height: 5),
                          awesomeTextField(
                            bedController,
                            '',
                            1,
                            10,
                            screenWidth,
                            TextInputType.number,
                            'beds',
                          ),
                        ],
                      ),
                    ),
                    // Container(
                    //   padding: EdgeInsets.only(
                    //       top: 15, bottom: 5, left: 15, right: 15),
                    //   width: screenWidth,
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Row(
                    //         children: [
                    //           Text(
                    //             'Price (RM):',
                    //             style: TextStyle(
                    //                 color: Colors.white,
                    //                 fontWeight: FontWeight.w400,
                    //                 fontSize: 18),
                    //           ),
                    //           Spacer(),
                    //           awesomeTextField(
                    //             priceController,
                    //             '00.00',
                    //             1,
                    //             1,
                    //             200,
                    //             TextInputType.number,
                    //             'price',
                    //           )
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: transparentButton("Add Homestay", () async {
                        double newPrice;
                        if (priceController.text != '') {
                          var price = double.parse(priceController.text);
                          newPrice = price;
                        }

                        if (_formKey.currentState.validate()) {
                          if (_imageFile == null) {
                            model.createVehicle(
                              name: nameController.text,
                              description: descriptionController.text,
                              price: newPrice,
                              profileId: model.currentProfile.id,
                              type: typeController.text,
                              occupant: occupantController.text,
                              room: roomController.text,
                              bed: bedController.text,
                            );
                            await Future.delayed(Duration(seconds: 1));
                            awesomeToast('Homestay Added!');
                            Navigator.of(context, rootNavigator: true)
                                .pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            HostMainScreen(tab: 2)),
                                    (route) => false);
                          } else {
                            model.createVehicle(
                              name: nameController.text,
                              description: descriptionController.text,
                              price: newPrice,
                              vehiclePicture: _imageFile,
                              profileId: model.currentProfile.id,
                              type: typeController.text,
                              occupant: occupantController.text,
                              room: roomController.text,
                              bed: bedController.text,
                            );
                            await Future.delayed(Duration(seconds: 1));
                            awesomeToast('Homestay Added!');
                            Navigator.of(context, rootNavigator: true)
                                .pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            HostMainScreen(tab: 2)),
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
