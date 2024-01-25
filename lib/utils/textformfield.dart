import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newproject/utils/colors.dart';

class TextFormInputField extends StatelessWidget {
  final TextEditingController controller;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
  final Widget? preIcon;
  final Widget? suIcon;

  final void Function()? onTap;
  final void Function(String)? onChanged;

  final AutovalidateMode? autovalidateMode;
  final FormFieldValidator? validat;
  final List<TextInputFormatter>? inputFormatters;
  final String? error;
  final int? maxLines;

  const TextFormInputField(
      {Key? key,
      required this.controller,
      this.isPass = false,
      this.preIcon,
      this.suIcon,
      this.onChanged,
      this.error,
      this.maxLines,
      this.onTap,
      this.autovalidateMode,
      this.inputFormatters,
      this.validat,
      required this.hintText,
      required this.textInputType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      style: const TextStyle(color: textColor),
      onTap: onTap,
      autovalidateMode: autovalidateMode,
      inputFormatters: inputFormatters,
      validator: validat,
      onChanged: onChanged,
      keyboardType: textInputType,
      obscureText: isPass,
      controller: controller,
      decoration: InputDecoration(
          suffixIcon: suIcon,
          prefixIcon: preIcon,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: mainTextFormColor),
            borderRadius: BorderRadius.circular(30),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: mainTextFormColor),
            borderRadius: BorderRadius.circular(30),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: mainTextFormColor),
            borderRadius: BorderRadius.circular(30),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: mainTextFormColor),
            borderRadius: BorderRadius.circular(30),
          ),
          border: InputBorder.none,
          fillColor: mainTextFormColor,
          filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(color: Color(0xffA2A5AA))),
    );
  }
}
