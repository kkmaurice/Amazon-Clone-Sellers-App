import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sellers_app/global/global.dart';

import '../models/address.dart';
import '../splashScreen/my_splash_screen.dart';

class AddressDesign extends StatelessWidget {
  Address model;
  String orderStatus;
  String orderId;
  String totalAmount;
  String? sellerId;
  String? orderByUser;
  AddressDesign({
    Key? key,
    required this.model,
    required this.orderStatus,
    required this.orderId,
    required this.totalAmount,
    this.sellerId,
    this.orderByUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            'Shipping Details',
            style: TextStyle(
                color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 5),
          child: Table(
            children: [
              TableRow(
                children: [
                  const Text(
                    'Name',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    model.name,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              TableRow(
                children: [
                  const Text(
                    'Phone Number',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    model.phone,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            model.completeAddress,
            textAlign: TextAlign.justify,
            style: const TextStyle(
                color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        GestureDetector(
          onTap: () {
            if (orderStatus == 'normal') {
              FirebaseFirestore.instance
                  .collection('sellers')
                  .doc(sharedPreferences!.getString('uid'))
                  .update({
                'earning': double.parse(previousEarnings + totalAmount),
              }).whenComplete(() {
                // Change the order status to 'shifted'
                FirebaseFirestore.instance
                    .collection('orders')
                    .doc(orderId)
                    .update({
                  'status': 'shifted',
                }).whenComplete(() {
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(orderByUser)
                      .collection('orders')
                      .doc(orderId)
                      .update({
                    'status': 'shifted',
                  }).whenComplete(() {
                    // send notification to user that the order has been shifted
                    Fluttertoast.showToast(msg: 'Confirmed successfully');

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const MySplashScreen()));
                  });
                });
              });
            } else if (orderStatus == 'shifted') {
              // implement parcel delivered and received
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MySplashScreen()));
            } else if (orderStatus == 'ended') {
              // implement Rate this seller
            } else {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MySplashScreen()));
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
                width: MediaQuery.of(context).size.width - 40,
                height: orderStatus == 'normal'
                    ? 80
                    : MediaQuery.of(context).size.height * 0.07,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    gradient: LinearGradient(
                      colors: [Colors.pinkAccent, Colors.purpleAccent],
                      begin: FractionalOffset(0.0, 0.0),
                      end: FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp,
                    )),
                child: Center(
                  child: Text(
                    orderStatus == 'ended'
                        ? 'Go Back'
                        : orderStatus == 'shifted'
                            ? 'Go Back'
                            : orderStatus == 'normal'
                                ? 'Parcel Packed & \nShifted to Nearest PickUp Point. \nClick to confirm'
                                : '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                )),
          ),
        )
      ],
    );
  }
}
