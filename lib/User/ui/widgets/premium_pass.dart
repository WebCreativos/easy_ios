import 'package:easygymclub/User/ui/widgets/premium_pass_logic_comunication/pp_logic.dart';
import 'package:flutter/material.dart';

class PremiumPass extends StatefulWidget {
  @override
  _PremiumPassState createState() => _PremiumPassState();
}

class _PremiumPassState extends State<PremiumPass> {

  final PPLogic _ppLogic = PPLogic();

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xff7860ba),
          width: 4.0,
        ),
        borderRadius: BorderRadius.all(
            Radius.circular(5.0)
        ),
      ),
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                'SE PREMIUM!',
                style: TextStyle(
                    fontSize: 20.4,
                    fontWeight: FontWeight.bold,
                    foreground: Paint()
                      ..shader = LinearGradient(
                        colors: <Color>[
                          Color(0xffffd100),
                          Color(0xfffff9d4),
                          Color(0xffd4af37)
                        ],
                      ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0))),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.check_circle_outline,
                      color: Colors.white,
                    ),
                    SizedBox(width: 5.0,),
                    Text(
                      "Todas las rutinas",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 17.0,
                          color: Colors.white
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.check_circle_outline,
                      color: Colors.white,
                    ),
                    SizedBox(width: 5.0,),
                    Text(
                      "Todas las dietas",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 17.0,
                          color: Colors.white
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.check_circle_outline,
                      color: Colors.white,
                    ),
                    SizedBox(width: 5.0,),
                    Text(
                      "Control total de su actividad fisica",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 17.0,
                          color: Colors.white
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.check_circle_outline,
                      color: Colors.white,
                    ),
                    SizedBox(width: 5.0,),
                    Text(
                      "Retos y desafios",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 17.0,
                          color: Colors.white
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.check_circle_outline,
                      color: Colors.white,
                    ),
                    SizedBox(width: 5.0,),
                    Text(
                      "Galeria de profesionales",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 17.0,
                          color: Colors.white
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.check_circle_outline,
                      color: Colors.white,
                    ),
                    SizedBox(width: 5.0,),
                    Text(
                      "Control de asistencia de actividades",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 17.0,
                          color: Colors.white
                      ),
                    )
                  ],
                ),
              ),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.check_circle_outline,
                        color: Colors.white,
                      ),
                      SizedBox(width: 5.0,),
                      Flexible(
                        child: Text(
                          "Aula de streaming con tus profesores en directo",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 17.0,
                              color: Colors.white
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.access_time,
                      color: Colors.yellowAccent.shade100,
                    ),
                    SizedBox(width: 5.0,),
                    Expanded(
                      child: Text(
                        "Integracion de sus propias listas musicales ( proximamente )",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 17.0,
                            color: Colors.white
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.access_time,
                      color: Colors.yellowAccent.shade100,
                    ),
                    SizedBox(width: 5.0,),
                    Expanded(
                      child: Text(
                        "Publicidad del interes del usuario en el caso de que este quiera ( proximamente )",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 17.0,
                            color: Colors.white
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.access_time,
                      color: Colors.yellowAccent.shade100,
                    ),
                    SizedBox(width: 5.0,),
                    Expanded(
                      child: Text(
                        "Reserva de canchas y/o espacios deportivos ( proximamente )",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 17.0,
                            color: Colors.white
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.access_time,
                      color: Colors.yellowAccent.shade100,
                    ),
                    SizedBox(width: 5.0,),
                    Expanded(
                      child: Text(
                        "Tienda ( proximamente )",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 17.0,
                            color: Colors.white
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.access_time,
                      color: Colors.yellowAccent.shade100,
                    ),
                    SizedBox(width: 5.0,),
                    Text(
                      "Descuentos ( proximamente )",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 17.0,
                          color: Colors.white
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                "Para ser premium, tienes que estar asociado a alguno de los siguientes gimnasios* :",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 17.0,
                    color: Colors.white
                ),
              ),
              ),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                child: _gimnasiosDisponibles()
              ),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                      "*Los gimnasios que se muestran estan en un radio de 10 km de usted",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                      fontSize: 10.0
                    ),
                  )
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _gimnasiosDisponibles(){

    return FutureBuilder(
      future: _ppLogic.availableGyms(),
      builder: (context,snap){

        if(!snap.hasData){
          return CircularProgressIndicator();
        }else{

          List<String> aux_list = snap.data;
          List<Widget> resp = List<Widget>();

          resp = aux_list.map((nombreGym) => Text(
            nombreGym,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 17.0,
                color: Colors.white
            ),
          )).toList();

          return Column(
            children: resp,
          );
        }

      },
    );
  }

}
