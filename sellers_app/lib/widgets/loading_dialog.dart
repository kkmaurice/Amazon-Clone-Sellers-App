// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  LoadingDialog({super.key, required this.message});
String? message;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 14.0),
            child: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.pinkAccent),
            ),
          ),
          const SizedBox(height: 15.0),
          Text(message!.toString() + 'Please wait...'),
        ],
      )
    );
  }
}