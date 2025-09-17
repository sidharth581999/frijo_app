import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';

class CustomAlertDialog {
  static showCustomDialog({
    required String title,
    String? subtitle,
    Map<String, dynamic>? payload,
    TypeAlert typeAlert = TypeAlert.success,
  }) {
    AlertController.show(
      title,
      subtitle ?? '',
      typeAlert,
      payload,
    );
  }
}
