import 'package:flutter/material.dart';

Future<TimeOfDay?> showTimePickerDialog({
  required BuildContext context,
  required TimeOfDay initialTime,
}) async {
  var value = await showTimePicker(context: context, initialTime: initialTime)
      .catchError((err) {
    print(err.toString());
  });
  return value;
}
