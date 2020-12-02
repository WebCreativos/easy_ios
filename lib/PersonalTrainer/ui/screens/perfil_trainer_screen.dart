import 'package:flutter/material.dart';
import 'package:easygymclub/User/model/user_model.dart';
import 'package:url_launcher/url_launcher.dart';

class PerfilTrainerScreen extends StatelessWidget{

  UserModel personalTrainer;
  int position;

  PerfilTrainerScreen({
    Key key,
    this.personalTrainer,
    this.position
  });
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.keyboard_arrow_left) ,
            color: Colors.white,
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            "Perfil",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xff3F1D9D),
        ),
        backgroundColor: Color(0xff260d6c),
        body: Container(
          child: _body(context),
        )
    );
  }
  Widget _body(BuildContext context) {

    return Container(
      child: Center(
          child: Container(
            margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: (this.personalTrainer.imagen_perfil!=null)? 
                    NetworkImage(this.personalTrainer.imagen_perfil):
                    NetworkImage("https://image.shutterstock.com/image-vector/male-avatar-profile-picture-vector-260nw-149083895.jpg"),
                  radius: MediaQuery.of(context).size.width * 0.15,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("${position.toString()} ",style:TextStyle(color: Colors.white)),
                      Icon(Icons.bookmark, color: Colors.white,)
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.account_circle,color: Colors.white),
                      Text(this.personalTrainer.nombre,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)
                    ],
                  ),
                ),
                InkWell(
                  onTap: () => launch("tel:://${this.personalTrainer.celular.toString()}"),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.call,color: Colors.white),
                        Text(this.personalTrainer.celular.toString(),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.white))
                  ),
                ),
                Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.5),
                      color: Colors.white,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF3f1d9d),
                          Color(0xFF5937b2)
                        ], // whitish to gray
                        tileMode:
                            TileMode.mirror, // repeats the gradient over the canvas
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 15.0,
                            spreadRadius: 0.3
                        )
                      ],
                    ),
                    padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
                    child: Text(this.personalTrainer.data_info_cliente["descripcion"],
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    )
                )
              ],
            ),
          )
      ),
    );
  }

}