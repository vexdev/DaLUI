import 'package:dalui/net/model/datastore/datastore_key.dart';
import 'package:json_annotation/json_annotation.dart';

part 'datastore_entity.g.dart';

@JsonSerializable()
class DatastoreEntity {
  final DatastoreKey? key;
  final Map<String, DatastorePropertiesVal>? properties;

  DatastoreEntity({required this.key, required this.properties});
  factory DatastoreEntity.fromJson(Map<String, dynamic> json) =>
      _$DatastoreEntityFromJson(json);
  Map<String, dynamic> toJson() => _$DatastoreEntityToJson(this);
}

abstract class DatastorePropertiesVal {
  factory DatastorePropertiesVal.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('nullValue')) {
      return DatastorePropertiesNullValue.fromJson(json);
    } else {
      return DatastorePropertiesValue.fromJson(json);
    }
  }
  Map<String, dynamic> toJson();
}

@JsonSerializable()
class DatastorePropertiesNullValue implements DatastorePropertiesVal {
  @JsonKey(includeIfNull: true)
  final String? nullValue;

  DatastorePropertiesNullValue({this.nullValue});

  factory DatastorePropertiesNullValue.fromJson(Map<String, dynamic> json) =>
      _$DatastorePropertiesNullValueFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$DatastorePropertiesNullValueToJson(this);
}

@JsonSerializable(includeIfNull: false)
class DatastorePropertiesValue implements DatastorePropertiesVal {
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

  @override
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
  final List<DatastorePropertiesVal>? values;

  DatastoreArrayValue({required this.values});

  factory DatastoreArrayValue.fromJson(Map<String, dynamic> json) =>
      _$DatastoreArrayValueFromJson(json);
  Map<String, dynamic> toJson() => _$DatastoreArrayValueToJson(this);
}
