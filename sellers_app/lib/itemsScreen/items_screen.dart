import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sellers_app/global/global.dart';
import 'package:sellers_app/models/brands.dart';
import 'package:sellers_app/models/items.dart';

import '../widgets/text_delegate_header_widget.dart';
import 'items_ui_design_widget.dart';
import 'upload_items_screen.dart';

class ItemsScreen extends StatefulWidget {
  ItemsScreen({super.key, required this.model});
  Brands model;

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
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
        title: const Text(
          "iShop",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (c) => UploadItemsScreen(model: widget.model)));
            },
            icon: const Icon(
              Icons.add_box_rounded,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: TextDelegateHeaderWidget(
                title: "My ${widget.model.brandTitle}'s items"),
          ),

          //1. write query
          //2  model
          //3. ui design widget

          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('sellers')
                .doc(sharedPreferences!.getString('uid'))
                .collection('brands')
                .doc(widget.model.brandID)
                .collection('items')
                .orderBy("publishedDate", descending: true)
                .snapshots(),
            builder: (context, AsyncSnapshot dataSnapshot) {
              if (dataSnapshot.hasData) //if brands exists
              {
                //display brands
                return SliverStaggeredGrid.countBuilder(
                  crossAxisCount: 1,
                  staggeredTileBuilder: (c) => const StaggeredTile.fit(1),
                  itemBuilder: (context, index) {
                    Items itemsModel = Items.fromDocument(
                      dataSnapshot.data.docs[index].data()
                          as Map<String, dynamic>,
                    );

                    return ItemsUiDesignWidget(
                      model: itemsModel,
                      context: context,
                    );
                  },
                  itemCount: dataSnapshot.data.docs.length,
                );
              } else //if brands NOT exists
              {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      "No items found",
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
