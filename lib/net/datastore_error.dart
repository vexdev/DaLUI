import 'package:json_annotation/json_annotation.dart';

part 'datastore_error.g.dart';

@JsonSerializable()
class DatastoreErrorContainer {
  final DatastoreError? error;

  DatastoreErrorContainer({this.error});

  factory DatastoreErrorContainer.fromJson(Map<String, dynamic> json) =>
      _$DatastoreErrorContainerFromJson(json);

  Map<String, dynamic> toJson() => _$DatastoreErrorContainerToJson(this);
}

@JsonSerializable()
class DatastoreError {
  final int? code;
  final String? message;
  final String? status;

  DatastoreError({this.code, this.message, this.status});

  factory DatastoreError.fromJson(Map<String, dynamic> json) =>
      _$DatastoreErrorFromJson(json);

  Map<String, dynamic> toJson() => _$DatastoreErrorToJson(this);
}
