// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datastore_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DatastoreEntity _$DatastoreEntityFromJson(Map<String, dynamic> json) =>
    DatastoreEntity(
      key: json['key'] == null
          ? null
          : DatastoreKey.fromJson(json['key'] as Map<String, dynamic>),
      properties: (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(
          k,
          DatastorePropertiesVal.fromJson(e as Map<String, dynamic>),
        ),
      ),
    );

Map<String, dynamic> _$DatastoreEntityToJson(DatastoreEntity instance) =>
    <String, dynamic>{'key': instance.key, 'properties': instance.properties};

DatastorePropertiesNullValue _$DatastorePropertiesNullValueFromJson(
  Map<String, dynamic> json,
) => DatastorePropertiesNullValue(nullValue: json['nullValue'] as String?);

Map<String, dynamic> _$DatastorePropertiesNullValueToJson(
  DatastorePropertiesNullValue instance,
) => <String, dynamic>{'nullValue': instance.nullValue};

DatastorePropertiesValue _$DatastorePropertiesValueFromJson(
  Map<String, dynamic> json,
) => DatastorePropertiesValue(
  nullValue: json['nullValue'] as String?,
  stringValue: json['stringValue'] as String?,
  integerValue: json['integerValue'] as String?,
  doubleValue: (json['doubleValue'] as num?)?.toDouble(),
  booleanValue: json['booleanValue'] as bool?,
  timestampValue: json['timestampValue'] as String?,
  keyValue: json['keyValue'] == null
      ? null
      : DatastoreKey.fromJson(json['keyValue'] as Map<String, dynamic>),
  blobValue: json['blobValue'] as String?,
  geoPointValue: json['geoPointValue'] == null
      ? null
      : DatastoreLatLng.fromJson(json['geoPointValue'] as Map<String, dynamic>),
  entityValue: json['entityValue'] == null
      ? null
      : DatastoreEntity.fromJson(json['entityValue'] as Map<String, dynamic>),
  arrayValue: json['arrayValue'] == null
      ? null
      : DatastoreArrayValue.fromJson(
          json['arrayValue'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$DatastorePropertiesValueToJson(
  DatastorePropertiesValue instance,
) => <String, dynamic>{
  if (instance.nullValue case final value?) 'nullValue': value,
  if (instance.stringValue case final value?) 'stringValue': value,
  if (instance.integerValue case final value?) 'integerValue': value,
  if (instance.doubleValue case final value?) 'doubleValue': value,
  if (instance.booleanValue case final value?) 'booleanValue': value,
  if (instance.timestampValue case final value?) 'timestampValue': value,
  if (instance.keyValue case final value?) 'keyValue': value,
  if (instance.blobValue case final value?) 'blobValue': value,
  if (instance.geoPointValue case final value?) 'geoPointValue': value,
  if (instance.entityValue case final value?) 'entityValue': value,
  if (instance.arrayValue case final value?) 'arrayValue': value,
};

DatastoreLatLng _$DatastoreLatLngFromJson(Map<String, dynamic> json) =>
    DatastoreLatLng(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$DatastoreLatLngToJson(DatastoreLatLng instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

DatastoreArrayValue _$DatastoreArrayValueFromJson(Map<String, dynamic> json) =>
    DatastoreArrayValue(
      values: (json['values'] as List<dynamic>?)
          ?.map(
            (e) => DatastorePropertiesVal.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );

Map<String, dynamic> _$DatastoreArrayValueToJson(
  DatastoreArrayValue instance,
) => <String, dynamic>{'values': instance.values};
