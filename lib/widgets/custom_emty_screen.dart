import 'package:flutter/material.dart';
import 'package:one_store_delivery/widgets/color.dart';

class CustomEmptyScreen extends StatelessWidget {
  const CustomEmptyScreen({super.key, this.onPressed});
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.inbox, size: 80, color: Colors.grey.shade400),
        const SizedBox(height: 16),
        const Text(
          "لم يتم العثور على طلبات ",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54),
        ),
        const SizedBox(height: 8),
        const Text(
          "حاول التحقق لاحقًا أو قم بتحديث الصفحة",
          style: TextStyle(fontSize: 14, color: Colors.black45),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        ElevatedButton.icon(
          onPressed: onPressed,
          icon: const Icon(Icons.refresh, color: Colors.white),
          label: const Text("تحديث", style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.appColor,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}
