import 'package:flutter/material.dart';
import 'package:hambolah_chat_app/core/constant/color.dart';
import '../../core/helper/responsive.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField(
      {super.key,
      this.hintText,
      this.label,
      this.onSaved,
      this.onChanged,
      this.onFieldSubmitted,
      this.validator,
      this.controller,
      this.height,
      this.width,
      this.keyboardType,
      this.icon,
      this.title,
      this.isVisible,
      this.fillColor,
      this.isVisibleColor,
      this.titleTextStyle,
      this.textFieldStyle,
      this.cursorColor});
  final String? hintText;
  final String? label;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final double? height;
  final double? width;
  final TextInputType? keyboardType;
  final String? icon;
  final String? title;
  final bool? isVisible;
  final Color? fillColor;
  final Color? isVisibleColor;
  final Color? cursorColor;
  final TextStyle? titleTextStyle;
  final TextStyle? textFieldStyle;
  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(vertical: ScreenSize.height * 0.01),
        child: Row(
          children: [
            Text(widget.title ?? "",
                style: widget.titleTextStyle ??
                    const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: MyColors.lightGrey)),
            const Text(
              " *",
              style: TextStyle(color: MyColors.red),
            )
          ],
        ),
      ),
      TextFormField(
        style: widget.textFieldStyle ??
            const TextStyle(color: MyColors.white, fontSize: 18),
        cursorColor: widget.cursorColor ?? MyColors.white,
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        obscureText: widget.isVisible == true ? isObscure : false,
        validator: widget.validator ??
            (value) {
              if (value!.isEmpty) {
                return "please fill out the field!";
              } else {
                return null;
              }
            },
        onFieldSubmitted: widget.onFieldSubmitted,
        onSaved: widget.onSaved,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          isCollapsed: true,
          helperStyle: const TextStyle(color: Colors.white),
          isDense: true,
          errorStyle:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          prefixIcon: widget.icon != null
              ? Image.asset(
                  widget.icon!,
                  scale: 1.9,
                )
              : null,
          suffixIcon: widget.isVisible == true
              ? IconButton(
                  onPressed: () {
                    isObscure = !isObscure;
                    setState(() {});
                  },
                  icon: Icon(isObscure == true
                      ? Icons.visibility_off
                      : Icons.visibility),
                  color: widget.isVisibleColor ?? Colors.white,
                  iconSize: 25,
                )
              : null,
          contentPadding: EdgeInsets.symmetric(
              vertical: ScreenSize.height * 0.017292,
              horizontal: ScreenSize.width * 0.024305),
          filled: true,
          fillColor: widget.fillColor ?? MyColors.darkGrey2,
          hintText: widget.hintText,
          label: Text(widget.label ?? ""),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: MyColors.red, width: 2)),
          focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: MyColors.red, width: 2)),
        ),
      )
    ]);
  }
}
