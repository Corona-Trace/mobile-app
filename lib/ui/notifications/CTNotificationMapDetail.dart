import 'dart:async';

import 'package:corona_trace/network/ResponseNotifications.dart';
import 'package:corona_trace/ui/BaseState.dart';
import 'package:corona_trace/ui/notifications/CTNotificationDetailCard.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class CTNotificationMapDetail extends StatefulWidget {
  final bool crossedPaths;
  final ResponseNotificationItem notification;

  CTNotificationMapDetail({this.crossedPaths, this.notification});

  @override
  _NotificationMapDetailState createState() => _NotificationMapDetailState();
}

class _NotificationMapDetailState extends BaseState<CTNotificationMapDetail> {
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  double offset = 100;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        offset = MediaQuery.of(context).size.height * 0.85;
      });
    });
  }

  @override
  Widget prepareWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location"),
      ),
      body: Stack(
        children: <Widget>[flutterMap(), notificationContainer()],
      ),
    );
  }

  Widget notificationContainer() {
    return Align(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              child: CTNotificationDetailCard(
                crossedPaths: widget.crossedPaths,
                notificationItem: widget.notification,
              ),
            )
          ],
        ),
      ),
      alignment: Alignment.bottomCenter,
    );
  }

  flutterMap() {
    return GoogleMap(
      mapType: MapType.normal,
      padding: EdgeInsets.only(bottom: offset, left: 15),
      initialCameraPosition: _kGooglePlex,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }
}
