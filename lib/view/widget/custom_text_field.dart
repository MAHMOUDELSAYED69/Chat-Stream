import 'package:flutter/material.dart';
import 'package:chat_stream/helper/constant/colors.dart';
import 'package:chat_stream/helper/extentions/extentions.dart';
class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField(
      {super.key,
      this.hintText,
      this.onSaved,
      this.onChanged,
      this.onFieldSubmitted,
      this.validator,
      this.controller,
      this.height,
      this.width,
      this.keyboardType,
      this.title,
      this.isVisible,
      this.obscureText});
  final String? hintText;

  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final double? height;
  final double? width;
  final TextInputType? keyboardType;

  final String? title;
  final bool? isVisible;
  final bool? obscureText;
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
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Text(
              widget.title ?? "",
              style: context.textTheme.bodyMedium,
            ),
            const Text(
              " *",
              style: TextStyle(color: ColorManager.red),
            )
          ],
        ),
      ),
      TextFormField(
        style:
            context.textTheme.bodyMedium?.copyWith(color: ColorManager.white),
        cursorColor: ColorManager.white,
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        obscureText:
            widget.obscureText ?? widget.isVisible == true ? isObscure : false,
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
          suffixIcon: widget.isVisible == true
              ? IconButton(
                  onPressed: () {
                    isObscure = !isObscure;
                    setState(() {});
                  },
                  icon: Icon(isObscure == true
                      ? Icons.visibility_off
                      : Icons.visibility),
                  color: Colors.white,
                  iconSize: 20,
                )
              : null,
          hintText: widget.hintText,
        ),
      )
    ]);
  }
}
