import 'package:dalui/net/model/datastore/datastore_batch.dart';
import 'package:dalui/net/model/datastore/datastore_commit.dart';
import 'package:dalui/net/model/datastore/datastore_query.dart';
import 'package:dio/dio.dart';

class DatastoreClient {
  final _dio = Dio();
  final String _projId;

  DatastoreClient(String host, int port, String projectId)
    : _projId = projectId {
    _dio.options.baseUrl = 'http://$host:$port/v1/projects/';
  }

  Future<Iterable<DatastoreEntityResult>> getKinds() async =>
      runQuery("SELECT *");

  Future<Iterable<DatastoreEntityResult>> getAllEntities(String kind) =>
      runQuery("SELECT * FROM $kind");

  Future<Iterable<DatastoreEntityResult>> runQuery(String query) async {
    final rs = await _dio.post(
      '$_projId:runQuery',
      data: DatastoreQueryRequest.def(query).toJson(),
    );
    final batch = DatastoreBatchResponse.fromJson(rs.data);
    return batch.batch.entityResults ?? <DatastoreEntityResult>[];
  }

  Future<void> commit(DatastoreCommit commit) async {
    await _dio.post('$_projId:commit', data: commit.toJson());
  }
}
