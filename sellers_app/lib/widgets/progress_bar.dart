import 'package:flutter/material.dart';

linearProgressBar(){
  return Container(
    alignment: Alignment.center,
    //height: 10,
    child: const Padding(
      padding: EdgeInsets.only(top: 14.0),
      child: LinearProgressIndicator(
        backgroundColor: Colors.white,
        valueColor: AlwaysStoppedAnimation(Colors.pinkAccent),
      ),
    ),
  );
}