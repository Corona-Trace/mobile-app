import 'dart:async';

import 'package:corona_trace/network/repository_notifications.dart';
import 'package:corona_trace/ui/base_state.dart';
import 'package:corona_trace/ui/notifications/ct_notification_detail_card.dart';
import 'package:corona_trace/utils/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  Set<Marker> _markers = new Set<Marker>();

  @override
  void initState() {
    super.initState();
    inititalCameraPosition = CameraPosition(
      target: LatLng(widget.notification.lat, widget.notification.lng),
      zoom: 16,
    );
    _markers.add(Marker(
        markerId: MarkerId(widget.notification.id.toString()),
        position: LatLng(widget.notification.lat, widget.notification.lng)));
  }

  @override
  Widget prepareWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalization.text("Location")),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                child: flutterMap(),
                height: MediaQuery.of(context).size.height * 0.5,
              ),
              Container(
                child: CTNotificationDetailCard(
                  crossedPaths: widget.crossedPaths,
                  notificationItem: widget.notification,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  flutterMap() {
    return GoogleMap(
      mapType: MapType.normal,
      markers: _markers,
      zoomGesturesEnabled: false,
      scrollGesturesEnabled: false,
      tiltGesturesEnabled: false,
      rotateGesturesEnabled: false,
      myLocationButtonEnabled: false,
      initialCameraPosition: inititalCameraPosition,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }
}
