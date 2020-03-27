import 'dart:async';

import 'package:corona_trace/network/APIRepository.dart';
import 'package:corona_trace/network/ResponseNotifications.dart';
import 'package:flutter/material.dart';

class CTNotificationsBloc {
  final _suggestions = List<ResponseNotificationItem>();

  final StreamController<List<ResponseNotificationItem>>
      _notificationsController =
      StreamController<List<ResponseNotificationItem>>();

  Stream<List<ResponseNotificationItem>> get notificationsStream =>
      _notificationsController.stream;
  int pageNo = 1;
  int totalItems = 10;

  void fetchNotifications() async {
    pageNo = 1;
    _suggestions.clear();
    fetchNotificationsInternal();
  }

  void fetchNotificationsInternal() async {
    var value = await ApiRepository.getNotificationsList(pageNo);
    handleNotifications(value.data);
  }

  void dispose() {
    _notificationsController.close();
    _suggestions.clear();
  }

  void loadMore() {
    pageNo += 1;
    fetchNotificationsInternal();
  }

  handleNotifications(List<ResponseNotificationItem> data) {
    _suggestions.addAll(data);
    _notificationsController.sink.add(_suggestions);
  }
}
