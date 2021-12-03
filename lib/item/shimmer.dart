import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerItem extends StatelessWidget {
  final double height;

  ShimmerItem(this.height);
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        highlightColor: Colors.grey[200],
        baseColor: Colors.grey[350],
        period: Duration(milliseconds: 2000),
        child: Container(
          height: height,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 0.0), //(x,y)
              blurRadius: 0.0,
            ),
          ], borderRadius: BorderRadius.circular(20)),
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.symmetric(vertical: 5),
        ));
  }
}
