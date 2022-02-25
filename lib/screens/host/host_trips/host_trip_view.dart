import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:motokar/models/trip.dart';
import 'package:motokar/screens/host/host_main/host_main_screen.dart';
import 'package:motokar/screens/shared/toastAndDialog.dart';
import 'package:stacked/stacked.dart';
import 'package:motokar/models/vehicle.dart';
import 'package:motokar/models/profile.dart';
import 'package:motokar/screens/host/host_trips/host_trips_viewmodel.dart';
import 'package:motokar/screens/shared/appBar.dart';
import 'package:motokar/screens/shared/textField.dart';
import 'package:motokar/screens/shared/buttons.dart';

import 'package:motokar/screens/shared/colors.dart';
import 'package:motokar/screens/shared/styles.dart';
import 'package:motokar/screens/shared/divider.dart';
import 'package:motokar/screens/shared/topProfile.dart';

import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class HostTripView extends StatefulWidget {
  const HostTripView(
      {this.trip, this.vehicle, this.vehicleProfile, this.vehicleRating});
  final Trip trip;
  final Vehicle vehicle;
  final Profile vehicleProfile;
  final double vehicleRating;

  @override
  _HostTripViewState createState() => _HostTripViewState();
}

class _HostTripViewState extends State<HostTripView> {
  double ratingValue = 0.0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return ViewModelBuilder<HostTripsViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => HostTripsViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: buildSectionBar(context, 'View Booking'),
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  awesomeTopProfile(
                      context, screenWidth, widget.vehicleProfile),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: (widget.vehicle.vehiclePicture != null &&
                            widget.vehicle.vehiclePicture != '')
                        ? Image.network(widget.vehicle.vehiclePicture)
                        : Image.asset('assets/images/myhouse.jpg'),
                  ),
                  Container(
                    width: screenWidth,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15, top: 20, bottom: 5),
                      child: Text(
                        widget.vehicle.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 27),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: screenWidth,
                    child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15, top: 5, bottom: 5),
                        child: RatingBar.builder(
                          ignoreGestures: true,
                          itemSize: 40,
                          initialRating: widget.vehicleRating,
                          minRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                          updateOnDrag: true,
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: accentColor,
                          ),
                          onRatingUpdate: (rating) {
                            // print(rating);
                          },
                        )),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15, top: 12.5, bottom: 20),
                      child: Row(
                        children: [
                          Expanded(
                              child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Container(
                                    height: 45,
                                    width: 45,
                                    color: Colors.grey,
                                    child: Icon(
                                      Icons.house,
                                      color: black,
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  widget.vehicle.type,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18),
                                ),
                              ),
                            ],
                          )),
                          Expanded(
                              child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Container(
                                    height: 45,
                                    width: 45,
                                    color: Colors.grey,
                                    child: Icon(
                                      Icons.person,
                                      color: black,
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  widget.vehicle.occupant + ' Guests',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18),
                                ),
                              ),
                            ],
                          )),
                          Expanded(
                              child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Container(
                                    height: 45,
                                    width: 45,
                                    color: Colors.grey,
                                    child: Icon(
                                      Icons.door_back,
                                      color: black,
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  widget.vehicle.room + ' Rooms',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18),
                                ),
                              ),
                            ],
                          )),
                          Expanded(
                              child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Container(
                                    height: 45,
                                    width: 45,
                                    color: Colors.grey,
                                    child: Icon(
                                      Icons.bed,
                                      color: black,
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  widget.vehicle.bed + ' Beds',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18),
                                ),
                              ),
                            ],
                          )),
                        ],
                      )),
                  Container(
                      color: Color.fromRGBO(66, 73, 75, 1),
                      width: screenWidth,
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15, top: 12.5, bottom: 12.5),
                          child: Text(
                            'About this listing',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 25),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15, bottom: 12.5),
                          child: Text(
                            widget.vehicle.description,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 21),
                          ),
                        ),
                      ])),
                  Form(
                      child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              top: 20, bottom: 20, left: 15, right: 15),
                          width: screenWidth,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Start Date:',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20),
                              ),
                              SizedBox(height: 5),
                              Text(
                                widget.trip.startDate,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.only(bottom: 15, left: 15, right: 15),
                          width: screenWidth,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'End date:',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20),
                              ),
                              SizedBox(height: 5),
                              Text(
                                widget.trip.endDate,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
                  // awesomeDivider(0.8, dividerColor),
                  Container(
                      width: screenWidth,
                      child: Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15, top: 12.5, bottom: 12.5),
                          child: Expanded(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total Price: ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20),
                              ),
                              ElevatedButton(
                                  child:
                                      Text('RM' + widget.trip.totalPrice.toStringAsFixed(2),
                                          style: TextStyle(fontSize: 14)),
                                  style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Color.fromRGBO(253, 121, 168, 1)),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                              side: BorderSide(
                                                  color: Color.fromRGBO(253, 121, 168, 1))))),
                                  onPressed: () => null)
                            ],
                          )))),
                  Spacer(),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 18),
                    child: transparentButton("Rate Homestay", () async {
                      showRating(model);
                    }, Color.fromRGBO(253, 121, 168, 1),
                        Color.fromRGBO(253, 121, 168, 1), screenWidth,
                        textColor: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showRating(model) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Rate this homestay"),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Please leave a start rating"),
            const SizedBox(height: 32),
            RatingBar.builder(
              itemSize: 40,
              initialRating: 0,
              minRating: 0,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
              updateOnDrag: true,
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: accentColor,
              ),
              onRatingUpdate: (rating) {
                ratingValue = rating;
              },
            )
          ],
        ),
        actions: [
          TextButton(
            child: Text("OK"),
            onPressed: () async {
              model.createRating(
                profileId: model.currentProfile.id,
                rate: ratingValue,
                vehicleId: widget.vehicle.id,
              );
              await Future.delayed(Duration(seconds: 1));
              awesomeToast('Rating has been made!');
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HostMainScreen(tab: 1)));
            }
          )
        ],
      ),
    );
  }
}
