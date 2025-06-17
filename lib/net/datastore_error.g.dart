// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datastore_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DatastoreErrorContainer _$DatastoreErrorContainerFromJson(
  Map<String, dynamic> json,
) => DatastoreErrorContainer(
  error: json['error'] == null
      ? null
      : DatastoreError.fromJson(json['error'] as Map<String, dynamic>),
);

Map<String, dynamic> _$DatastoreErrorContainerToJson(
  DatastoreErrorContainer instance,
) => <String, dynamic>{'error': instance.error};

DatastoreError _$DatastoreErrorFromJson(Map<String, dynamic> json) =>
    DatastoreError(
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$DatastoreErrorToJson(DatastoreError instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'status': instance.status,
    };
