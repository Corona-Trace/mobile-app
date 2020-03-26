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
  CameraPosition inititalCameraPosition;
  Set<Marker> _markers = {};
  double offset = 100;

  @override
  void initState() {
    super.initState();
    inititalCameraPosition = CameraPosition(
      target: LatLng(widget.notification.lat, widget.notification.lng),
      zoom: 16,
    );
    _markers.add(Marker(
        markerId: MarkerId(widget.notification.Id.toString()),
        position: LatLng(widget.notification.lat, widget.notification.lng)));
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
        children: <Widget>[
          flutterMap(),
          Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,color: Colors.black12,),
          Align(
            child: notificationContainer(),
            alignment: Alignment.bottomCenter,
          )
        ],
      ),
    );
  }

  Widget notificationContainer() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 500,
          ),
          CTNotificationDetailCard(
            crossedPaths: widget.crossedPaths,
            notificationItem: widget.notification,
          )
        ],
      ),
    );
  }

  flutterMap() {
    return GoogleMap(
      mapType: MapType.normal,
      markers: _markers,
      padding: EdgeInsets.only(bottom: offset, left: 15),
      initialCameraPosition: inititalCameraPosition,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }
}
