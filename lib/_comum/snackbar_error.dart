import 'package:flutter/material.dart';

showSnackBar(
    {required BuildContext context,
    required String text,
    bool isError = true}) {
  SnackBar snackBar = SnackBar(
    content: Text(text),
    backgroundColor: (isError) ? Colors.red[700] : Colors.green[700],
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
    duration: const Duration(seconds: 3),
    action: SnackBarAction(
      label: "",
      textColor: Colors.white,
      onPressed: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
    ),
    showCloseIcon: true,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
