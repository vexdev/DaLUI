import 'package:dalui/model/entity.dart';
import 'package:dalui/model/entity_key.dart';

abstract class Value {
  String get readable;
  ValueType get type;
}

class ValueNull implements Value {
  const ValueNull();
  @override
  String get readable => 'null';
  @override
  ValueType get type => ValueType.nullValue;
}

class ValueString implements Value {
  final String value;

  @override
  String get readable => value;

  @override
  ValueType get type => ValueType.string;

  ValueString(this.value);
}

class ValueInt implements Value {
  final int value;

  @override
  String get readable => value.toString();

  @override
  ValueType get type => ValueType.int;

  ValueInt(this.value);
}

class ValueDouble implements Value {
  final double value;

  @override
  String get readable => value.toString();

  @override
  ValueType get type => ValueType.double;

  ValueDouble(this.value);
}

class ValueBool implements Value {
  final bool value;

  @override
  String get readable => value.toString();

  @override
  ValueType get type => ValueType.bool;

  ValueBool(this.value);
}

class ValueTimestamp implements Value {
  final DateTime value;

  @override
  String get readable => value.toIso8601String();

  @override
  ValueType get type => ValueType.timestamp;

  ValueTimestamp(this.value);
}

class ValueKey implements Value {
  final EntityKey value;

  @override
  String get readable => value.toString();

  @override
  ValueType get type => ValueType.key;

  @override
  ValueKey(this.value);
}

class ValueBlob implements Value {
  final String value;

  @override
  String get readable => 'Blob(${value.length} bytes)';

  @override
  ValueType get type => ValueType.blob;

  ValueBlob(this.value);
}

class ValueGeoPoint implements Value {
  final double latitude;
  final double longitude;

  @override
  String get readable => 'GeoPoint($latitude, $longitude)';

  @override
  ValueType get type => ValueType.geoPoint;

  ValueGeoPoint(this.latitude, this.longitude);
}

class ValueEntity implements Value {
  final Entity entity;

  @override
  String get readable => 'Entity(${entity.key})';

  @override
  ValueType get type => ValueType.entity;

  ValueEntity(this.entity);
}

class ValueArray implements Value {
  final List<Value> values;

  @override
  String get readable => '[${values.map((v) => v.readable).join(', ')}]';

  @override
  ValueType get type => ValueType.array;

  ValueArray(this.values);
}

enum ValueType {
  nullValue,
  string,
  int,
  double,
  bool,
  timestamp,
  key,
  blob,
  geoPoint,
  entity,
  array,
}
