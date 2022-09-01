import 'package:flutter/material.dart';
import 'package:loginpage/login_page.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("An error occurred"),
          content: Text(text),
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
