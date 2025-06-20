import 'package:dalui/dalui_config.dart';
import 'package:dalui/model/value.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PropertyTypeEditor extends StatefulWidget {
  final String propertyKey;
  final Value value;
  final Function(String, Value) onTypeChanged;

  const PropertyTypeEditor({
    super.key,
    required this.propertyKey,
    required this.value,
    required this.onTypeChanged,
  });

  @override
  State<PropertyTypeEditor> createState() => _PropertyTypeEditorState();
}

class _PropertyTypeEditorState extends State<PropertyTypeEditor> {
  late final DaluiConfig _config;

  @override
  void initState() {
    super.initState();
    _config = context.read();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<ValueType>(
        value: widget.value.type,
        items: ValueType.values.map((type) {
          return DropdownMenuItem<ValueType>(
            value: type,
            child: Text(type.name),
          );
        }).toList(),
        onChanged: (newType) {
          if (newType != null) {
            widget.onTypeChanged(
              widget.propertyKey,
              Value.emptyValueOfType(newType, _config.projectId),
            );
          }
        },
      ),
    );
  }
}
