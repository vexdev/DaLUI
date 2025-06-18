import 'package:dalui/net/model/datastore/datastore_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'datastore_batch.g.dart';

@JsonSerializable()
class DatastoreBatchResponse {
  final DatastoreBatch batch;

  DatastoreBatchResponse({required this.batch});

  factory DatastoreBatchResponse.fromJson(Map<String, dynamic> json) =>
      _$DatastoreBatchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DatastoreBatchResponseToJson(this);
}

@JsonSerializable()
class DatastoreBatch {
  final String? entityResultType;
  final String? endCursor;
  final String? moreResults;
  final String? readTime;
  final List<DatastoreEntityResult>? entityResults;

  DatastoreBatch({
    this.entityResultType,
    this.endCursor,
    this.moreResults,
    this.readTime,
    this.entityResults,
  });

  factory DatastoreBatch.fromJson(Map<String, dynamic> json) =>
      _$DatastoreBatchFromJson(json);
  Map<String, dynamic> toJson() => _$DatastoreBatchToJson(this);
}

@JsonSerializable()
class DatastoreEntityResult {
  final String? cursor;
  final String? version;
  final String? updateTime;
  final String? createTime;
  final DatastoreEntity entity;

  DatastoreEntityResult({
    this.cursor,
    this.version,
    this.updateTime,
    this.createTime,
    required this.entity,
  });
  factory DatastoreEntityResult.fromJson(Map<String, dynamic> json) =>
      _$DatastoreEntityResultFromJson(json);
  Map<String, dynamic> toJson() => _$DatastoreEntityResultToJson(this);
}
