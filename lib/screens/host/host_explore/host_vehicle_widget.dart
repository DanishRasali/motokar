import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:motokar/models/vehicle.dart';
import 'package:motokar/models/profile.dart';
import 'package:motokar/screens/host/host_explore/host_bookVehicle_view.dart';
import 'package:motokar/screens/shared/colors.dart';
import 'package:motokar/screens/shared/topProfile.dart';

class HostVehicleWidget extends StatelessWidget {
  final Vehicle vehicle;
  final Profile vehicleProfile;
  final double vehicleRating;

  HostVehicleWidget({this.vehicle, this.vehicleProfile, this.vehicleRating});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Material(
      child: Container(
        // decoration: BoxDecoration(
        //   border: Border.symmetric(
        //     horizontal: BorderSide(
        //       width: 0.5,
        //       color: dividerColor,
        //     ),
        //   ),
        // ),
        color: Color.fromRGBO(66, 73, 75, 1),
        margin: EdgeInsets.only(bottom: 10),
        // padding: EdgeInsets.only(bottom: 10.5),
        child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HostBookVehicleView(
                          vehicle: vehicle, 
                          vehicleProfile: vehicleProfile,
                          vehicleRating: vehicleRating,
                          )));
            },
            child: Column(
              children: [
                awesomeTopProfile(
                      context, screenWidth, vehicleProfile),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: (vehicle.vehiclePicture != null &&
                          vehicle.vehiclePicture != '')
                      ? Image.network(vehicle.vehiclePicture)
                      : Image.asset('assets/images/myhouse.jpg'),
                ),
                ListTile(
                  dense: true,
                  title: Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                vehicle.name,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15),
                              ),
                              ElevatedButton(
                                child: Text(
                                  'RM' + vehicle.price.toStringAsFixed(2),
                                  style: TextStyle(fontSize: 14)
                                ),
                                style: ButtonStyle(
                                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                  backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(253, 121, 168, 1)),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Color.fromRGBO(253, 121, 168, 1))
                                    )
                                  )
                                ),
                                onPressed: () => null
                              )
                            ],
                          )
                  ),
                  subtitle: 
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: RatingBar.builder(
                        ignoreGestures: true,
                        itemSize: 20,
                        initialRating: vehicleRating,
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
              ],
            )),
      ),
    );
  }
}
