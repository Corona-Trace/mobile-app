/// _id : "5e7c92e36394cd10e8e7c508"
/// userId : "614714e56498ea8e"
/// timestamp : "2020-03-26T11:32:51.491Z"
/// address : "qwertyuio"
class ResponseNotificationItem {
  String _id;
  String _userId;
  String _timestamp;
  String _address;
  double lat;
  double lng;

  String get id => _id;

  String get userId => _userId;

  String get timestamp => _timestamp;

  String get address => _address;

  ResponseNotificationItem(
      this._id, this._userId, this._timestamp, this._address);

  ResponseNotificationItem.map(dynamic obj) {
    _id = obj["id"];
    _userId = obj["userId"];
    _timestamp = obj["timestamp"];
    _address = obj["address"];
    lat = double.parse(obj["lat"].toString());
    lng = double.parse(obj["lng"].toString());
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["Id"] = _id;
    map["userId"] = _userId;
    map["timestamp"] = _timestamp;
    map["address"] = _address;
    map["lat"] = lat;
    map["lng"] = lng;
    return map;
  }
}
