// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datastore_query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DatastoreQueryRequest _$DatastoreQueryRequestFromJson(
  Map<String, dynamic> json,
) => DatastoreQueryRequest(
  databaseId: json['databaseId'] as String,
  gqlQuery: DatastoreQuery.fromJson(json['gqlQuery'] as Map<String, dynamic>),
);

Map<String, dynamic> _$DatastoreQueryRequestToJson(
  DatastoreQueryRequest instance,
) => <String, dynamic>{
  'databaseId': instance.databaseId,
  'gqlQuery': instance.gqlQuery,
};

DatastoreQuery _$DatastoreQueryFromJson(Map<String, dynamic> json) =>
    DatastoreQuery(queryString: json['queryString'] as String)
      ..allowLiterals = json['allowLiterals'] as bool;

Map<String, dynamic> _$DatastoreQueryToJson(DatastoreQuery instance) =>
    <String, dynamic>{
      'queryString': instance.queryString,
      'allowLiterals': instance.allowLiterals,
    };
