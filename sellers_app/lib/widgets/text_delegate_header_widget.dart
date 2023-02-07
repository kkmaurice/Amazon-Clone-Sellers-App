import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TextDelegateHeaderWidget extends SliverPersistentHeaderDelegate {
  String title;
  TextDelegateHeaderWidget({
    required this.title,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: 82,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pinkAccent, Colors.purpleAccent],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        child: InkWell(
          child: Text(
            title,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22.0,
              letterSpacing: 3,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
    );
  }
  
  @override
  // TODO: implement maxExtent
  double get maxExtent => 50;
  
  @override
  // TODO: implement minExtent
  double get minExtent => 50;
  
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;
}
