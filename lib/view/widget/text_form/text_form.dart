import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  const CustomTextForm({
    Key? key,
    required this.controller,
    this.label,
    required this.isUnderlineBorder,
    this.textFieldPaddingLeft,
    this.stringKey,
    this.height,
    this.validator,
    this.isLabel = true,
    this.padding = 25,
    this.labelText,
    this.leftPadding,
    this.rightPadding,
    this.error,
  }) : super(key: key);

  final TextEditingController controller;
  final String? label;
  final bool isUnderlineBorder;
  final double? textFieldPaddingLeft;
  final double? height;
  final bool isLabel;
  final double padding;
  final double? leftPadding;
  final double? rightPadding;
  final String? labelText;
  final String? Function(String?)? validator;
  final String? error;
  final String? stringKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: leftPadding ?? 0, right: rightPadding ?? 0, top: 10),
      child: SizedBox(
        height: height ?? 55,
        child: Padding(
          padding: EdgeInsets.only(left: padding),
          child: TextFormField(
            controller: controller,
            validator: validator,
            decoration: InputDecoration(
              counter: null,
              counterText: "",
              labelText: labelText,
              labelStyle: const TextStyle(
                color: Colors.black,
              ),
              contentPadding: EdgeInsets.only(left: textFieldPaddingLeft ?? 0),
              border: isUnderlineBorder
                  ? const UnderlineInputBorder(
                      borderSide: BorderSide(
                      color: Colors.black,
                    ))
                  : const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
              focusedBorder: isUnderlineBorder
                  ? const UnderlineInputBorder(
                      borderSide: BorderSide(
                      color: Colors.black,
                    ))
                  : const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
            ),
          ),
        ),
      ),
    );
  }
}
