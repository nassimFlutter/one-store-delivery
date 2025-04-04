import 'package:flutter/material.dart';
import 'package:one_store_delivery/widgets/color.dart';

class CustomFailureDialog extends StatelessWidget {
  final String message;

  const CustomFailureDialog({super.key, required this.message});

  static void show(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => CustomFailureDialog(message: message),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: const Row(
        children: [
          Icon(Icons.error, color: Colors.red, size: 28),
          SizedBox(width: 10),
          Text("خطأ", style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
      content: Text(
        message,
        style: const TextStyle(fontSize: 16, color: Colors.black87),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child:
              const Text("حسناً", style: TextStyle(color: AppColor.appColor)),
        ),
      ],
    );
  }
}
