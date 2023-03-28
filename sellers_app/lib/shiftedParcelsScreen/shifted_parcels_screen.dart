import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../global/global.dart';
import '../ordersScreen/order_card.dart';

class ShiftedParcelsScreen extends StatefulWidget {
  const ShiftedParcelsScreen({Key? key}) : super(key: key);

  @override
  State<ShiftedParcelsScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<ShiftedParcelsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Colors.pinkAccent,
              Colors.purpleAccent,
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          )),
        ),
        title: const Text(
          "Shifted Parcels Screen",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("orders")
            .where("status", isEqualTo: "shifted")
            .where("sellerUID", isEqualTo: sharedPreferences!.getString("uid"))
            .orderBy("orderTime", descending: true)
            .snapshots(),
        builder: (c, AsyncSnapshot dataSnapShot) {
          if (dataSnapShot.hasData) {
            return ListView.builder(
              itemCount: dataSnapShot.data.docs.length,
              itemBuilder: (c, index) {
                return FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection("items")
                      .where("orderBy",
                          whereIn: (dataSnapShot.data.docs[index].data()
                              as Map<String, dynamic>)["uid"])
                      .orderBy("publishedDate", descending: true)
                      .get(),
                  builder: (c, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      //return Text('Hi', style: TextStyle(color: Colors.red),);
                      return OrderCard(
                        itemCount: snapshot.data.docs.length,
                        data: snapshot.data.docs,
                        orderId: dataSnapShot.data.docs[index].id,
                        seperateQuantitiesList:
                            cartMethods.separateOrderItemsQuantities(
                                (dataSnapShot.data.docs[index].data()
                                    as Map<String, dynamic>)["productIDs"]),
                      );
                    } else {
                      return const Center(
                        child: Text(
                          "No data exists.",
                        ),
                      );
                    }
                  },
                );
              },
            );
          } else {
            return const Center(
              child: Text(
                "No data exists.",
              ),
            );
          }
        },
      ),
    );
  }
}
