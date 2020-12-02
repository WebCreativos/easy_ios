import 'package:easygymclub/Rutinas/bloc/rutinas_bloc.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class RutinasTerminadas extends StatefulWidget{

  int cantidadRutinas;

  RutinasTerminadas({Key key, this.cantidadRutinas});

  @override
  State<StatefulWidget> createState() {
    return _RutinasTerminadas();
  }

}

class _RutinasTerminadas extends State<RutinasTerminadas>{

  RutinasBloc _rutinasBloc;
  int _ejerciciosListos;

  @override
  void initState() {
    super.initState();
    Future((){
      _rutinasBloc = BlocProvider.of<RutinasBloc>(context);
      _rutinasBloc.realizandoEjercicio.listen(
          (indexEjercicio){
            setState(() {
              _ejerciciosListos = indexEjercicio;
            });
          }
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    return Container(
        padding: EdgeInsets.only(top:20),
        child:Text(
          "Rutinas terminadas:" +
              this._ejerciciosListos.toString() +
              "/" +
              widget.cantidadRutinas.toString(),
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20),
          textAlign: TextAlign.center,
        ));
  }

}