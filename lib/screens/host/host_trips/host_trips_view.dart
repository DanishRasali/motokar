import 'package:flutter/material.dart';
import 'package:motokar/models/trip.dart';
import 'package:motokar/models/vehicle.dart';
import 'package:motokar/screens/host/host_trips/host_trip_request_widget.dart';
import 'package:motokar/screens/shared/appBar.dart';
import 'package:motokar/screens/host/host_trips/host_trip_widget.dart';
import 'package:motokar/services/authentication_service.dart';
import 'package:motokar/services/profile_service.dart';
import 'package:stacked/stacked.dart';
import 'package:provider/provider.dart';
import '../../shared/my_toast.dart';

import 'host_trips_viewmodel.dart';

class HostTripsView extends StatefulWidget {
  HostTripsView();

  @override
  _HostTripsViewState createState() => _HostTripsViewState();
}

class _HostTripsViewState extends State<HostTripsView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HostTripsViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => HostTripsViewModel(),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) => DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: Image.asset('assets/images/zen.png', fit: BoxFit.cover, height: 48),
              bottom: const TabBar(
                tabs: [
                  Tab(text: "My bookings"),
                  Tab(text: "Book requests"),
                ],
              ),
            ),
            body: model.isBusy
            ? Center(child: CircularProgressIndicator())
            : TabBarView(
              children: [
                model.empty ? 
                Column(
                  children: [
                    Expanded(child: Center(child: Text('No Bookings'))),
                  ],
                ) 
                : 
                Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: model.tripList == null
                            ? 1
                            : model.tripList.length,
                        itemBuilder: (context, index) {
                          final Trip trip = model.tripList[index];
                          final Vehicle vehicle =
                              model.getVehicle(trip.vehicleId);
                          return HostTripWidget(
                            trip: trip,
                            vehicle: vehicle,
                            vehicleProfile: model.getVehicleProfile(vehicle.profileId),
                            vehicleRating: model.getVehicleRating(vehicle.id)
                          );
                        },
                      ),
                    ),
                  ],
                ),
                model.empty2 ?
                Column(
                  children: [
                    Expanded(child: Center(child: Text('No Booking requests'))),
                  ],
                )
                :
                Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: model.tripRequestList == null
                            ? 1
                            : model.tripRequestList.length,
                        itemBuilder: (context, index) {
                          final Trip trip = model.tripRequestList[index];
                          final Vehicle vehicle =
                              model.getVehicle(trip.vehicleId);
                          return HostTripRequestWidget(
                            trip: trip,
                            vehicle: vehicle,
                            vehicleProfile: model.getVehicleProfile(trip.profileId),
                          );
                        },
                      ),
                    ),
                  ],
                )
              ]
            )
        )
      )
    );
  }
}
