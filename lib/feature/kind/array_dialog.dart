import 'package:dalui/feature/kind/property_editor.dart';
import 'package:dalui/feature/kind/property_type_editor.dart';
import 'package:dalui/model/value.dart';
import 'package:flutter/material.dart';

class ArrayDialog extends StatefulWidget {
  final List<Value> values;

  const ArrayDialog._({required this.values});

  @override
  State<ArrayDialog> createState() => _ArrayDialogState();
}

Future<List<Value>?> showArrayDialog(
  BuildContext context, {
  required List<Value> values,
}) {
  return showDialog<List<Value>?>(
    context: context,
    builder: (context) => ArrayDialog._(values: values),
  );
}

class _ArrayDialogState extends State<ArrayDialog> {
  late final List<Value> _values;

  @override
  void initState() {
    super.initState();
    _values = List.from(widget.values);
  }

  void _addValue() {
    setState(() {
      _values.add(ValueString(''));
    });
  }

  void _removeValue(int index) {
    setState(() {
      _values.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Array'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (int i = 0; i < _values.length; i++)
              Row(
                children: [
                  PropertyTypeEditor(
                    propertyKey: i.toString(),
                    value: _values[i],
                    onTypeChanged: (String key, Value newValue) {
                      // Forbid to change type to Array
                      if (newValue.type == ValueType.array) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Arrays cannot contain other arrays.',
                            ),
                          ),
                        );
                        return;
                      }
                      setState(() {
                        _values[i] = newValue;
                      });
                    },
                  ),
                  Expanded(
                    child: PropertyEditor(
                      propertyKey: i.toString(),
                      value: _values[i],
                      onValueChanged: (String key, Value newValue) {
                        setState(() {
                          _values[i] = newValue;
                        });
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _removeValue(i),
                  ),
                ],
              ),
            // Add button to add new value
            SizedBox(height: 8.0),
            ElevatedButton.icon(
              icon: Icon(Icons.add),
              label: Text('Add Value'),
              onPressed: _addValue,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(null),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(_values),
          child: Text('Save'),
        ),
      ],
    );
  }
}
