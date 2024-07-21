


import 'package:flutter/material.dart';

extension DialogExtension on BuildContext {
  Future<void> showErrorDialog({String message = "حدث خطأ ما!"}) async {
    showDialog(context: this, builder: (context) {
      return Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              child: Text(message),
            )
          ],
        ),
      );
    },);
  }

  Future<void> ShowLoadingDialog({String message = "حدث خطأ ما!"}) async {
    showDialog(context: this, builder: (context) {
      return Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          ],
        ),
      );
    },);
  }

  Future<void> showSuccessDialog({String message = "حدث خطأ ما!"}) async {
    showDialog(context: this, builder: (context) {
      return Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              child: Text(message),
            )
          ],
        ),
      );
    },);
  }
}