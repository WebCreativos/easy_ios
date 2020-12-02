import 'package:flutter/material.dart';

class RetoGym extends StatefulWidget{

  String nombre;
  int cantidadPuntos;

  RetoGym({Key key,this.nombre,this.cantidadPuntos});

  @override
  State<StatefulWidget> createState() {
    return _RetoGym();
  }
}

class _RetoGym extends State<RetoGym> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          right: MediaQuery.of(context).size.width * 0.03
      ),
      width: MediaQuery.of(context).size.width * 0.3,
      decoration: BoxDecoration(
        borderRadius:  BorderRadius.circular(15.0),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF3f1d9d ), Color(0xFF5937b2)], // whitish to gray
            tileMode: TileMode.mirror, // repeats the gradient over the canvas

          ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x0000004a),
            spreadRadius: 1.0,
            blurRadius: 5.0,
            offset: Offset(5.0,10.0)
          )
        ]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Icon(Icons.opacity,color: Colors.white,),
          Text(widget.nombre,style: TextStyle(color: Colors.white),),
          Text("+ ${widget.cantidadPuntos} puntos",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400))
        ],
      ),
    );
  }
}
