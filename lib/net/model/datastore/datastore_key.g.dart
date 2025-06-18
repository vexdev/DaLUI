// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datastore_key.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DatastoreKey _$DatastoreKeyFromJson(Map<String, dynamic> json) => DatastoreKey(
  partitionId: DatastorePartitionId.fromJson(
    json['partitionId'] as Map<String, dynamic>,
  ),
  path: (json['path'] as List<dynamic>)
      .map((e) => DatastorePath.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$DatastoreKeyToJson(DatastoreKey instance) =>
    <String, dynamic>{
      'partitionId': instance.partitionId,
      'path': instance.path,
    };

DatastorePartitionId _$DatastorePartitionIdFromJson(
  Map<String, dynamic> json,
) => DatastorePartitionId(
  projectId: json['projectId'] as String,
  namespaceId: json['namespaceId'] as String?,
  databaseId: json['databaseId'] as String?,
);

Map<String, dynamic> _$DatastorePartitionIdToJson(
  DatastorePartitionId instance,
) => <String, dynamic>{
  'projectId': instance.projectId,
  'namespaceId': instance.namespaceId,
  'databaseId': instance.databaseId,
};

DatastorePath _$DatastorePathFromJson(Map<String, dynamic> json) =>
    DatastorePath(kind: json['kind'] as String, name: json['name'] as String?);

Map<String, dynamic> _$DatastorePathToJson(DatastorePath instance) =>
    <String, dynamic>{'kind': instance.kind, 'name': instance.name};
