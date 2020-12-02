import 'dart:math';

import 'package:easygymclub/User/bloc/ranking_bloc.dart';
import 'package:easygymclub/User/ui/screens/mi_ranking/widgets/reto_gym.dart';
import 'package:flutter/material.dart';
import 'package:easygymclub/Gym/Main/model/metas_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class ListRetos extends StatefulWidget {

  Future < List < MetasModel >> metas;
  String title;

  @override
  ListRetos({
    Key key,
    this.metas,
    this.title
  });

  State < StatefulWidget > createState() {
    return _ListRetos();
  }

}

class _ListRetos extends State < ListRetos > {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.metas,
      builder: (context, snap) {

        if (!snap.hasData || snap.hasError) {
          return _loading();
        } else {

          switch (snap.connectionState) {

            case ConnectionState.none:
            case ConnectionState.waiting:
              return _loading();
              break;
            case ConnectionState.active:
            case ConnectionState.done:
              return _body(snap);
              break;
          }
        }

        return null;
      },
    );
  }

  Widget _body(AsyncSnapshot snap) {

    List < MetasModel > listRetos = snap.data;

    if(listRetos.isEmpty){
      return Container(
        height: MediaQuery.of(context).size.height * 0.18,
        margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.01,
            bottom: MediaQuery.of(context).size.height * 0.02,
          left: MediaQuery.of(context).size.width * 0.03,
          right: MediaQuery.of(context).size.width * 0.03
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xff7860ba),
            width: 2.0,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(5.0)
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FaIcon(
                FontAwesomeIcons.frownOpen,
                color: Color(0xff7860ba),
              ),
              Text(
                "Aún no te has asociado a ningún gimnasio",
                style: TextStyle(
                    color: Color(0xff7860ba),
                    fontSize: 13.0,
                    fontWeight: FontWeight.w700
                ),
              )
            ],
          ),
        ),
      );
    }

    return Column(
      children: < Widget > [
        Container(
          padding: EdgeInsets.only(top:20,bottom:20),
          child:Text(
          widget.title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 22.0),
            textAlign: TextAlign.left,
        ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.01,
            bottom: MediaQuery.of(context).size.height * 0.02
          ),
          padding: EdgeInsets.only(
            left: 20,

          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.18,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: listRetos.length,
            itemBuilder: (context, int index) => RetoGym(cantidadPuntos: listRetos[index].puntos, nombre: listRetos[index].nombre),
          ),
        ),
      ],
    );
  }

  Widget _loading() {

    return Container(
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.01,
        bottom: MediaQuery.of(context).size.height * 0.02
      ),
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.1,
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.18,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: < Widget > [
          Container(
            margin: EdgeInsets.only(
              right: MediaQuery.of(context).size.width * 0.03
            ),
            padding: EdgeInsets.all(30.0),
            width: MediaQuery.of(context).size.width * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.orangeAccent,
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  spreadRadius: 1.0,
                  blurRadius: 5.0,
                  offset: Offset(5.0, 10.0)
                )
              ]
            ),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation < Color > (Colors.deepOrangeAccent),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              right: MediaQuery.of(context).size.width * 0.03
            ),
            padding: EdgeInsets.all(30.0),
            width: MediaQuery.of(context).size.width * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.orangeAccent,
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  spreadRadius: 1.0,
                  blurRadius: 5.0,
                  offset: Offset(5.0, 10.0)
                )
              ]
            ),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation < Color > (Colors.deepOrangeAccent),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              right: MediaQuery.of(context).size.width * 0.03
            ),
            padding: EdgeInsets.all(30.0),
            width: MediaQuery.of(context).size.width * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.orangeAccent,
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  spreadRadius: 1.0,
                  blurRadius: 5.0,
                  offset: Offset(5.0, 10.0)
                )
              ]
            ),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation < Color > (Colors.deepOrangeAccent),
            ),
          ),
        ],
      ),
    );
  }

}