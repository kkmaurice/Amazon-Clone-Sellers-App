import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:transparent_image/transparent_image.dart';

import '../global/global.dart';
import '../itemsScreen/items_screen.dart';
import '../models/brands.dart';
import '../splashScreen/my_splash_screen.dart';

class BrandsUiDesignWidget extends StatefulWidget {

  Brands model;
  BuildContext context;

  BrandsUiDesignWidget({
    Key? key,
    required this.model,
    required this.context,
  }) : super(key: key);

  @override
  State<BrandsUiDesignWidget> createState() => _BrandsUiDesignWidgetState();
}

class _BrandsUiDesignWidgetState extends State<BrandsUiDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (c) => ItemsScreen(model: widget.model)));
      },
      child: Card(
        elevation: 10,
        shadowColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: SizedBox(
            height: 270,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                // FadeInImage.memoryNetwork(
                //   placeholder: kTransparentImage, 
                //   image: widget.model.thumbnailUrl, fit: BoxFit.fill,height: 220, width: MediaQuery.of(context).size.width,),
                Image.network(widget.model.thumbnailUrl, height: 220, fit: BoxFit.fill,width: MediaQuery.of(context).size.width,),
                const SizedBox(height: 1,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.model.brandTitle.toUpperCase(), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 3),),
                    IconButton(onPressed: (){deleteBrand();}, icon: const Icon(Icons.delete_sweep, color: Colors.pinkAccent,)),
                  ],
                )
              ],
            )
          ),
          ),
      ),
    );
  }

  deleteBrand(){
    showDialog(
      context: context,
      builder: (c) {
        return AlertDialog(
          title: const Text("Delete Brand"),
          content: const Text("Are you sure you want to delete this brand?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              }, 
              child: const Text("No")
              ),
            TextButton(
              onPressed: () {
                FirebaseFirestore.instance.collection('sellers').doc(sharedPreferences!.getString("uid")).collection('brands').doc(widget.model.brandID).delete().then((value) {
                    Fluttertoast.showToast(msg: "Item ${widget.model.brandTitle} deleted Successfully", gravity: ToastGravity.CENTER);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const MySplashScreen()));
                  });
                } ,
            
              child: const Text("Yes")
              )
          ],
        );
      }
    );}
}