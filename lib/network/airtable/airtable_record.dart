import 'package:corona_trace/network/airtable/airtable_record_fields.dart';

class AirtableRecord {
  String _id;
  AirtableRecordFields _fields;
  String _createdTime;

  String get id => _id;

  AirtableRecordFields get fields => _fields;

  String get createdTime => _createdTime;

  AirtableRecord(
      this._id, this._fields, this._createdTime);

  AirtableRecord.map(dynamic obj) {
    _id = obj["id"];
    _fields = obj["fields"];
    _createdTime = obj["createdTime"];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["Id"] = _id;
    map["fields"] = _fields;
    map["createdTime"] = _createdTime;
    return map;
  }
}