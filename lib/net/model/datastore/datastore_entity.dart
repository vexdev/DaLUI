import 'package:dalui/net/model/datastore/datastore_key.dart';
import 'package:json_annotation/json_annotation.dart';

part 'datastore_entity.g.dart';

@JsonSerializable()
class DatastoreEntity {
  final DatastoreKey? key;
  final Map<String, DatastorePropertiesValue> properties;

  DatastoreEntity({required this.key, required this.properties});
  factory DatastoreEntity.fromJson(Map<String, dynamic> json) =>
      _$DatastoreEntityFromJson(json);
  Map<String, dynamic> toJson() => _$DatastoreEntityToJson(this);
}

@JsonSerializable()
class DatastorePropertiesValue {
  final String? nullValue;
  final String? stringValue;
  final String? integerValue;
  final double? doubleValue;
  final bool? booleanValue;
  final String? timestampValue;
  final DatastoreKey? keyValue;
  final String? blobValue;
  final DatastoreLatLng? geoPointValue;
  final DatastoreEntity? entityValue;
  final DatastoreArrayValue? arrayValue;

  DatastorePropertiesValue({
    this.nullValue,
    this.stringValue,
    this.integerValue,
    this.doubleValue,
    this.booleanValue,
    this.timestampValue,
    this.keyValue,
    this.blobValue,
    this.geoPointValue,
    this.entityValue,
    this.arrayValue,
  });

  factory DatastorePropertiesValue.fromJson(Map<String, dynamic> json) =>
      _$DatastorePropertiesValueFromJson(json);

  Map<String, dynamic> toJson() => _$DatastorePropertiesValueToJson(this);
}

@JsonSerializable()
class DatastoreLatLng {
  final double latitude;
  final double longitude;

  DatastoreLatLng({required this.latitude, required this.longitude});

  factory DatastoreLatLng.fromJson(Map<String, dynamic> json) =>
      _$DatastoreLatLngFromJson(json);
  Map<String, dynamic> toJson() => _$DatastoreLatLngToJson(this);
}

@JsonSerializable()
class DatastoreArrayValue {
  final List<DatastorePropertiesValue>? values;

  DatastoreArrayValue({required this.values});

  factory DatastoreArrayValue.fromJson(Map<String, dynamic> json) =>
      _$DatastoreArrayValueFromJson(json);
  Map<String, dynamic> toJson() => _$DatastoreArrayValueToJson(this);
}
