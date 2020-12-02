import 'dart:async';

import 'package:easygymclub/Rutinas/model/rutinas_model.dart';
import 'package:easygymclub/Rutinas/ui/screens/empezar_rutina.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:better_player/better_player.dart';

class RutinasIndividualScreen extends StatefulWidget {
  final RutinasModel rutina;

  @override
  _RutinasIndividualScreenState createState() => _RutinasIndividualScreenState();

  RutinasIndividualScreen({
    Key key,
    this.rutina
  });
}
class _RutinasIndividualScreenState extends State < RutinasIndividualScreen > {

  String diaSeleccionado = "lunes";
  bool empezarRutina = false;
  bool cargandoRutina = false;
  var dias = [
    "lunes",
    "martes",
    "miercoles",
    "jueves",
    "viernes",
    "sabado",
    "domingo"
  ];
  Timer _timer;
  int _start = 10;

  void startTimer() {
    const oneSec =
      const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  @override
  void initState() {
    this.diaSeleccionado = (widget.rutina.tipo_rutina!='Rutina unica')? this.dias[DateTime.now().weekday -1]:'lunes';
    super.initState();
  }

  void dispose() {
    try {
      _timer.cancel();
    } catch (e) {
      print(e);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.transparent)],
            gradient: LinearGradient(
              colors: [Color(0xFF3f1d9d), Color(0xFF5937b2)],
              begin: Alignment.centerLeft,
              end: Alignment.bottomRight
            ),
          ),
          child:
          Stack(
            children: < Widget > [
              ListView(
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 90),
                children: < Widget > [
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: IconButton(
                      icon: Icon(Icons.keyboard_arrow_left, color: Colors.white,
                        size: 40.0, ),
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: Text(
                      "Rutina del \n dia",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    )),
                  SizedBox(height: 20),
                  if(widget.rutina.tipo_rutina!='Rutina unica')
                    listaDias(), 
                  ejercicios(widget.rutina.rutinas[this.diaSeleccionado], context)

                ],
              ),
              Positioned(child: empezarRutinaWidget(), bottom: 0),
            ],
          )
        ),
      ));
  }

  Widget listaDias() {
    List < Widget > list = new List < Widget > ();
    int index = 0;
    dias.forEach((dia, ) {
      index++;
      list.add(
        Column(children: < Widget > [
          Center(
            child: Text(
              dia[0].toUpperCase(),
              style:
              TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold
              ),
            ),
          ),
          Center(child: Radio(
            value: 1,
            activeColor: Colors.red,
            groupValue: (index == DateTime.now().weekday) ? 1 : 0, onChanged: (int value) {},
          )),
          if (index == DateTime.now().weekday)
            Icon(Icons.arrow_drop_up, color: Colors.white, )
        ], )
      );
    });
    return Container(
      alignment: Alignment.center,
      height: 130,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: list,
      ),
    );
  }

  Widget empezarRutinaWidget() {
    return
    Container(
      width: MediaQuery.of(context).size.width,
      height: 70,
      decoration: BoxDecoration(
        color: Color(0xFF5937b2),
        boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 3, spreadRadius: 2), ]
      ),
      child: Center(
        child: InkWell(
          onTap: () {
            setState(() {
              this.cargandoRutina = true;
              this.cargandoRutina = false;
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => EmpezarRutina(
                  ejercicios: widget.rutina.rutinas[this.diaSeleccionado],
                )
              ));
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF3f1d9d),
              boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 3, spreadRadius: 2), ]
            ),
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: < Widget > [
                Text(
                  "Empezar rutina",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 20),
                ),
                Icon(Icons.play_arrow)
              ],
            ),
          ),
        ),
      )
    );
  }


  Widget ejercicios(List ejercicios, BuildContext context) {
    List auxEjercicios = new List < Widget > ();
    int index = 1;

    if (ejercicios != null) {
      auxEjercicios.add(
        Divider(color: Colors.white, height: 1)
      );
      ejercicios.forEach((ejercicio) {
        auxEjercicios.add(
          InkWell(
            onTap: () {
              this._settingModalBottomSheet(
                context, ejercicio, ejercicio['nombre']);
            },
            child: Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              color: Colors.transparent,
              child: ListTile(

                title: Text("${ejercicio['series']} x ${ejercicio['nombre']}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 20), ),
                leading: (ejercicio["video"] != null && ejercicio["video"] != "") ?
                Icon(
                  Icons.ondemand_video,
                  color: Colors.black12,
                ) :
                null,
              ),
            )
          ),
        );
        auxEjercicios.add(
          Divider(color: Colors.white, height: 1)
        );
      });
      index++;
    } else {
      auxEjercicios.add(
        ListTile(
            title: Text("No hay rutinas para este dia", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 20), ),
          )
        );
    }
    return Container(
      alignment: Alignment.topCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: auxEjercicios
      ));
  }

  void _settingModalBottomSheet(context, data, nombre) {
    Widget youtubeWidget;



    if (data["video"] != null && data["video"] != "") {
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.NETWORK, data["video"]);

    BetterPlayerController _betterPlayerController = BetterPlayerController(
      BetterPlayerConfiguration(),
      betterPlayerDataSource: betterPlayerDataSource);
      youtubeWidget = AspectRatio(
        aspectRatio: 16 / 9,
        child: BetterPlayer(
          controller: _betterPlayerController,
        ),
      );
    }

    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: new Wrap(
            children: < Widget > [
              (data["video"] != null) ? youtubeWidget : SizedBox.shrink(),
              ListTile(
                title: new Text(
                  nombre.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Divider(color: Colors.black, height: 2, ),
              ),
              (data["descripcion"] != null) ? Column(
                children: [
                  Text("descripción: ", style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.left, ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                      child: Text(data["descripcion"]),
                  )
                ],
              ) : SizedBox.shrink()
            ],
          ),
        );
      }
    );
  }


}