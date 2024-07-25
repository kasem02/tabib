import 'package:AlMokhtar_Clinic/widgets/app_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

extension DialogExtension on BuildContext {
  Future<void> showErrorDialog({String message = "حدث خطأ ما!"}) async {
    showDialog(
      context: this,
      builder: (context) {
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
      },
    );
  }

  Future<void> showLoadingDialog({String message = "حدث خطأ ما!"}) async {
    showDialog(
      context: this,
      builder: (context) {
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
      },
    );
  }

  Future<void> showSuccessDialog({String message = "حدث خطأ ما!"}) async {
    showDialog(
      context: this,
      builder: (context) {
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
      },
    );
  }

  Future<void> showConfirmDialog(
      {String message = "هل أنت متأكد؟", required VoidCallback onConfirm}) async {
    showDialog(
      context: this,
      builder: (context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message,
                  style: TextStyle(fontSize: 16, color: Colors.lightBlueAccent),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        title: "تأكيد",
                        onPressed: () => onConfirm(),
                      ),
                    ),
                    SizedBox(width: 10,) ,
                    Expanded(child: AppButton(title: "الغاء", onPressed: context.pop))
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> showSuccessAlert({String message = ""}) async {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.right,
      ),
      backgroundColor: Colors.green,
    ));
  }

  Future<void> showFailureAlert({String message = ""}) async {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.right,
      ),
      backgroundColor: Colors.red,
    ));
  }
}
