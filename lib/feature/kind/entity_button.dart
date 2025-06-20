import 'package:dalui/feature/kind/entity_dialog.dart';
import 'package:dalui/model/entity.dart';
import 'package:flutter/material.dart';

class EntityButton extends StatelessWidget {
  final Entity _value;
  final Function(Future<Entity?>) _onEntitySave;
  final String _kind;

  const EntityButton({
    super.key,
    required Entity value,
    required String kind,
    required Function(Future<Entity?>) onEntitySave,
  }) : _value = value,
       _kind = kind,
       _onEntitySave = onEntitySave;

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonalIcon(
      label: Text("Entity"),
      onPressed: () {
        _onEntitySave(
          showEditEntityDialog(
            context,
            value: _value,
            kind: _kind,
            nested: true,
          ),
        );
      },
    );
  }
}
