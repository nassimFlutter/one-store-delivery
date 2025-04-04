import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class HelperFunctions {
  static void navigateToScreen(BuildContext context, WidgetBuilder screen) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => screen(context),
      ),
    );
  }

  static bool isInDebugMode() {
    return kDebugMode;
  }
}
