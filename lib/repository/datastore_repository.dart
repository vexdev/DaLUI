import 'package:dalui/model/entity.dart';
import 'package:dalui/model/entity_key.dart';
import 'package:dalui/model/value.dart';
import 'package:dalui/net/datastore_client.dart';
import 'package:dalui/net/model/datastore/datastore_commit.dart';
import 'package:dalui/net/model/datastore/datastore_entity.dart';
import 'package:dalui/net/model/datastore/datastore_key.dart';

class DatastoreRepository {
  final DatastoreClient _datastoreClient;

  DatastoreRepository(this._datastoreClient);

  Future<Set<String>> getKinds() async {
    final allEntries = await _datastoreClient.getKinds();
    return allEntries
        .where((er) => er.entity.key != null)
        .expand((er) => er.entity.key!.path)
        .map((path) => path.kind)
        .toSet();
  }

  Future<Iterable<Entity>> getAllEntities(String kind) async {
    final allEntries = await _datastoreClient.getAllEntities(kind);
    return allEntries.map((entityResult) => entityResult.entity.entity);
  }

  Future<Iterable<Entity>> query(String gql) async {
    final allEntries = await _datastoreClient.runQuery(gql);
    return allEntries.map((entityResult) => entityResult.entity.entity);
  }

  Future<void> delete(Iterable<EntityKey> entities) async {
    final deleteCommit = entities.map(
      (key) => DatastoreMutation(delete: key.datastoreKey),
    );
    await _datastoreClient.commit(
      DatastoreCommit(mutations: deleteCommit.toList()),
    );
  }
}

extension on DatastoreKey {
  EntityKey get entityKey => EntityKey(
    project: partitionId.projectId,
    namespace: partitionId.namespaceId,
    database: partitionId.databaseId,
    path: path
        .map((path) => EntityKeyPath(kind: path.kind, name: path.name))
        .toList(),
  );
}

extension on EntityKey {
  DatastoreKey get datastoreKey => DatastoreKey(
    partitionId: DatastorePartitionId(
      projectId: project,
      namespaceId: namespace,
      databaseId: database,
    ),
    path: path
        .map((path) => DatastorePath(kind: path.kind, name: path.name))
        .toList(),
  );
}

extension on DatastoreEntity {
  Entity get entity => Entity(
    key: key?.entityKey,
    properties: properties.map((key, value) => MapEntry(key, value.value)),
  );
}

extension on DatastorePropertiesValue {
  Value get value {
    if (stringValue != null) {
      return ValueString(stringValue!);
    } else if (integerValue != null) {
      return ValueInt(int.tryParse(integerValue!)!);
    } else if (doubleValue != null) {
      return ValueDouble(doubleValue!);
    } else if (booleanValue != null) {
      return ValueBool(booleanValue!);
    } else if (timestampValue != null) {
      // Parse from RFC 3339
      final timestamp = DateTime.tryParse(timestampValue!);
      return ValueTimestamp(timestamp!);
    } else if (keyValue != null) {
      return ValueKey(keyValue!.entityKey);
    } else if (blobValue != null) {
      return ValueBlob(blobValue!);
    } else if (geoPointValue != null) {
      return ValueGeoPoint(geoPointValue!.latitude, geoPointValue!.longitude);
    } else if (entityValue != null) {
      return ValueEntity(entityValue!.entity);
    } else if (arrayValue != null) {
      return ValueArray(
        arrayValue!.values?.map((val) => val.value).toList() ?? [],
      );
    }
    return ValueNull();
  }
}
