import 'package:json_annotation/json_annotation.dart';

part 'datastore_key.g.dart';

@JsonSerializable()
class DatastoreKey {
  final DatastorePartitionId partitionId;
  final List<DatastorePath> path;

  DatastoreKey({required this.partitionId, required this.path});

  factory DatastoreKey.fromJson(Map<String, dynamic> json) =>
      _$DatastoreKeyFromJson(json);
  Map<String, dynamic> toJson() => _$DatastoreKeyToJson(this);
}

@JsonSerializable()
class DatastorePartitionId {
  final String projectId;
  final String? namespaceId;
  final String? databaseId;

  DatastorePartitionId({
    required this.projectId,
    this.namespaceId,
    this.databaseId,
  });
  factory DatastorePartitionId.fromJson(Map<String, dynamic> json) =>
      _$DatastorePartitionIdFromJson(json);
  Map<String, dynamic> toJson() => _$DatastorePartitionIdToJson(this);
}

@JsonSerializable()
class DatastorePath {
  final String kind;
  final String? name;

  DatastorePath({required this.kind, required this.name});

  factory DatastorePath.fromJson(Map<String, dynamic> json) =>
      _$DatastorePathFromJson(json);
  Map<String, dynamic> toJson() => _$DatastorePathToJson(this);
}
