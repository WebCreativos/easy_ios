import 'package:easygymclub/Rutinas/bloc/rutinas_bloc.dart';
import 'package:easygymclub/Rutinas/ui/screens/empezar_rutina.dart';
import 'package:easygymclub/Rutinas/ui/widgets/ejercicio_de_rutina.dart';
import 'package:flutter/material.dart';
import 'package:easygymclub/Rutinas/ui/widgets/button_day.dart';
import 'package:easygymclub/widgets/custom_button.dart';
import 'package:easygymclub/Rutinas/model/rutinas_model.dart';
import 'package:easygymclub/Rutinas/ui/widgets/ejercicio.dart';
class RutinasIndividual extends StatefulWidget {
  @override
  RutinasModel rutina;
  _RutinasIndividualState createState() => _RutinasIndividualState();
  RutinasIndividual({
          Key key,
          this.rutina
        }
      ); 
}
class _RutinasIndividualState extends State<RutinasIndividual> {

  RutinasBloc _rutinasBloc;

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

  @override
  void initState() {
    _rutinasBloc = RutinasBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff3F1D9D),
          title: Text(widget.rutina.nombre),
          leading: IconButton(
            icon: Icon(Icons.keyboard_arrow_left, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SafeArea(
          child: Container(
            height: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/img/bgr.png"),
                    fit: BoxFit.cover)),
            child: ListView(
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Text(
                            "Elige un dia",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          )),
                      listaDias(),
                      Container(
                          height: MediaQuery.of(context).size.height * 0.7,
                          width: double.infinity,
                          alignment: Alignment.topCenter,
                          child: empezarRutinaWidget()),
                    ],
                  ),
          ),
        ));
  }

  Widget listaDias() {
    List<Widget> list = new List<Widget>();
    widget.rutina.rutinas.forEach((dia,k){
      list.add(ButtonDay(
        text: dia,
        callbackOnPressed: () {
          setState(() {
            this.diaSeleccionado = dia;
          });
        },
        active: dia == this.diaSeleccionado,
      ));

    });
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 60,
      child: ListView(
        padding: EdgeInsets.only(top: 20.0),
        children: list,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget empezarRutinaWidget() {
    return Column(
      children: <Widget>[
        Center(
          heightFactor: 3,
          child: Column(
            children: <Widget>[
              Text(
                "Empezar rutina del " + this.diaSeleccionado[0].toUpperCase() + this.diaSeleccionado.substring(1),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
              Container(
                  margin: EdgeInsets.only(top: 20),
                  child: InkWell(
                    onTap: () { 
                      setState(() {
                      });
                    },
                    child: (empezarRutina)? _cargandoRutinas():_verEjercicios(widget.rutina.rutinas[this.diaSeleccionado])
                  ))
            ],
          ),
        ),
      ],
    );
  }

  Widget _cargandoRutinas(){

    if(this.cargandoRutina){
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }else{
      return Container(
        height: 50.0,
        width: 150,
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.transparent)],
            gradient: LinearGradient(
              colors: [Color(0xfff94849), Color(0xfffbd52b)],
            ),
            borderRadius: BorderRadius.circular(30.0),
            //color: Colors.transparent,
            border: Border.all()),
        child: Center(
          child: Text(
            "Empezar",
            style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.w700),
          ),
        ),
      );
    }


  }
  Widget _verEjercicios(List auxlist){


    List<Widget> listaARetornar = List<Widget>();


    var index = 0;
    List<Widget> ejercicios = auxlist.map(
        (rutina){
          var widget = Container( 
              child: Ejercicio(
                rutina: rutina,
              )
          );
          index++;
          return widget;
        }
    ).toList();

    //Cantidad de ejercicios antes de agregar a la ListView los demas mensajes
    listaARetornar.add(Container(
      padding: EdgeInsets.only(bottom: 15.0,top:15.0),
      child: Text(
        "Rutina del " + this.diaSeleccionado,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
      ),
    ));
    listaARetornar.addAll(ejercicios);




    return Column(children:listaARetornar);

  }



}
