
class AirtableRecordFields {
  String _name;
  bool _availability;

  String get name => _name;

  bool get availability => _availability;

  AirtableRecordFields(
      this._name, this._availability);

  AirtableRecordFields.map(dynamic obj) {
    _name = obj["Name"];
    _availability = obj["Availability"];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["Name"] = _name;
    map["Availability"] = _availability;
    return map;
  }
}