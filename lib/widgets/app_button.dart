import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppButton extends StatelessWidget {
  final Function() onPressed;

  final String title;

  final Icon? icon;

  final Color? color;
  final EdgeInsets? padding;

  const AppButton(
      {required this.title,
      required this.onPressed,
      this.icon,
      this.color,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: OutlinedButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon != null ? Expanded(child: icon! ) : SizedBox.shrink(),
            Text(
              title,
              style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.only()),
          backgroundColor:
              color ?? Theme.of(context).primaryColor.withOpacity(0.7),
        ),
      ),
    );
  }
}
