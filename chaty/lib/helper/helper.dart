import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:status_alert/status_alert.dart';

class Helper {
  ///Custom Alery Dialog
  static showCustomAlertDialogBox(BuildContext context,
      {String? title,
      String? subtitle,
      Duration? duration,
      double? maxWidth,
      required IconData icon}) {
    StatusAlert.show(
      context,
      duration: duration ?? const Duration(seconds: 3),
      title: title,
      subtitle: subtitle,
      configuration: IconConfiguration(icon: icon),
      maxWidth: maxWidth ?? 260,
    );
  }

  ///Custom Loading Dialogbox
  static showLoadingDialogBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Center(
          child: LoadingAnimationWidget.twistingDots(
        leftDotColor: const Color(0xFF1A1A3F),
        rightDotColor: const Color(0xFFEA3799),
        size: 100,
      )),
    );
  }

  ///Custom Snackbar
  static showSnackbar(
      {required String msg, Color? bgColor, Color? txtColor, double? fntSize}) {
    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: bgColor ?? Colors.green,
      textColor: txtColor ?? Colors.black,
      fontSize: fntSize ?? 18,
    );
  }
}
