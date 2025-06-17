// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'batch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BatchResponse _$BatchResponseFromJson(Map<String, dynamic> json) =>
    BatchResponse(batch: Batch.fromJson(json['batch'] as Map<String, dynamic>));

Map<String, dynamic> _$BatchResponseToJson(BatchResponse instance) =>
    <String, dynamic>{'batch': instance.batch};

Batch _$BatchFromJson(Map<String, dynamic> json) => Batch(
  entityResultType: json['entityResultType'] as String?,
  endCursor: json['endCursor'] as String?,
  moreResults: json['moreResults'] as String?,
  readTime: json['readTime'] as String?,
  entityResults: (json['entityResults'] as List<dynamic>?)
      ?.map((e) => EntityResult.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$BatchToJson(Batch instance) => <String, dynamic>{
  'entityResultType': instance.entityResultType,
  'endCursor': instance.endCursor,
  'moreResults': instance.moreResults,
  'readTime': instance.readTime,
  'entityResults': instance.entityResults,
};

EntityResult _$EntityResultFromJson(Map<String, dynamic> json) => EntityResult(
  cursor: json['cursor'] as String?,
  version: json['version'] as String?,
  updateTime: json['updateTime'] as String?,
  createTime: json['createTime'] as String?,
  entity: ResponseEntity.fromJson(json['entity'] as Map<String, dynamic>),
);

Map<String, dynamic> _$EntityResultToJson(EntityResult instance) =>
    <String, dynamic>{
      'cursor': instance.cursor,
      'version': instance.version,
      'updateTime': instance.updateTime,
      'createTime': instance.createTime,
      'entity': instance.entity,
    };

ResponseEntity _$ResponseEntityFromJson(Map<String, dynamic> json) =>
    ResponseEntity(
      key: json['key'] == null
          ? null
          : Key.fromJson(json['key'] as Map<String, dynamic>),
      properties: (json['properties'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, PropertiesValue.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$ResponseEntityToJson(ResponseEntity instance) =>
    <String, dynamic>{'key': instance.key, 'properties': instance.properties};

Key _$KeyFromJson(Map<String, dynamic> json) => Key(
  partitionId: PartitionId.fromJson(
    json['partitionId'] as Map<String, dynamic>,
  ),
  path: (json['path'] as List<dynamic>)
      .map((e) => Path.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$KeyToJson(Key instance) => <String, dynamic>{
  'partitionId': instance.partitionId,
  'path': instance.path,
};

PartitionId _$PartitionIdFromJson(Map<String, dynamic> json) => PartitionId(
  projectId: json['projectId'] as String,
  namespaceId: json['namespaceId'] as String?,
  databaseId: json['databaseId'] as String?,
);

Map<String, dynamic> _$PartitionIdToJson(PartitionId instance) =>
    <String, dynamic>{
      'projectId': instance.projectId,
      'namespaceId': instance.namespaceId,
      'databaseId': instance.databaseId,
    };

Path _$PathFromJson(Map<String, dynamic> json) =>
    Path(kind: json['kind'] as String, name: json['name'] as String?);

Map<String, dynamic> _$PathToJson(Path instance) => <String, dynamic>{
  'kind': instance.kind,
  'name': instance.name,
};

PropertiesValue _$PropertiesValueFromJson(Map<String, dynamic> json) =>
    PropertiesValue(
      nullValue: json['nullValue'] as String?,
      stringValue: json['stringValue'] as String?,
      integerValue: json['integerValue'] as String?,
      doubleValue: (json['doubleValue'] as num?)?.toDouble(),
      booleanValue: json['booleanValue'] as bool?,
      timestampValue: json['timestampValue'] as String?,
      keyValue: json['keyValue'] == null
          ? null
          : Key.fromJson(json['keyValue'] as Map<String, dynamic>),
      blobValue: json['blobValue'] as String?,
      geoPointValue: json['geoPointValue'] == null
          ? null
          : LatLng.fromJson(json['geoPointValue'] as Map<String, dynamic>),
      entityValue: json['entityValue'] == null
          ? null
          : ResponseEntity.fromJson(
              json['entityValue'] as Map<String, dynamic>,
            ),
      arrayValue: json['arrayValue'] == null
          ? null
          : ArrayValue.fromJson(json['arrayValue'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PropertiesValueToJson(PropertiesValue instance) =>
    <String, dynamic>{
      'nullValue': instance.nullValue,
      'stringValue': instance.stringValue,
      'integerValue': instance.integerValue,
      'doubleValue': instance.doubleValue,
      'booleanValue': instance.booleanValue,
      'timestampValue': instance.timestampValue,
      'keyValue': instance.keyValue,
      'blobValue': instance.blobValue,
      'geoPointValue': instance.geoPointValue,
      'entityValue': instance.entityValue,
      'arrayValue': instance.arrayValue,
    };

LatLng _$LatLngFromJson(Map<String, dynamic> json) => LatLng(
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
);

Map<String, dynamic> _$LatLngToJson(LatLng instance) => <String, dynamic>{
  'latitude': instance.latitude,
  'longitude': instance.longitude,
};

ArrayValue _$ArrayValueFromJson(Map<String, dynamic> json) => ArrayValue(
  values: (json['values'] as List<dynamic>?)
      ?.map((e) => PropertiesValue.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ArrayValueToJson(ArrayValue instance) =>
    <String, dynamic>{'values': instance.values};
