import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:motokar/models/trip.dart';
import 'package:motokar/models/vehicle.dart';
import 'package:motokar/models/profile.dart';
import 'package:motokar/screens/host/host_trips/host_trip_request_view.dart';
import 'package:motokar/screens/shared/colors.dart';

class HostTripRequestWidget extends StatelessWidget {
  final Trip trip;
  final Vehicle vehicle;
  final Profile vehicleProfile;

  HostTripRequestWidget({this.trip, this.vehicle, this.vehicleProfile});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          border: Border.symmetric(
            horizontal: BorderSide(
              width: 0.7,
              color: dividerColor,
            ),
          ),
        ),
        padding: EdgeInsets.only(bottom: 10.5),
        child: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context) => HostTripRequestView(
                      trip: trip,
                      vehicle: vehicle,
                      vehicleProfile: vehicleProfile,
                    )
                  )
              );
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: (vehicle.vehiclePicture != null &&
                          vehicle.vehiclePicture != '')
                      ? Image.network(vehicle.vehiclePicture)
                      : Image.asset('assets/images/myhouse.jpg'),
                ),
                ListTile(
                  dense: true,
                  title: Text(
                    vehicle.name,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600),
                  ),
                  subtitle: Container(
                    padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total price: RM' + trip.totalPrice.toStringAsFixed(2),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Rental Date: ' +
                              trip.startDate +
                              ' - ' +
                              trip.endDate,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Booked By: ' + vehicleProfile.displayName,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13.5,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
