// ignore_for_file: implementation_imports, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sellers_app/splashScreen/my_splash_screen.dart';

import '../global/global.dart';
import '../models/items.dart';

class ItemsDetailsScreen extends StatefulWidget {
  ItemsDetailsScreen({super.key, required this.model});
  Items model;
  @override
  State<ItemsDetailsScreen> createState() => _ItemsDetailsScreenState();
}

class _ItemsDetailsScreenState extends State<ItemsDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          title: Text(
            widget.model.itemTitle,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            left: 8,
            right: 8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                widget.model.thumbnailUrl,
                fit: BoxFit.cover,
                height: 250,
                width: double.infinity,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '${widget.model.itemTitle.toUpperCase()} :',
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.pinkAccent),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.model.longDescription,
                style: const TextStyle(
                    fontSize: 17, fontWeight: FontWeight.normal),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '\$${widget.model.itemPrice}',
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.pinkAccent),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 2,
              ),
              const Divider(
                thickness: 2,
                color: Colors.pinkAccent,
                indent: 5,
                endIndent: 320,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: (() {
              deleteItem();
            }),
            label: const Text("Delete this Item"),
            icon: const Icon(Icons.delete_sweep_outlined),
            backgroundColor: Colors.pinkAccent));
  }

  deleteItem() {
    showDialog(
        context: context,
        builder: (c) {
          return AlertDialog(
            title: const Text("Delete Item"),
            content: const Text("Are you sure you want to delete this item?"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("No")),
              TextButton(
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection('sellers')
                        .doc(sharedPreferences!.getString('uid'))
                        .collection('brands')
                        .doc(widget.model.brandID)
                        .collection('items')
                        .doc(widget.model.itemID)
                        .delete()
                        .then((value) {
                      FirebaseFirestore.instance
                          .collection('items')
                          .doc(widget.model.itemID)
                          .delete()
                          .then((value) {
                        Fluttertoast.showToast(
                            msg:
                                "Item ${widget.model.itemTitle} deleted Successfully",
                            gravity: ToastGravity.CENTER);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MySplashScreen()));
                      });
                    });
                  },
                  child: const Text("Yes")),
            ],
          );
        });
  }
}
