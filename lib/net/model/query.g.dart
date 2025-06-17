// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QueryRequest _$QueryRequestFromJson(Map<String, dynamic> json) => QueryRequest(
  databaseId: json['databaseId'] as String,
  gqlQuery: Query.fromJson(json['gqlQuery'] as Map<String, dynamic>),
);

Map<String, dynamic> _$QueryRequestToJson(QueryRequest instance) =>
    <String, dynamic>{
      'databaseId': instance.databaseId,
      'gqlQuery': instance.gqlQuery,
    };

Query _$QueryFromJson(Map<String, dynamic> json) =>
    Query(queryString: json['queryString'] as String)
      ..allowLiterals = json['allowLiterals'] as bool;

Map<String, dynamic> _$QueryToJson(Query instance) => <String, dynamic>{
  'queryString': instance.queryString,
  'allowLiterals': instance.allowLiterals,
};
