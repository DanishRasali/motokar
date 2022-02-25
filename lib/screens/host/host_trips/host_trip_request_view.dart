import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
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

class HostTripRequestView extends StatefulWidget {
  const HostTripRequestView({this.trip, this.vehicle, this.vehicleProfile});
  final Trip trip;
  final Vehicle vehicle;
  final Profile vehicleProfile;
  @override
  _HostTripRequestViewState createState() => _HostTripRequestViewState();
}

class _HostTripRequestViewState extends State<HostTripRequestView> {

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return ViewModelBuilder<HostTripsViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => HostTripsViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: buildSectionBar(context, 'View Book Request'),
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  Padding(
                    padding: EdgeInsets.only(
                                  top: 20, bottom: 0, left: 15, right: 15),
                    child: Text(
                      'Booked by:',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 20),
                    ),
                  ),
                  awesomeTopProfile(
                      context, screenWidth, widget.vehicleProfile),
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
                              padding: EdgeInsets.only(
                                  bottom: 15, left: 15, right: 15),
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
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18),
                              ),
                              ElevatedButton(
                                  child: Text(
                                      'RM' + widget.trip.totalPrice.toStringAsFixed(2),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
