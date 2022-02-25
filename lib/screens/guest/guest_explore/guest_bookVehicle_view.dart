import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:motokar/screens/guest/guest_main/guest_main_screen.dart';
import 'package:motokar/screens/shared/toastAndDialog.dart';
import 'package:stacked/stacked.dart';
import 'package:motokar/models/vehicle.dart';
import 'package:motokar/models/profile.dart';
import 'package:motokar/screens/guest/guest_trips/guest_trips_viewmodel.dart';
import 'package:motokar/screens/shared/appBar.dart';
import 'package:motokar/screens/shared/textField.dart';
import 'package:motokar/screens/shared/buttons.dart';

import 'package:motokar/screens/shared/colors.dart';
import 'package:motokar/screens/shared/styles.dart';
import 'package:motokar/screens/shared/divider.dart';
import 'package:motokar/screens/shared/topProfile.dart';

import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class GuestBookVehicleView extends StatefulWidget {
  const GuestBookVehicleView({this.vehicle, this.vehicleProfile, this.vehicleRating});
  final Vehicle vehicle;
  final Profile vehicleProfile;
  final double vehicleRating;

  @override
  _GuestBookVehicleViewState createState() => _GuestBookVehicleViewState();
}

class _GuestBookVehicleViewState extends State<GuestBookVehicleView> {
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  double _totalPrice = 0.00;
  get totalPrice => _totalPrice;
  set totalPrice(value) => setState(() => _totalPrice = value);

  DateTime _startDate = null;
  get startDate => _startDate;
  set startDate(value) => setState(() => _startDate = value);

  DateTime _endDate = null;
  get endDate => _endDate;
  set endDate(value) => setState(() => _endDate = value);

  Map<String, dynamic> paymentIntentData;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return ViewModelBuilder<GuestTripsViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => GuestTripsViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: buildSectionBar(context, 'Book Homestay'),
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
                      )
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
                  Form(
                      key: _formKey,
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
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18),
                                  ),
                                  SizedBox(height: 5),
                                  Container(
                                    width: screenWidth,
                                    child: TextFormField(
                                      autocorrect: false,
                                      // ignore: missing_return
                                      validator: (val) {
                                        if (val.isEmpty) {
                                          return ('Please insert Start date');
                                        }
                                      },
                                      controller: startDateController,
                                      keyboardType: TextInputType.multiline,
                                      minLines: 1,
                                      maxLines: 10,
                                      readOnly: true,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w500),
                                      decoration: InputDecoration(
                                        hintText: '',
                                        hintStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w400),
                                        fillColor:
                                            Color.fromRGBO(99, 110, 114, 1),
                                        filled: true,
                                        contentPadding: EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                            bottom: 10,
                                            top: 10),
                                        enabledBorder: const OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Color.fromRGBO(
                                                    99, 110, 114, 1),
                                                width: 0.5)),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(2.0),
                                        ),
                                        prefixIcon: IconButton(
                                          icon: Icon(
                                            Icons.calendar_today_outlined,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime.now(),
                                                    lastDate: DateTime(2100))
                                                .then((date) {
                                              setState(() {
                                                startDate = date;
                                                var formatter = new DateFormat(
                                                    'dd/MM/yyyy');
                                                String sd =
                                                    formatter.format(date);
                                                startDateController.text = sd;

                                                if (startDate != null &&
                                                    endDate != null) {
                                                  totalPrice = endDate
                                                          .difference(startDate)
                                                          .inDays *
                                                      widget.vehicle.price;
                                                }
                                              });
                                            });
                                          },
                                        ),
                                      ),
                                    ),
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
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18),
                                  ),
                                  SizedBox(height: 5),
                                  Container(
                                    width: screenWidth,
                                    child: TextFormField(
                                      autocorrect: false,
                                      // ignore: missing_return
                                      validator: (val) {
                                        if (val.isEmpty) {
                                          return ('Please insert End date');
                                        }
                                      },
                                      controller: endDateController,
                                      keyboardType: TextInputType.multiline,
                                      minLines: 1,
                                      maxLines: 10,
                                      readOnly: true,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w500),
                                      decoration: InputDecoration(
                                        hintText: '',
                                        hintStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w400),
                                        fillColor:
                                            Color.fromRGBO(99, 110, 114, 1),
                                        filled: true,
                                        contentPadding: EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                            bottom: 10,
                                            top: 10),
                                        enabledBorder: const OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Color.fromRGBO(
                                                    99, 110, 114, 1),
                                                width: 0.5)),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(2.0),
                                        ),
                                        prefixIcon: IconButton(
                                          icon: Icon(
                                            Icons.calendar_today_outlined,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime.now(),
                                                    lastDate: DateTime(2100))
                                                .then((date) {
                                              setState(() {
                                                endDate = date;
                                                var formatter = new DateFormat(
                                                    'dd/MM/yyyy');
                                                String ed =
                                                    formatter.format(date);
                                                endDateController.text = ed;

                                                if (startDate != null &&
                                                    endDate != null) {
                                                  totalPrice = endDate
                                                          .difference(startDate)
                                                          .inDays *
                                                      widget.vehicle.price;
                                                }
                                              });
                                            });
                                          },
                                        ),
                                      ),
                                    ),
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
                                      'RM' + totalPrice.toStringAsFixed(2),
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
                    child: transparentButton("Book Homestay", () async {
                      if (_formKey.currentState.validate()) {
                        makePayment(totalPrice * 100, model);
                      }
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

  Future<void> makePayment(totalPrice, model) async {
    final queryParameters = {
      'total_price': totalPrice.toStringAsFixed(0)
    };

    final uri =
        Uri.https('us-central1-motokar-map-98149.cloudfunctions.net', '/stripePayment', queryParameters);
    
    final response = await http.get(uri, headers: {
      'Content-Type': 'application/json'
    });

    paymentIntentData = json.decode(response.body);

    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntentData['paymentIntent'],
            applePay: true,
            googlePay: true,
            style: ThemeMode.dark,
            merchantCountryCode: 'MY',
            merchantDisplayName: 'ZEN Homestay'));

    setState(() {});

    displayPaymentSheet(model);
  }

  Future<void> displayPaymentSheet(model) async {
    try {
      await Stripe.instance.presentPaymentSheet(
          parameters: PresentPaymentSheetParameters(
              clientSecret: paymentIntentData['paymentIntent'],
              confirmPayment: true));

      setState(() {
        paymentIntentData = null;
      });

      model.createTrip(
        startDate: startDateController.text,
        endDate: endDateController.text,
        totalPrice: totalPrice,
        vehicleId: widget.vehicle.id,
        profileId: model.currentProfile.id,
        context: context,
      );
      await Future.delayed(Duration(seconds: 1));
      awesomeToast('Homestay Booking Created!');
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => GuestMainScreen(tab: 1)));
    } catch (e) {
      print(e);
    }
  }
}
