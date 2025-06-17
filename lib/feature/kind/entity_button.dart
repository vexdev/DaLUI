import 'package:dalui/feature/kind/entity_dialog.dart';
import 'package:dalui/model/value.dart';
import 'package:flutter/material.dart';

class EntityButton extends StatelessWidget {
  final ValueEntity value;

  const EntityButton({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonalIcon(
      label: Text("Entity"),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return EntityDialog(value: value);
          },
        );
      },
    );
  }
}
