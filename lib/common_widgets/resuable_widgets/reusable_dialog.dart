import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class ReusableDialog {
  static AwesomeDialog showAwesomeDialog(
    BuildContext context, {
    required String title,
    required String description,
    Function? onCancel,
    Function? onConfirm,
  }) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.rightSlide,
      title: title,
      desc: description,
      btnCancelOnPress: () => onCancel!(),
      btnOkOnPress: () => onConfirm!(),
    )..show();
  }
}
