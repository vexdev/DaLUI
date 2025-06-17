import 'package:json_annotation/json_annotation.dart';

part 'query.g.dart';

@JsonSerializable()
class QueryRequest {
  String databaseId;
  Query gqlQuery;

  QueryRequest({required this.databaseId, required this.gqlQuery});

  QueryRequest.def(String gqlQuery)
    : databaseId = '',
      gqlQuery = Query(queryString: gqlQuery);

  factory QueryRequest.fromJson(Map<String, dynamic> json) =>
      _$QueryRequestFromJson(json);
  Map<String, dynamic> toJson() => _$QueryRequestToJson(this);
}

@JsonSerializable()
class Query {
  String queryString;
  bool allowLiterals = true;

  Query({required this.queryString});
  factory Query.fromJson(Map<String, dynamic> json) => _$QueryFromJson(json);
  Map<String, dynamic> toJson() => _$QueryToJson(this);
}
