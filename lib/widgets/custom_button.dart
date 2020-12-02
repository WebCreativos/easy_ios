import 'package:easygymclub/User/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

final Shader textNameApp = LinearGradient(
  colors: <Color>[Color(0xffFA6C42),Color(0xfffbd52b)],
).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

class CustomButton extends StatelessWidget{

  final String text;
  final bool colorBg;
  VoidCallback callbackOnPressed;
  Border border;
  var width;


  CustomButton({
    Key key,
    @required this.text,
    @required this.callbackOnPressed,
    this.colorBg = false,
    this.border,
    this.width = 150.0
  });

  @override
  Widget build(BuildContext context) {

    UserBloc userBloc = BlocProvider.of(context);

    return InkWell(
      onTap: this.callbackOnPressed,
      child: Container(
        height: 50.0,
        width: this.width,
        decoration: BoxDecoration(
          boxShadow: [
            (colorBg) ? BoxShadow(
              color: Color(0xfffbd52b),
              blurRadius: 5.0,
              spreadRadius: 0.3
            ) : BoxShadow(
              color: Colors.transparent
            )
          ],
          borderRadius: BorderRadius.circular(30.0),
          //color: Colors.transparent,
          gradient: (colorBg) ? LinearGradient(
            colors: [
              Color(0xfff94849),
              Color(0xfffbd52b)
            ],
          ) : null,
          border: this.border
        ),
        child: Center(
          child: Text(
            this.text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.0,
              fontWeight: FontWeight.w700
            ),
          ),
        ),
      ),
    );
  }

}
