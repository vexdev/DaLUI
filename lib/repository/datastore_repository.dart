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

  Future<void> update(Entity oldEntity, Entity updatedEntity) async {
    await _datastoreClient.commit(
      DatastoreCommit(
        mutations: [
          DatastoreMutation(
            propertyMask: DatastorePropertyMask(
              paths: oldEntity.properties.keys
                  .followedBy(updatedEntity.properties.keys)
                  .toSet()
                  .toList(),
            ),
            update: updatedEntity.datastoreEntity,
          ),
        ],
      ),
    );
  }

  Future<void> insert(Iterable<Entity> entities) async {
    final insertCommit = entities.map(
      (entity) => DatastoreMutation(
        propertyMask: DatastorePropertyMask(
          paths: entity.properties.keys.toList(),
        ),
        insert: entity.datastoreEntity,
      ),
    );
    await _datastoreClient.commit(
      DatastoreCommit(mutations: insertCommit.toList()),
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
    properties:
        properties?.map(
          (key, value) => value is DatastorePropertiesValue
              ? MapEntry(key, value.value)
              : MapEntry(key, ValueNull()),
        ) ??
        <String, Value>{},
  );
}

extension on Entity {
  DatastoreEntity get datastoreEntity => DatastoreEntity(
    key: key?.datastoreKey,
    properties: properties.map(
      (key, value) => MapEntry(key, value.datastoreValue),
    ),
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
        arrayValue!.values
                ?.map(
                  (val) =>
                      val is DatastorePropertiesValue ? val.value : ValueNull(),
                )
                .toList() ??
            [],
      );
    }
    return ValueNull();
  }
}

extension on Value {
  DatastorePropertiesVal get datastoreValue {
    if (this is ValueString) {
      return DatastorePropertiesValue(stringValue: (this as ValueString).value);
    } else if (this is ValueInt) {
      return DatastorePropertiesValue(
        integerValue: (this as ValueInt).value.toString(),
      );
    } else if (this is ValueDouble) {
      return DatastorePropertiesValue(doubleValue: (this as ValueDouble).value);
    } else if (this is ValueBool) {
      return DatastorePropertiesValue(booleanValue: (this as ValueBool).value);
    } else if (this is ValueTimestamp) {
      return DatastorePropertiesValue(
        timestampValue: (this as ValueTimestamp).value.toIso8601String(),
      );
    } else if (this is ValueKey) {
      return DatastorePropertiesValue(
        keyValue: (this as ValueKey).value.datastoreKey,
      );
    } else if (this is ValueBlob) {
      return DatastorePropertiesValue(blobValue: (this as ValueBlob).value);
    } else if (this is ValueGeoPoint) {
      final geo = this as ValueGeoPoint;
      return DatastorePropertiesValue(
        geoPointValue: DatastoreLatLng(
          latitude: geo.latitude,
          longitude: geo.longitude,
        ),
      );
    } else if (this is ValueEntity) {
      return DatastorePropertiesValue(
        entityValue: (this as ValueEntity).entity.datastoreEntity,
      );
    } else if (this is ValueArray) {
      final array = this as ValueArray;
      return DatastorePropertiesValue(
        arrayValue: DatastoreArrayValue(
          values: array.values.map((v) => v.datastoreValue).toList(),
        ),
      );
    }
    return DatastorePropertiesNullValue();
  }
}
