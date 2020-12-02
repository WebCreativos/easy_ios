//Framework
import 'package:flutter/material.dart';

class ButtonDayWidget extends StatelessWidget {
  final String text;
  final VoidCallback callbackOnPressed;
  final double width;
  final bool active;

  ButtonDayWidget(
      {Key key,
      @required this.text,
      @required this.callbackOnPressed,
      this.width = 150.0,
      this.active = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.callbackOnPressed,
      child: Container(
        height: 20.0,
        margin: EdgeInsets.only(right: 10),
        width: this.width,
        decoration: BoxDecoration(
          gradient: (!active)
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF3f1d9d),
                    Color(0xFF5937b2)
                  ], // whitish to gray
                  tileMode:
                      TileMode.mirror, // repeats the gradient over the canvas
                )
              : LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xfff94849),
                    Color(0xfffbd52b)
                  ], // whitish to gray
                  tileMode:
                      TileMode.mirror, // repeats the gradient over the canvas
                ),
          borderRadius: BorderRadius.circular(30.0),
          //color: Colors.transparent,
        ),
        child: Center(
          child: Text(
            this.text,
            style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}
