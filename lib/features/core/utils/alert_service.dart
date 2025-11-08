// lib/core/utils/alert_service.dart
import 'package:flutter/material.dart';

abstract class AlertsService {
  static void showSnackBar(BuildContext context, String message, {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  static Future<void> showCustomDialog(BuildContext context, Widget dialogContent) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.width * 0.5,
          child: Center(child: dialogContent),
        ),
      ),
    );
  }

  static void showBottomSheet(BuildContext context, Widget child) {
    showModalBottomSheet(
      context: context,
      builder: (_) =>
          Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,),
            child:
            child,
            ),
    );
  }
}
