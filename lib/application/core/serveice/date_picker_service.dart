import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frijo/application/core/theme/colors.dart';

class DatePickerService {
  static void showPlatformDatePicker({
    required BuildContext context,
    required void Function(DateTime?) onComplete,
    DateTime? initialDate,
    int? maximumDate,
  }) async {
    if (Platform.isIOS) {
      showModalBottomSheet<DateTime>(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: 300,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: initialDate,
              minimumYear: maximumDate != null ? DateTime.now().year : 1950,
              maximumDate: maximumDate != null
                  ? DateTime(DateTime.now().year + maximumDate)
                  : DateTime.now(),
              // maximumYear: currentyear,
              onDateTimeChanged: (DateTime newDate) {
                onComplete(newDate);
                // Logger.logInfo(newDate);
                // setState(() {
                //   // selectedDate =   DateFormat(newDate).format(dateTime);
                //   //newDate;

                //   dobKeyTextEditController.text = _formatDate(
                //     newDate.toIso8601String(),
                //   );
                //   selectedDob = newDate;
                // });
              },
            ),
          );
        },
      );
    } else {
      final date = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: maximumDate != null ? DateTime.now() : DateTime(1950),
        lastDate: maximumDate != null
            ? DateTime(DateTime.now().year + maximumDate)
            : DateTime.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme:
                   ColorScheme.light(primary: ColorResources.white
                      // Customize your color here
                      ),
            ),
            child: child!,
          );
        },
      );

      onComplete(date);
    }
  }
}
