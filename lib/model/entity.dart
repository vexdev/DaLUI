import 'package:dalui/model/entity_key.dart';
import 'package:dalui/model/value.dart';

class Entity {
  final EntityKey? key;
  final Map<String, Value> properties;

  Entity({required this.key, required this.properties});
}
