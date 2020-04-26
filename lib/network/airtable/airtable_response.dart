import 'package:corona_trace/network/airtable/airtable_record.dart';

class AirtableResponse {
  List<AirtableRecord> _records;
  String _offset;

  List<AirtableRecord> get records => _records;

  String get offset => _offset;

  AirtableResponse(this._records, this._offset);

  AirtableResponse.map(dynamic obj) {
    _records = obj["records"] == null
        ? null
        : new List<AirtableRecord>.from(
            obj["records"].map((x) => AirtableRecord.map(x)));
    _offset = obj["offset"] ?? "";
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["records"] = _records;
    map["offset"] = _offset;
    return map;
  }
}
