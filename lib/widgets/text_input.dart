import 'package:flutter/material.dart';

class TextInput extends StatefulWidget{

  final String hintText;
  final TextInputType inputType;
  final TextEditingController controller;
  final IconData iconData;
  final bool itIsPassword;
  final bool border;
  int maxLines;

  TextInput({
    Key key,
    @required this.hintText,
    @required this.inputType,
    @required this.controller,
    this.iconData,
    this.itIsPassword = false,
    this.maxLines = 1,
    this.border = true
  });

  @override
  State<StatefulWidget> createState() {
    return _TextInput();
  }

}

class _TextInput extends State<TextInput>{

  @override
  Widget build(BuildContext context) {

    return Container(
      child: TextField(
        controller: widget.controller,
        keyboardType: widget.inputType,
        maxLines: widget.maxLines,
        obscureText: widget.itIsPassword,
        style: TextStyle(
            fontSize: 15.0,
            color: Colors.white,
            fontWeight: FontWeight.w300
        ),
        decoration: InputDecoration(
            icon: (widget.iconData == null) ? null : Icon(
              widget.iconData, color: Color(0xffFA6C42),),
            filled: false,
            border: InputBorder.none,
            hintText: widget.hintText,
            hintStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400
            ),
            enabledBorder: (widget.border) ? UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Color(0xFF5937b2),
                    width: 1.0,
                    style: BorderStyle.solid
                )
            ) : null,
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.white70,
                    width: 2.0,
                    style: BorderStyle.solid
                )
            )

        ),
      ),

    );
  }

}