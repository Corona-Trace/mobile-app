
class AirtableRecordFields {
  String _name;

  String get name => _name;

  AirtableRecordFields(
      this._name);

  AirtableRecordFields.map(dynamic obj) {
    _name = obj["Name"];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["Name"] = _name;
    return map;
  }
}