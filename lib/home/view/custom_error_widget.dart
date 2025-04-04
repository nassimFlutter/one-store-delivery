import 'package:flutter/material.dart';
import 'package:one_store_delivery/core/helper_fuctions.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    super.key,
    required this.errorMessage,
    required this.retryCallback, // Add retry callback
  });

  final String errorMessage;
  final VoidCallback retryCallback; // Callback for retry

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        margin: const EdgeInsets.symmetric(horizontal: 40.0),
        decoration: BoxDecoration(
          color: Colors.red.shade100,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Colors.red.shade400,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.red.shade600,
                  size: 30.0,
                ),
                const SizedBox(width: 10.0),
                Flexible(
                  child: Text(
                    HelperFunctions.isInDebugMode()
                        ? errorMessage
                        : "حدث خطأ اعد المحاولة",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.red.shade800,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0), // Space between text and button
            ElevatedButton(
              onPressed: retryCallback,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade600,
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 12.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ), // Execute the retry callback
              child: const Text("إعادة المحاولة"),
            ),
          ],
        ),
      ),
    );
  }
}
