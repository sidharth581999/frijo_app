 import 'package:flutter/material.dart';

Future<DateTime?> pickDate(BuildContext context, {DateTime? initialDate}) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate ?? now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    return picked;
  }

  /// Time Picker function that returns picked TimeOfDay
  Future<TimeOfDay?> pickTime(BuildContext context, {TimeOfDay? initialTime}) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: initialTime ?? TimeOfDay.now(),
    );
    return picked;
  }