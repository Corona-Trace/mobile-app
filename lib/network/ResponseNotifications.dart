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

/// _id : "5e7c92e36394cd10e8e7c508"
/// userId : "614714e56498ea8e"
/// timestamp : "2020-03-26T11:32:51.491Z"
/// address : "qwertyuio"

class ResponseNotificationItem {
  String _Id;
  String _userId;
  String _timestamp;
  String _address;

  String get Id => _Id;

  String get userId => _userId;

  String get timestamp => _timestamp;

  String get address => _address;

  ResponseNotificationItem(
      this._Id, this._userId, this._timestamp, this._address);

  ResponseNotificationItem.map(dynamic obj) {
    _Id = obj["Id"];
    _userId = obj["userId"];
    _timestamp = obj["timestamp"];
    _address = obj["address"];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["Id"] = _Id;
    map["userId"] = _userId;
    map["timestamp"] = _timestamp;
    map["address"] = _address;
    return map;
  }
}
