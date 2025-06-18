// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datastore_commit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DatastoreCommit _$DatastoreCommitFromJson(Map<String, dynamic> json) =>
    DatastoreCommit(
      databaseId: json['databaseId'] as String? ?? '',
      mutations: (json['mutations'] as List<dynamic>)
          .map((e) => DatastoreMutation.fromJson(e as Map<String, dynamic>))
          .toList(),
      mode: json['mode'] as String? ?? "NON_TRANSACTIONAL",
    );

Map<String, dynamic> _$DatastoreCommitToJson(DatastoreCommit instance) =>
    <String, dynamic>{
      'databaseId': instance.databaseId,
      'mutations': instance.mutations,
      'mode': instance.mode,
    };

DatastoreMutation _$DatastoreMutationFromJson(Map<String, dynamic> json) =>
    DatastoreMutation(
      propertyMask: json['propertyMask'] == null
          ? const DatastorePropertyMask()
          : DatastorePropertyMask.fromJson(
              json['propertyMask'] as Map<String, dynamic>,
            ),
      insert: json['insert'] == null
          ? null
          : DatastoreEntity.fromJson(json['insert'] as Map<String, dynamic>),
      update: json['update'] == null
          ? null
          : DatastoreEntity.fromJson(json['update'] as Map<String, dynamic>),
      upsert: json['upsert'] == null
          ? null
          : DatastoreEntity.fromJson(json['upsert'] as Map<String, dynamic>),
      delete: json['delete'] == null
          ? null
          : DatastoreKey.fromJson(json['delete'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DatastoreMutationToJson(DatastoreMutation instance) =>
    <String, dynamic>{
      'propertyMask': instance.propertyMask,
      'insert': instance.insert,
      'update': instance.update,
      'upsert': instance.upsert,
      'delete': instance.delete,
    };

DatastorePropertyMask _$DatastorePropertyMaskFromJson(
  Map<String, dynamic> json,
) => DatastorePropertyMask(
  paths:
      (json['paths'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
);

Map<String, dynamic> _$DatastorePropertyMaskToJson(
  DatastorePropertyMask instance,
) => <String, dynamic>{'paths': instance.paths};
