import 'package:dalui/net/model/datastore/datastore_entity.dart';
import 'package:dalui/net/model/datastore/datastore_key.dart';
import 'package:json_annotation/json_annotation.dart';

part 'datastore_commit.g.dart';

@JsonSerializable()
class DatastoreCommit {
  final String databaseId;
  final List<DatastoreMutation> mutations;
  final String? mode;

  DatastoreCommit({
    this.databaseId = '',
    required this.mutations,
    this.mode = "NON_TRANSACTIONAL",
  });

  factory DatastoreCommit.fromJson(Map<String, dynamic> json) =>
      _$DatastoreCommitFromJson(json);

  Map<String, dynamic> toJson() => _$DatastoreCommitToJson(this);
}

// A mutation to apply to an entity.
@JsonSerializable(includeIfNull: false)
class DatastoreMutation {
  final DatastorePropertyMask? propertyMask;

  // One of the following mutation types must be set.
  final DatastoreEntity? insert;
  final DatastoreEntity? update;
  final DatastoreEntity? upsert;
  final DatastoreKey? delete;

  DatastoreMutation({
    this.propertyMask = const DatastorePropertyMask(),
    this.insert,
    this.update,
    this.upsert,
    this.delete,
  });

  factory DatastoreMutation.fromJson(Map<String, dynamic> json) =>
      _$DatastoreMutationFromJson(json);

  Map<String, dynamic> toJson() => _$DatastoreMutationToJson(this);
}

// The set of arbitrarily nested property paths used to restrict an operation
// to only a subset of properties in an entity.
@JsonSerializable()
class DatastorePropertyMask {
  // The paths to the properties covered by this mask.
  // A path is a list of property names separated by dots (.), for example
  // foo.bar means the property bar inside the entity property foo inside the
  // entity associated with this path.
  // If a property name contains a dot . or a backslash \, then that name must
  // be escaped.
  // A path must not be empty, and may not reference a value inside an array
  // value.
  final List<String> paths;

  const DatastorePropertyMask({this.paths = const []});

  factory DatastorePropertyMask.fromJson(Map<String, dynamic> json) =>
      _$DatastorePropertyMaskFromJson(json);

  Map<String, dynamic> toJson() => _$DatastorePropertyMaskToJson(this);
}
