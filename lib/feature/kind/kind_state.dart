import 'package:dalui/model/entity.dart';

class KindState {
  final List<String> kinds;
  final List<Entity> entities;
  final String? selectedKind;
  final Set<String> columns;
  final String? error;

  KindState({
    required this.kinds,
    this.selectedKind,
    this.entities = const [],
    this.error,
  }) : columns = getColumns(entities);

  static KindState initial() {
    return KindState(kinds: []);
  }

  static Set<String> getColumns(List<Entity> entities) {
    if (entities.isEmpty) return {};
    return entities.expand((entity) => entity.properties.keys).toSet();
  }
}
