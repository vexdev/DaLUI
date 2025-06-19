import 'package:dalui/model/entity.dart';

class KindState {
  final List<String> kinds;
  final List<Entity> entities;
  final String? selectedKind;
  final Set<String> columns;
  final String? error;
  final bool isLoading;

  KindState({
    required this.kinds,
    this.selectedKind,
    this.entities = const [],
    this.error,
    this.isLoading = false,
  }) : columns = getColumns(entities);

  static KindState initial() {
    return KindState(kinds: [], isLoading: true);
  }

  static KindState empty() {
    return KindState(kinds: [], entities: [], isLoading: false);
  }

  static Set<String> getColumns(List<Entity> entities) {
    if (entities.isEmpty) return {};
    return entities.expand((entity) => entity.properties.keys).toSet();
  }
}
