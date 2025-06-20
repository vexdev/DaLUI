import 'package:dalui/feature/kind/entity_button.dart';
import 'package:dalui/model/value.dart';
import 'package:flutter/material.dart';

class PropertyEditor extends StatefulWidget {
  final String propertyKey;
  final Value value;
  final Function(String, Value) onValueChanged;

  const PropertyEditor({
    super.key,
    required this.propertyKey,
    required this.value,
    required this.onValueChanged,
  });

  @override
  State<PropertyEditor> createState() => _PropertyEditorState();
}

class _PropertyEditorState extends State<PropertyEditor> {
  late final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.value.type == ValueType.string ||
        widget.value.type == ValueType.int ||
        widget.value.type == ValueType.double) {
      _textController.text = widget.value.readable;
    }
  }

  void _changed(Value newValue) {
    widget.onValueChanged(widget.propertyKey, newValue);
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.value.type) {
      case ValueType.string:
        return TextField(
          controller: _textController,
          onChanged: (newValue) {
            _changed(ValueString(newValue));
          },
        );
      case ValueType.int:
        return TextField(
          controller: _textController,
          onChanged: (newValue) {
            _changed(ValueInt(int.tryParse(newValue) ?? 0));
          },
        );
      case ValueType.double:
        return TextField(
          controller: _textController,
          onChanged: (newValue) {
            _changed(ValueDouble(double.tryParse(newValue) ?? 0.0));
          },
        );
      case ValueType.bool:
        return Switch(
          value: (widget.value as ValueBool).value,
          onChanged: (newValue) {
            _changed(ValueBool(newValue));
          },
        );
      case ValueType.nullValue:
        return const Text('null');
      case ValueType.entity:
        return EntityButton(
          value: (widget.value as ValueEntity).entity,
          onEntitySave: (future) async {
            final updated = await future;
            if (updated != null) {
              _changed(ValueEntity(updated));
            }
          },
        );
      default:
        return Text(widget.value.readable);
    }
  }
}
