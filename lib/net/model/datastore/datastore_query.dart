import 'package:json_annotation/json_annotation.dart';

part 'datastore_query.g.dart';

@JsonSerializable()
class DatastoreQueryRequest {
  String databaseId;
  DatastoreQuery gqlQuery;

  DatastoreQueryRequest({required this.databaseId, required this.gqlQuery});

  DatastoreQueryRequest.def(String gqlQuery)
    : databaseId = '',
      gqlQuery = DatastoreQuery(queryString: gqlQuery);

  factory DatastoreQueryRequest.fromJson(Map<String, dynamic> json) =>
      _$DatastoreQueryRequestFromJson(json);
  Map<String, dynamic> toJson() => _$DatastoreQueryRequestToJson(this);
}

@JsonSerializable()
class DatastoreQuery {
  String queryString;
  bool allowLiterals = true;

  DatastoreQuery({required this.queryString});
  factory DatastoreQuery.fromJson(Map<String, dynamic> json) =>
      _$DatastoreQueryFromJson(json);
  Map<String, dynamic> toJson() => _$DatastoreQueryToJson(this);
}
