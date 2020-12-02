import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double localWidth = size.width * 0.75;
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: Colors.grey[500],
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: < Widget > [
            Container(
              width: localWidth,
              height: 200.0,
              decoration: BoxDecoration( 
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0), 
                ),
                color: Colors.grey 
              ),
            ),
          ],
        ),
      ),
    );
  }
}