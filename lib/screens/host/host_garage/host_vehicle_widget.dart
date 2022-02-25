import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:motokar/models/vehicle.dart';
import 'package:motokar/models/profile.dart';
import 'package:motokar/screens/host/host_garage/host_updateVehicle_view.dart';
import 'package:motokar/screens/shared/colors.dart';

class HostVehicleWidget extends StatelessWidget {
  final Vehicle vehicle;

  HostVehicleWidget({this.vehicle});

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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          HostUpdateVehicleView(vehicle: vehicle)));
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
                          'RM' + vehicle.price.toStringAsFixed(2),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600),
                        ),
                        // SizedBox(height: 8.5),
                        // Row(
                        //   children: [
                        //     Text(
                        //       vehicle.description,
                        //       style: TextStyle(
                        //           color: Colors.white,
                        //           fontSize: 13.0,
                        //           fontWeight: FontWeight.w500),
                        //     ),
                        //   ],
                        // ),
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
