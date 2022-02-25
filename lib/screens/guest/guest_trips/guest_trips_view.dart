import 'package:flutter/material.dart';
import 'package:motokar/models/trip.dart';
import 'package:motokar/models/vehicle.dart';
import 'package:motokar/screens/shared/appBar.dart';
import 'package:motokar/screens/guest/guest_trips/guest_trip_widget.dart';
import 'package:motokar/services/authentication_service.dart';
import 'package:motokar/services/profile_service.dart';
import 'package:stacked/stacked.dart';
import 'package:provider/provider.dart';
import '../../shared/my_toast.dart';

import 'guest_trips_viewmodel.dart';

class GuestTripsView extends StatefulWidget {
  GuestTripsView();

  @override
  _GuestTripsViewState createState() => _GuestTripsViewState();
}

class _GuestTripsViewState extends State<GuestTripsView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GuestTripsViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => GuestTripsViewModel(),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Image.asset('assets/images/zen.png', fit: BoxFit.cover, height: 48),
        ),
        body: model.isBusy
            ? Center(child: CircularProgressIndicator())
            : model.empty
                ? Column(
                    children: [
                      Expanded(child: Center(child: Text('No Bookings'))),
                    ],
                  )
                : Column(
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
                            return GuestTripWidget(
                                trip: trip,
                                vehicle: vehicle,
                                vehicleProfile:
                                    model.getVehicleProfile(vehicle.profileId),
                                vehicleRating: model.getVehicleRating(vehicle.id));
                          },
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}
