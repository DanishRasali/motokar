import 'package:flutter/material.dart';
import 'package:motokar/screens/host/host_chat/host_chat_view.dart';
import 'package:motokar/screens/host/host_explore/host_vehicle_widget.dart';
import 'package:motokar/services/authentication_service.dart';
import 'package:motokar/services/profile_service.dart';
import 'package:stacked/stacked.dart';
import 'package:provider/provider.dart';
import '../../shared/my_toast.dart';
import 'package:motokar/screens/shared/appBar.dart';
import 'package:motokar/screens/shared/colors.dart';

import 'host_explore_viewmodel.dart';

class HostExploreView extends StatefulWidget {
  HostExploreView();

  @override
  _HostExploreViewState createState() => _HostExploreViewState();
}

class _HostExploreViewState extends State<HostExploreView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HostExploreViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => HostExploreViewModel(),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('assets/images/zen.png', fit: BoxFit.cover, height: 48),
              InkWell(
                child:Icon(Icons.chat_outlined, size: 40, color: accentColor),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HostChatView()
                    )
                  );
                },
              ),
            ],
          ),
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
                            return HostVehicleWidget(
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
