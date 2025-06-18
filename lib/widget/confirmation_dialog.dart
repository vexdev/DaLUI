import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

void showConfirmationDialog(
  BuildContext context, {
  required VoidCallback onConfirm,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Are you sure?"),
        actions: <Widget>[
          TextButton(
            onPressed: () => context.router.pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              context.router.pop();
              onConfirm();
            },
            child: const Text('Confirm'),
          ),
        ],
      );
    },
  );
}
