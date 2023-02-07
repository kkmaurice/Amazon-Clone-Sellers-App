// ignore_for_file: unused_local_variable, must_be_immutable

import 'package:flutter/material.dart';

import '../brandsScreens/home_screen.dart';


class StatusBanner extends StatelessWidget {

  bool status;
  String orderStatus;

  StatusBanner({
    Key? key,
    required this.status,
    required this.orderStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    String? message;
    IconData? iconData;
    
    status ? iconData = Icons.done : iconData = Icons.cancel;
    status ? message ='Successful' : message = 'Unsuccessful';

    return SafeArea(
      child: Container(
        height: 70,
              decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.pinkAccent, Colors.purpleAccent],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen())),
                  child: const Icon(Icons.arrow_back,color: Colors.white,)),
                  const SizedBox(width: 40,),
                Text(
                  orderStatus == 'ended'? 'Parcel Delivered $message' : orderStatus == 'shifted' ? 'Parcel Shifted $message' : orderStatus == 'normal' ? 'Order Placed $message' : '',
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
                const SizedBox(width: 5,),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: status == false ? Colors.black : Colors.green,
                  child: Center(
                    child: Icon(iconData, color: Colors.white,),
                  ),
                )
              ],
            ),
            ),
    );
  }
}
