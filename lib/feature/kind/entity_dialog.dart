import 'package:auto_route/auto_route.dart';
import 'package:dalui/dalui_config.dart';
import 'package:dalui/feature/kind/property_editor.dart';
import 'package:dalui/feature/kind/property_type_editor.dart';
import 'package:dalui/model/entity.dart';
import 'package:dalui/model/entity_key.dart';
import 'package:dalui/model/value.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EntityDialog extends StatefulWidget {
  final EntityKey? _initialKey;
  final Map<String, Value>? _initialProperties;
  final String? _kind;
  final bool _nested;
  final bool _isCreate;

  // Constructor that initializes the dialog with an optional Entity value.
  // If no value is provided, it will create a new Entity with an empty key
  // and properties.
  EntityDialog._({
    EntityKey? entityKey,
    Map<String, Value>? properties,
    String? kind,
    required bool nested,
    required bool isCreate,
  }) : _initialKey = entityKey,
       _initialProperties = properties,
       _nested = nested,
       _kind = kind,
       _isCreate = isCreate {
    // Kind cannot be null if isCreate is true.
    assert(
      !isCreate || (kind != null && kind.isNotEmpty),
      'Kind must be provided for creating a new entity.',
    );
  }

  @override
  State<EntityDialog> createState() => _EntityDialogState();
}

// This function shows the EntityDialog and returns the modified Entity
// if the user saves changes, or null if they cancel.
Future<Entity?> showEditEntityDialog(
  BuildContext context, {
  required Entity value,
  bool nested = false,
}) {
  return showDialog<Entity?>(
    context: context,
    builder: (context) => EntityDialog._(
      entityKey: value.key,
      properties: value.properties,
      nested: nested,
      isCreate: false,
    ),
  );
}

Future<Entity?> showCloneEntityDialog(
  BuildContext context, {
  required Entity value,
  required String kind,
  bool nested = false,
}) {
  return showDialog<Entity?>(
    context: context,
    builder: (context) => EntityDialog._(
      entityKey: value.key,
      properties: Map.from(value.properties),
      kind: kind,
      nested: nested,
      isCreate: true,
    ),
  );
}

Future<Entity?> showCreateEntityDialog(
  BuildContext context, {
  required String kind,
  bool nested = false,
}) {
  return showDialog<Entity?>(
    context: context,
    builder: (context) => EntityDialog._(
      entityKey: null,
      properties: null,
      kind: kind,
      nested: nested,
      isCreate: true,
    ),
  );
}

class _EntityDialogState extends State<EntityDialog> {
  final _scrollController = ScrollController();
  final TextEditingController _keyController = TextEditingController();
  final TextEditingController _pathController = TextEditingController();

  late EntityKey _entityKey;
  late final Map<String, Value> _properties;
  late final DaluiConfig config;

  @override
  void initState() {
    super.initState();
    config = context.read();
    _entityKey =
        widget._initialKey ?? EntityKey(project: config.projectId, path: []);
    _properties = widget._initialProperties ?? {};
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Entity Details"),
      content: Column(
        children: [
          if (widget._isCreate)
            TextField(
              controller: _pathController,
              decoration: const InputDecoration(labelText: 'New Entity Key'),
              onChanged: (newPath) {
                setState(() {
                  _entityKey = EntityKey(
                    project: config.projectId,
                    path: [EntityKeyPath(kind: widget._kind!, name: newPath)],
                  );
                });
              },
            ),
          Expanded(
            child: SelectionArea(
              child: Scrollbar(
                controller: _scrollController,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  controller: _scrollController,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: DataTable(
                      columns: [
                        const DataColumn(label: Text('key')),
                        const DataColumn(label: Text('type')),
                        const DataColumn(label: Text('value')),
                        const DataColumn(label: Text('actions')),
                      ],
                      rows: _properties
                          .map((key, val) {
                            return MapEntry(key, _buildPropertyRow(key, val));
                          })
                          .values
                          .nonNulls
                          .toList(),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _keyController,
                  decoration: const InputDecoration(labelText: 'Property Key'),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _properties[_keyController.text] = Value.emptyValueOfType(
                      ValueType.string,
                      config.projectId,
                    );
                  });
                  _keyController.clear();
                },
                child: const Text('Add Property'),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => context.router.pop(null),
          child: const Text('Close'),
        ),
        // TODO: Do not allow saving nested entities for now.
        if (!widget._nested)
          TextButton(
            onPressed: () => context.router.pop(
              Entity(key: _entityKey, properties: Map.from(_properties)),
            ),
            child: const Text('Save'),
          ),
      ],
    );
  }

  DataRow? _buildPropertyRow(String key, Value? val) {
    if (val == null) {
      // If the value is null, we don't display it, although this should
      // not happen in practice since properties should always have values.
      return null;
    }
    return DataRow(
      cells: [
        DataCell(Text(key)),
        DataCell(
          PropertyTypeEditor(
            propertyKey: key,
            value: val,
            onTypeChanged: (propertyKey, newValue) {
              setState(() {
                _properties[propertyKey] = newValue;
              });
            },
          ),
        ),
        DataCell(
          PropertyEditor(
            propertyKey: key,
            value: val,
            onValueChanged: (propertyKey, newValue) {
              setState(() {
                _properties[propertyKey] = newValue;
              });
            },
          ),
        ),
        DataCell(
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _removeProperty(key);
            },
          ),
        ),
      ],
    );
  }

  void _removeProperty(String key) {
    setState(() {
      _properties.remove(key);
    });
  }
}
