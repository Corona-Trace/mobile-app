import 'package:corona_trace/network/notification/response_notification_item.dart';

/// data : [{"_id":"5e7c92e36394cd10e8e7c508","userId":"614714e56498ea8e","timestamp":"2020-03-26T11:32:51.491Z","address":"qwertyuio"},{"_id":"5e7c92e36394cd10e8e7c508","userId":"614714e56498ea8e","timestamp":"2020-03-26T11:32:51.491Z","address":"qwertyuio"}]
/// message : ""
class ResponseNotifications {
  List<ResponseNotificationItem> _data;
  String _message;

  List<ResponseNotificationItem> get data => _data;

  String get message => _message;

  ResponseNotifications(this._data, this._message);

  ResponseNotifications.map(dynamic obj) {
    print(obj);
    _data = obj["data"] == null
        ? null
        : new List<ResponseNotificationItem>.from(
            obj["data"].map((x) => ResponseNotificationItem.map(x)));
    _message = obj["message"] ?? "";
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["data"] = _data;
    map["message"] = _message;
    return map;
  }
}
