import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ReusableToast {
  static Future<bool?> show({
       required String message,
       required Color bgColor,
       required Color textColor,
       required double fontSize,
       }) {
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: bgColor,
        textColor: Colors.white,
        fontSize: fontSize
    );
  }

}