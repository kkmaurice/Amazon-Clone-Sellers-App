// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';

import '../global/global.dart';
import '../models/address.dart';
import 'address_design_widget.dart';
import 'status_banner_widget.dart';

class OrderDetailsScreen extends StatefulWidget {
  String orderId;
  OrderDetailsScreen({
    Key? key,
    required this.orderId,
  }) : super(key: key);

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  String orderStatus = '';
  bool isSuccess = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('orders')
                .doc(widget.orderId)
                .get(),
            builder: (context, AsyncSnapshot snapshot) {
              Map orderDataMap;
              if (snapshot.hasData) {
                orderDataMap = snapshot.data.data() as Map<String, dynamic>;
                orderStatus = orderDataMap['status'].toString();
                isSuccess = orderDataMap['isSuccess'];
                return Column(
                  children: [
                    StatusBanner(
                      orderStatus: orderStatus,
                      status: isSuccess,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '\$ ${orderDataMap['totalAmount']}',
                            style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Order ID: ${orderDataMap['orderId'].split('-')[0]}',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Ordered at: ${DateFormat('dd MMMM, yyyy - hh:mm aa').format(DateTime.fromMillisecondsSinceEpoch(int.parse(orderDataMap['orderTime'])))}',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                          )),
                    ),
                    const Divider(
                      thickness: 2,
                      color: Colors.pinkAccent,
                    ),
                    orderStatus != 'ended'
                        ? Image.asset('assets/images/packing.jpg')
                        : Image.asset('assets/images/delivered.jpg'),
                    const Divider(
                      thickness: 2,
                      color: Colors.pinkAccent,
                    ),
                    FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection('users')
                            .doc(orderDataMap['orderBy'])
                            .collection('userAddress')
                            .doc(orderDataMap['addressID'])
                            .get(),
                        builder: (context, AsyncSnapshot dataSnapshot) {
                          if (dataSnapshot.hasData) {
                            return AddressDesign(
                                model: Address.fromJson(dataSnapshot.data.data()
                                    as Map<String, dynamic>),
                                orderStatus: orderStatus,
                                orderId: widget.orderId,
                                sellerId: orderDataMap['sellerUID'],
                                orderByUser: orderDataMap['orderBy'],
                                totalAmount: orderDataMap['totalAmount'].toString(),
                                );
                          } else {
                            return const Center(
                              child: Text('No data exists'),
                            );
                          }
                        })
                  ],
                );
              } else {
                return const Center(
                  child: Text('No data exists'),
                );
              }
            }),
      ),
    );
  }
}
