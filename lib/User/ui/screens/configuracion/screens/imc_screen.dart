import 'package:easygymclub/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class ImcScreen extends StatelessWidget{

  final double imc;

  ImcScreen(
      this.imc
      );

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left) ,
          color: Colors.white,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Índice corporal",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xff3F1D9D),
      ),
      body: Container(
        color: Color(0xff260D6C),
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Container(
                child: Text(
                    "Aenean posuere, tortor sed cursus feugiat, nunc augue blandit nunc, eu sollicitudin urna dolor sagittis lacus. Vestibulum purus quam, scelerisque ut, mollis sed, nonummy id, metus. Suspendisse faucibus, nunc et pellentesque egestas, lacus ante convallis tellus, vitae iaculis lacus elit id tortor. Fusce ac felis sit amet ligula pharetra condimentum. Ut non enim eleifend felis pretium feugiat.",
                  style: TextStyle(color:Colors.white),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text("Categorías de IMC:",style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold),),
                    Text("Debajo =< 18.5",style: TextStyle(color:Colors.white),),
                    Text("Normal = 18.5 ~ 24.9",style: TextStyle(color:Colors.white),),
                    Text("Sup. al normal = 25 ~ 29.9",style: TextStyle(color:Colors.white),),
                    Text("Obesidad = +30",style: TextStyle(color:Colors.white),)
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("IMC =",style: TextStyle(color: Color(0xff5937B2),fontWeight: FontWeight.bold),),
                    Column(
                      children: <Widget>[
                        Text("masa (kg)",style: TextStyle(color: Color(0xff5937B2)),),
                        Divider(color: Colors.white,thickness: 20.0,),
                        Text("altura (m)",style: TextStyle(color: Color(0xff5937B2)),)
                      ],
                    )
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("El índice de tu cuerpo: ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                Text("Bajo peso",style: TextStyle(color: Colors.orangeAccent,fontWeight: FontWeight.bold),)
              ],
            ),
            Text(this.imc.toString(),style: TextStyle(
              color: Colors.orangeAccent,
              fontSize: 40.0,
              fontWeight: FontWeight.bold
            ),),
          ],
        )
      ),
    );

}