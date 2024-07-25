import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController controller;
  final Function()? onTap;
  final Icon? prefixIcon ;
  final Function(String) onChange;

  final String? Function(String?)? validator;

  final TextInputType? textInputType;

  final InputDecoration? decoration;
  final String hintText;
  final bool isPasswordField;

  const AppTextField(
      {required this.controller,
      required this.hintText,
        this.prefixIcon ,
      this.onTap,
      required this.onChange,
      this.isPasswordField = false,
      this.validator,
      this.textInputType,
      this.decoration});

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: InkWell(
        onTap: widget.onTap,
        child: TextFormField(
            enabled: widget.onTap == null ? true : false,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            obscureText: widget.isPasswordField ? obscure : false,
            style: GoogleFonts.lato(
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
            keyboardType: widget.textInputType ?? TextInputType.text,
            controller: widget.controller,
            decoration: widget.decoration ??
                InputDecoration(
                  prefixIcon: widget.isPasswordField
                      ? IconButton(
                          icon: Icon(Icons.remove_red_eye),
                          onPressed: () {
                            setState(() {
                              obscure = !obscure;
                            });
                          },
                        )
                      : widget.prefixIcon,
                  isDense: true,
                  border: OutlineInputBorder(),
                  filled: true,
                  hintTextDirection: TextDirection.rtl,
                  contentPadding: EdgeInsets.all(12),
                  fillColor: Theme.of(context).primaryColor.withOpacity(0.2),
                  hintText: widget.hintText,
                  hintStyle: GoogleFonts.lato(
                    color: Colors.black26,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
            onChanged: widget.onChange,
            textInputAction: TextInputAction.next,
            validator: widget.validator),
      ),
    );
  }
}
