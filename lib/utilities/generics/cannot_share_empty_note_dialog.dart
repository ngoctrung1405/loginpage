import 'package:flutter/material.dart';

Future<void> showCannotShareEmptyNOteDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Sharing"),
          content: Text(" You cannot share an empty note!"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Ok"))
          ],
        );
      });
}
