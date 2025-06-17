import 'package:dalui/net/model/batch.dart';
import 'package:dalui/net/model/query.dart';
import 'package:dio/dio.dart';

class DatastoreClient {
  final _dio = Dio();
  final String _projId;

  DatastoreClient(String host, int port, String projectId)
    : _projId = projectId {
    _dio.options.baseUrl = 'http://$host:$port/v1/projects/';
  }

  Future<Iterable<EntityResult>> getKinds() async => runQuery("SELECT *");

  Future<Iterable<EntityResult>> getAllEntities(String kind) =>
      runQuery("SELECT * FROM $kind");

  Future<Iterable<EntityResult>> runQuery(String query) async {
    final rs = await _dio.post(
      '$_projId:runQuery',
      data: QueryRequest.def(query).toJson(),
    );
    final batch = BatchResponse.fromJson(rs.data);
    return batch.batch.entityResults ?? <EntityResult>[];
  }
}
