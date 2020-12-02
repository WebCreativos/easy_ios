import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActividadesAgendadas extends StatefulWidget {
  // Lista de actividades del dia

  final List<Map<String, dynamic>> actividades;

  const ActividadesAgendadas({Key key, this.actividades}) : super(key: key);

  @override
  _ActividadesAgendadasState createState() => _ActividadesAgendadasState();
}

class _ActividadesAgendadasState extends State<ActividadesAgendadas> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
      margin: EdgeInsets.only(
          right: MediaQuery.of(context).size.width * 0.04,
          left: MediaQuery.of(context).size.width * 0.04,
          bottom: MediaQuery
              .of(context)
              .size
              .width * 0.02
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Color(0xff04E0BA),
              Color(0xff0283DA)
            ]
        ),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ListView(
        //mainAxisAlignment: MainAxisAlignment.center,

        children: _body(),
      ),
    );
  }

  List<Widget> _body() {
    List<Widget> list = [];

    list = widget.actividades.map((actividad) => Container(
      margin: EdgeInsets.all(1.0),
      child: Row(
        children: <Widget>[
          Text(
            actividad['hora'],
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500
            ),
          ),
          Text(
            " | ",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400
            ),
          ),
          Expanded(
            child: Text(
              actividad['actividad'],
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    )).toList();

    return list;
  }
}
