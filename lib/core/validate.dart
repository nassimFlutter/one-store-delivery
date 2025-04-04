import 'package:flutter/material.dart';

class Validate {
  static String? validateEmail(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return "البريد الإلكتروني مطلوب";
    }

    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return "الرجاء إدخال بريد إلكتروني صالح";
    }

    return null;
  }

  static String? validatePhoneNumber(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return "رقم الهاتف مطلوب";
    }
    return null;
  }

  static String? validateOtp(String? value, BuildContext context, int length) {
    if (value == null || value.isEmpty) {
      return "رمز التحقق مطلوب";
    } else if (value.length < length) {
      return "يجب أن يتكون رمز التحقق من $length أحرف";
    }
    return null;
  }

  static String? validateFullName(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return "الاسم الكامل مطلوب";
    }
    return null;
  }

  static String? validatePassword(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return "كلمة المرور مطلوبة";
    } else if (value.length < 8) {
      return "يجب أن تتكون كلمة المرور من 8 أحرف على الأقل";
    }
    return null;
  }

  static String? validateField(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return "هذا الحقل مطلوب";
    }
    return null;
  }

  static String? validateFieldWithTitle(
      String? value, String title, BuildContext context) {
    if (value == null || value.isEmpty) {
      return "$title مطلوب";
    }
    return null;
  }

  static String? validateConfirmPassword(
      String? value, String? password, BuildContext context) {
    if (value == null || value.isEmpty) {
      return "تأكيد كلمة المرور مطلوب";
    } else if (value != password) {
      return "كلمتا المرور غير متطابقتين";
    }
    return null;
  }
}
