class EntityKey {
  final String project;
  final String? namespace;
  final String? database;
  final List<EntityKeyPath> path;

  EntityKey({
    required this.project,
    this.namespace,
    this.database,
    required this.path,
  });

  @override
  String toString() {
    final pathString = path.map((p) => '${p.kind}/${p.name}').join(',');
    return 'Key(project: $project, namespace: $namespace, database: $database, path: $pathString)';
  }

  factory EntityKey.empty() {
    return EntityKey(project: '', namespace: null, database: null, path: []);
  }
}

class EntityKeyPath {
  final String kind;
  final String? name;

  EntityKeyPath({required this.kind, required this.name});
}
