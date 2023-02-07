import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomTextField extends StatefulWidget {
  //CustomTextField({super.key});
  TextEditingController? textEditingController;
  IconData? icon;
  String? hintText;
  bool? isObscure = true;
  bool? enabled = true;

  CustomTextField({
    super.key,
    this.textEditingController,
    this.icon,
    this.hintText,
    this.isObscure,
    this.enabled,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextField(
          controller: widget.textEditingController,
          obscureText: widget.isObscure!,
          enabled: widget.enabled!,
          cursorColor: Theme.of(context).primaryColor,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.hintText,
            prefixIcon: Icon(
              widget.icon,
              color: Colors.purpleAccent,
            ),
            focusColor: Theme.of(context).primaryColor
          ),
        ),
    );
  }
}