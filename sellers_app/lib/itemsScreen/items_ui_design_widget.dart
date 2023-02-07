import 'package:flutter/material.dart';

import '../models/items.dart';
import 'items_details_screen.dart';

class ItemsUiDesignWidget extends StatefulWidget {

  Items model;
  BuildContext context;

  ItemsUiDesignWidget({
    Key? key,
    required this.model,
    required this.context,
  }) : super(key: key);

  @override
  State<ItemsUiDesignWidget> createState() => _BrandsUiDesignWidgetState();
}

class _BrandsUiDesignWidgetState extends State<ItemsUiDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (c) => ItemsDetailsScreen(model: widget.model)));
      },
      child: Card(
        elevation: 10,
        shadowColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                const SizedBox(height: 2,),
                Text(widget.model.itemTitle, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 3),),

                    const SizedBox(height: 4,),

                Image.network(widget.model.thumbnailUrl, height: 220, fit: BoxFit.fill,width: MediaQuery.of(context).size.width,),

                const SizedBox(height: 2,),

                Text(widget.model.itemInfo, style: const TextStyle(fontSize: 14, color: Colors.grey),),

            
              ],
            )
          ),
          ),
      ),
    );
  }
}