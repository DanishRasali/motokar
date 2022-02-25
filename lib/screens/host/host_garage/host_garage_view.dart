import 'package:flutter/material.dart';
import 'package:motokar/screens/host/host_garage/host_addVehicle_view.dart';
import 'package:motokar/screens/host/host_garage/host_vehicle_widget.dart';
import 'package:motokar/screens/shared/appBar.dart';
import 'package:motokar/services/authentication_service.dart';
import 'package:motokar/services/profile_service.dart';
import 'package:stacked/stacked.dart';
import 'package:provider/provider.dart';
import '../../shared/my_toast.dart';
import 'package:motokar/screens/shared/colors.dart';

import 'host_garage_viewmodel.dart';

class HostGarageView extends StatefulWidget {
  HostGarageView();

  @override
  _HostGarageViewState createState() => _HostGarageViewState();
}

class _HostGarageViewState extends State<HostGarageView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HostGarageViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => HostGarageViewModel(),
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
                      Expanded(child: Center(child: Text('No Homestays'))),
                    ],
                  )
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: model.vehicleList == null
                              ? 1
                              : model.vehicleList.length,
                          itemBuilder: (context, index) {
                            final vehicle = model.vehicleList[index];
                            return HostVehicleWidget(vehicle: vehicle);
                          },
                        ),
                      ),
                    ],
                  ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, color: Colors.white),
          backgroundColor: accentColor,
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => HostAddVehicleView()));
          },
        ),
      ),
    );
  }
}
