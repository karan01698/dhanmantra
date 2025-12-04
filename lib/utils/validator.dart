import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Validators {
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.length != 10) {
      return "Enter a valid 10-digit phone number";
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.length < 6) {
      return "Enter at least 6 characters";
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return "Confirm password cannot be empty";
    }
    if (value != password) {
      return "Passwords do not match";
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Name cannot be empty";
    }
    if (value.length < 3) {
      return "Enter at least 3 characters";
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email cannot be empty";
    }
    // Regular expression for validating email format
    final emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    if (!emailRegex.hasMatch(value)) {
      return "Enter a valid email address";
    }
    return null;
  }

  static String? validateDepositAmount(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter an amount";
    }
    final num? amount = num.tryParse(value);
    if (amount == null || amount <= 0) {
      return "Enter a valid deposit amount";
    }
    return null;
  }

  // New validation for minimum withdrawal amount
  static String? validateWithdrawAmount(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter an amount";
    }
    final num? amount = num.tryParse(value);
    if (amount == null) {
      return "Enter a valid number";
    }
    if (amount < 300) {
      return "You cannot withdraw less than ₹300";
    }
    return null;
  }


  static String? validateIFSC(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "IFSC code cannot be empty";
    }
    if (!RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$').hasMatch(value)) {
      return "Enter a valid IFSC code";
    }
    return null;
  }

  static String? validateAccountNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Account number cannot be empty";
    }
    if (value.length < 9 || value.length > 18) {
      return "Enter a valid account number";
    }
    return null;
  }

  static String? validateConfirmAccount(String? value, String accountNumber) {
    if (value == null || value.trim().isEmpty) {
      return "Confirm account number cannot be empty";
    }
    if (value != accountNumber) {
      return "Account numbers do not match";
    }
    return null;
  }
  static String? validateUPI(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "UPI ID cannot be empty";
    }
    if (!RegExp(r'^[a-zA-Z0-9.\-_]{2,256}@[a-zA-Z]{2,64}$').hasMatch(value)) {
      return "Enter a valid UPI ID";
    }
    return null;
  }

  static String? validateOTP(String? value, String generatedOtp) {
    if (value == null || value.trim().isEmpty) {
      return "OTP cannot be empty";
    }
    if (value.length != 6) {
      return "Enter a valid 6-digit OTP";
    }
    if (value != generatedOtp) {
      return "Incorrect OTP";
    }
    return null;
  }

}

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? icon;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Color? borderColor;
  final double? borderRadius;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? contentPadding;
  final Color? prefixIconColor;
  final Color? suffixIconColor;
  final Function(String)? onChanged;
  final Widget? flagImage;
  final TextStyle? style;
  final InputDecoration? decoration;
  final Color? cursorColor;
  final bool isPhoneField;
  final bool isEnabled; // ✅ New parameter for enabling/disabling
  final String? suffixText; // ✅ Added suffix text parameter
  final TextStyle? suffixStyle; // ✅ Added suffix text style parameter

  const CustomTextField({
    Key? key,
    this.hintText,
    this.controller,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.icon,
    this.obscureText = false,
    this.validator,
    this.borderColor,
    this.borderRadius,
    this.backgroundColor,
    this.contentPadding,
    this.prefixIconColor,
    this.suffixIconColor,
    this.onChanged,
    this.flagImage,
    this.style,
    this.decoration,
    this.cursorColor,
    this.isPhoneField = false,
    this.isEnabled = true, // ✅ Default is enabled
    this.suffixText, // ✅ Initialize suffixText
    this.suffixStyle, // ✅ Initialize suffixStyle
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: style ??
          TextStyle(fontSize: 14, color: isEnabled ? Colors.black : Colors.grey),
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      onChanged: isEnabled ? onChanged : null, // Disable onChanged when disabled
      cursorColor: cursorColor ?? Colors.black,
      enabled: isEnabled, // ✅ Enables/disables the field
      inputFormatters: isPhoneField
          ? [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(10)]
          : null,

      decoration: decoration ??
          InputDecoration(
            icon: icon,
            hintText: hintText ?? "",
            filled: true,
            fillColor: isEnabled
                ? (backgroundColor ?? const Color(0xFFF3F4F6))
                : Colors.grey.shade300, // ✅ Change background when disabled
            prefixIcon: (prefixIcon != null || flagImage != null)
                ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (prefixIcon != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconTheme(
                      data: IconThemeData(
                          color: isEnabled
                              ? (prefixIconColor ?? Colors.black)
                              : Colors.grey), // ✅ Change icon color
                      child: prefixIcon!,
                    ),
                  ),
                if (flagImage != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: flagImage,
                  ),
              ],
            )
                : null,
            suffixIcon: suffixIcon != null
                ? IconTheme(
              data: IconThemeData(
                  color: isEnabled
                      ? (suffixIconColor ?? Colors.black)
                      : Colors.grey), // ✅ Change icon color
              child: suffixIcon!,
            )
                : null,
            suffixText: suffixText, // ✅ Set suffix text
            suffixStyle: suffixStyle ??
                TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black), // ✅ Default suffix style
            contentPadding:
            contentPadding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
              borderSide: BorderSide(
                  color: isEnabled ? (borderColor ?? Colors.grey) : Colors.grey.shade500), // ✅ Change border color
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
              borderSide: BorderSide(
                  color: isEnabled ? (borderColor ?? Colors.grey) : Colors.grey.shade500),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
              borderSide: BorderSide(
                  color: isEnabled ? Colors.blue : Colors.grey.shade500, width: 2), // ✅ Grey border if disabled
            ),
          ),
    );
  }
}
