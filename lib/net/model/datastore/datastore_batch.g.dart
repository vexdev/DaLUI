// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datastore_batch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DatastoreBatchResponse _$DatastoreBatchResponseFromJson(
  Map<String, dynamic> json,
) => DatastoreBatchResponse(
  batch: DatastoreBatch.fromJson(json['batch'] as Map<String, dynamic>),
);

Map<String, dynamic> _$DatastoreBatchResponseToJson(
  DatastoreBatchResponse instance,
) => <String, dynamic>{'batch': instance.batch};

DatastoreBatch _$DatastoreBatchFromJson(Map<String, dynamic> json) =>
    DatastoreBatch(
      entityResultType: json['entityResultType'] as String?,
      endCursor: json['endCursor'] as String?,
      moreResults: json['moreResults'] as String?,
      readTime: json['readTime'] as String?,
      entityResults: (json['entityResults'] as List<dynamic>?)
          ?.map(
            (e) => DatastoreEntityResult.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );

Map<String, dynamic> _$DatastoreBatchToJson(DatastoreBatch instance) =>
    <String, dynamic>{
      'entityResultType': instance.entityResultType,
      'endCursor': instance.endCursor,
      'moreResults': instance.moreResults,
      'readTime': instance.readTime,
      'entityResults': instance.entityResults,
    };

DatastoreEntityResult _$DatastoreEntityResultFromJson(
  Map<String, dynamic> json,
) => DatastoreEntityResult(
  cursor: json['cursor'] as String?,
  version: json['version'] as String?,
  updateTime: json['updateTime'] as String?,
  createTime: json['createTime'] as String?,
  entity: DatastoreEntity.fromJson(json['entity'] as Map<String, dynamic>),
);

Map<String, dynamic> _$DatastoreEntityResultToJson(
  DatastoreEntityResult instance,
) => <String, dynamic>{
  'cursor': instance.cursor,
  'version': instance.version,
  'updateTime': instance.updateTime,
  'createTime': instance.createTime,
  'entity': instance.entity,
};
