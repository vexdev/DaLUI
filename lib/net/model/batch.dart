import 'package:json_annotation/json_annotation.dart';

part 'batch.g.dart';

@JsonSerializable()
class BatchResponse {
  final Batch batch;

  BatchResponse({required this.batch});

  factory BatchResponse.fromJson(Map<String, dynamic> json) =>
      _$BatchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BatchResponseToJson(this);
}

@JsonSerializable()
class Batch {
  final String? entityResultType;
  final String? endCursor;
  final String? moreResults;
  final String? readTime;
  final List<EntityResult>? entityResults;

  Batch({
    this.entityResultType,
    this.endCursor,
    this.moreResults,
    this.readTime,
    this.entityResults,
  });

  factory Batch.fromJson(Map<String, dynamic> json) => _$BatchFromJson(json);
  Map<String, dynamic> toJson() => _$BatchToJson(this);
}

@JsonSerializable()
class EntityResult {
  final String? cursor;
  final String? version;
  final String? updateTime;
  final String? createTime;
  final ResponseEntity entity;

  EntityResult({
    this.cursor,
    this.version,
    this.updateTime,
    this.createTime,
    required this.entity,
  });
  factory EntityResult.fromJson(Map<String, dynamic> json) =>
      _$EntityResultFromJson(json);
  Map<String, dynamic> toJson() => _$EntityResultToJson(this);
}

@JsonSerializable()
class ResponseEntity {
  final Key? key;
  final Map<String, PropertiesValue> properties;

  ResponseEntity({required this.key, required this.properties});
  factory ResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$ResponseEntityFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseEntityToJson(this);
}

@JsonSerializable()
class Key {
  final PartitionId partitionId;
  final List<Path> path;

  Key({required this.partitionId, required this.path});

  factory Key.fromJson(Map<String, dynamic> json) => _$KeyFromJson(json);
  Map<String, dynamic> toJson() => _$KeyToJson(this);
}

@JsonSerializable()
class PartitionId {
  final String projectId;
  final String? namespaceId;
  final String? databaseId;

  PartitionId({required this.projectId, this.namespaceId, this.databaseId});
  factory PartitionId.fromJson(Map<String, dynamic> json) =>
      _$PartitionIdFromJson(json);
  Map<String, dynamic> toJson() => _$PartitionIdToJson(this);
}

@JsonSerializable()
class Path {
  final String kind;
  final String? name;

  Path({required this.kind, required this.name});

  factory Path.fromJson(Map<String, dynamic> json) => _$PathFromJson(json);
  Map<String, dynamic> toJson() => _$PathToJson(this);
}

@JsonSerializable()
class PropertiesValue {
  final String? nullValue;
  final String? stringValue;
  final String? integerValue;
  final double? doubleValue;
  final bool? booleanValue;
  final String? timestampValue;
  final Key? keyValue;
  final String? blobValue;
  final LatLng? geoPointValue;
  final ResponseEntity? entityValue;
  final ArrayValue? arrayValue;

  PropertiesValue({
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

  factory PropertiesValue.fromJson(Map<String, dynamic> json) =>
      _$PropertiesValueFromJson(json);

  Map<String, dynamic> toJson() => _$PropertiesValueToJson(this);
}

@JsonSerializable()
class LatLng {
  final double latitude;
  final double longitude;

  LatLng({required this.latitude, required this.longitude});

  factory LatLng.fromJson(Map<String, dynamic> json) => _$LatLngFromJson(json);
  Map<String, dynamic> toJson() => _$LatLngToJson(this);
}

@JsonSerializable()
class ArrayValue {
  final List<PropertiesValue>? values;

  ArrayValue({required this.values});

  factory ArrayValue.fromJson(Map<String, dynamic> json) =>
      _$ArrayValueFromJson(json);
  Map<String, dynamic> toJson() => _$ArrayValueToJson(this);
}
