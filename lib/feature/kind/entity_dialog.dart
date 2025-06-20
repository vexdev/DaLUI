import 'package:auto_route/auto_route.dart';
import 'package:dalui/feature/kind/entity_button.dart';
import 'package:dalui/model/entity.dart';
import 'package:dalui/model/value.dart';
import 'package:flutter/material.dart';

class EntityDialog extends StatefulWidget {
  final Entity _initialValue;

  const EntityDialog({super.key, required Entity value})
    : _initialValue = value;

  @override
  State<EntityDialog> createState() => _EntityDialogState();
}

// This function shows the EntityDialog and returns the modified Entity
// if the user saves changes, or null if they cancel.
Future<Entity?> showEntityDialog(
  BuildContext context, {
  required Entity value,
}) {
  return showDialog<Entity?>(
    context: context,
    builder: (context) => EntityDialog(value: value),
  );
}

class _EntityDialogState extends State<EntityDialog> {
  late Entity _entity;
  final _scrollController = ScrollController();
  final Map<String, TextEditingController> _textControllers = {};
  final TextEditingController _keyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _entity = widget._initialValue;
  }

  @override
  Widget build(BuildContext context) {
    final props = _entity.properties;
    return AlertDialog(
      title: Text("Entity Details"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SelectionArea(
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
                    rows: props.keys
                        .map((key) {
                          final val = props[key];
                          return _buildPropertyRow(key, val);
                        })
                        .nonNulls
                        .toList(),
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
                  decoration: const InputDecoration(labelText: 'Entity Key'),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _entity = Entity(
                      key: _entity.key,
                      properties: Map.from(_entity.properties)
                        ..[_keyController.text] = Value.emptyValueOfType(
                          ValueType.string,
                        ),
                    );
                  });
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
        if (_entity.key != null)
          TextButton(
            onPressed: () => context.router.pop(_entity),
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
        DataCell(_buildPropertyType(key, val)),
        DataCell(_buildPropertyValue(key, val)),
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
      _entity = Entity(
        key: _entity.key,
        properties: Map.from(_entity.properties)..remove(key),
      );
    });
  }

  Widget _buildPropertyValue(String key, Value value) {
    switch (value.type) {
      case ValueType.string:
        return TextField(
          controller: _textControllers.putIfAbsent(
            key,
            () => TextEditingController(text: value.readable),
          ),
          onChanged: (newValue) {
            setState(() {
              _entity = Entity(
                key: _entity.key,
                properties: Map.from(_entity.properties)
                  ..[key] = ValueString(newValue),
              );
            });
          },
        );
      case ValueType.int:
        return TextField(
          controller: _textControllers.putIfAbsent(
            key,
            () => TextEditingController(text: value.readable),
          ),
          keyboardType: TextInputType.number,
          onChanged: (newValue) {
            setState(() {
              _entity = Entity(
                key: _entity.key,
                properties: Map.from(_entity.properties)
                  ..[key] = ValueInt(int.tryParse(newValue) ?? 0),
              );
            });
          },
        );
      case ValueType.double:
        return TextField(
          controller: _textControllers.putIfAbsent(
            key,
            () => TextEditingController(text: value.readable),
          ),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          onChanged: (newValue) {
            setState(() {
              _entity = Entity(
                key: _entity.key,
                properties: Map.from(_entity.properties)
                  ..[key] = ValueDouble(double.tryParse(newValue) ?? 0.0),
              );
            });
          },
        );
      case ValueType.bool:
        return Switch(
          value: value.readable.toLowerCase() == 'true',
          onChanged: (newValue) {
            setState(() {
              _entity = Entity(
                key: _entity.key,
                properties: Map.from(_entity.properties)
                  ..[key] = ValueBool(newValue),
              );
            });
          },
        );
      case ValueType.nullValue:
        return const Text('null');
      case ValueType.entity:
        return EntityButton(
          value: (value as ValueEntity).entity,
          onEntitySave: (future) async {
            final updated = await future;
            if (updated != null) {
              setState(() {
                _entity = Entity(
                  key: _entity.key,
                  properties: Map.from(_entity.properties)
                    ..[key] = ValueEntity(updated),
                );
              });
            }
          },
        );
      default:
        return Text(value.readable);
    }
  }

  DropdownButtonHideUnderline _buildPropertyType(String key, Value value) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<ValueType>(
        value: value.type,
        items: ValueType.values.map((type) {
          return DropdownMenuItem<ValueType>(
            value: type,
            child: Text(type.name),
          );
        }).toList(),
        onChanged: (newType) {
          if (newType != null) {
            setState(() {
              _entity = Entity(
                key: _entity.key,
                properties: Map.from(_entity.properties)
                  ..[key] = Value.emptyValueOfType(newType),
              );
            });
          }
        },
      ),
    );
  }
}
