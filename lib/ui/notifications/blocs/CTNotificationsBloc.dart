import 'dart:async';

import 'package:corona_trace/network/APIRepository.dart';
import 'package:corona_trace/network/ResponseNotifications.dart';

class CTNotificationsBloc {
  final _suggestions = List<ResponseNotificationItem>();

  final StreamController<List<ResponseNotificationItem>>
      _notificationsController =
      StreamController<List<ResponseNotificationItem>>();

  bool _isloading = false;

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
    _isloading = true;
    var value = await ApiRepository.getNotificationsList(pageNo);
    handleNotifications(value.data);
    _isloading = false;
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
    if (!_notificationsController.isClosed) {
      _suggestions.addAll(data);
      _notificationsController.sink.add(_suggestions);
    }
  }

  bool isInitialLoading() {
    return pageNo == 1 && _isloading;
  }
}
