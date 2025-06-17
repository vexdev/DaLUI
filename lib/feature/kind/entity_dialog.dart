import 'package:auto_route/auto_route.dart';
import 'package:dalui/feature/kind/entity_button.dart';
import 'package:dalui/model/value.dart';
import 'package:flutter/material.dart';

class EntityDialog extends StatelessWidget {
  final ValueEntity value;

  const EntityDialog({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    final entity = value.entity;
    final props = entity.properties;
    return AlertDialog(
      title: Text("Entity Details"),
      content: SelectionArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: props.keys.map((key) {
              final val = props[key];
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(key),
                      const SizedBox(width: 8),
                      Text(
                        val?.type.name ?? 'Not Set',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(width: 32),
                  if (val is ValueEntity)
                    EntityButton(value: val)
                  else
                    Text(
                      val?.readable ?? 'Not Set',
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => context.router.pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }
}
