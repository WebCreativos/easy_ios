import 'package:countdown_flutter/countdown_flutter.dart';
import 'package:easygymclub/Rutinas/bloc/rutinas_bloc.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class Contador extends StatefulWidget {
  int tiempoDeEjercicio;
  int tiempoDeDescanzo;
  int cantidadDeEjercicios;

  Contador(
      {Key key,
      this.tiempoDeEjercicio,
      this.tiempoDeDescanzo,
      this.cantidadDeEjercicios});

  @override
  State<StatefulWidget> createState() {
    return _Contador();
  }
}

class _Contador extends State<Contador> {
  bool _haciendoEjercicio = true;

  RutinasBloc _rutinasBloc;

  @override
  Widget build(BuildContext context) {

    _rutinasBloc = BlocProvider.of<RutinasBloc>(context);

    return StreamBuilder(
      stream: _rutinasBloc.realizandoEjercicio,
      builder: (context, snap) {

        if (!snap.hasData || snap.hasError) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return Container(
            child: Center(child: _body(snap)),
          );
        }
      },
    );
  }

  Widget _body(AsyncSnapshot snapshot) {
    int ejercicioIndex = snapshot.data;

    if (ejercicioIndex == widget.cantidadDeEjercicios) {
      return Text(
        "Rutina terminada!",
        style: TextStyle(color: Colors.white, fontSize: 30.0),
      );
    }

    if (_haciendoEjercicio) {
      //Ejercicio

      return Countdown(
        key: UniqueKey(),
        duration: Duration(
          seconds: widget.tiempoDeEjercicio,
        ),
        onFinish: () {
          this._haciendoEjercicio = !this._haciendoEjercicio;
          _rutinasBloc.makeSound();
          _rutinasBloc.setEjercicioListo(++ejercicioIndex);
        },
        builder: (BuildContext ctx, Duration remaining) {
          //_rutinasBloc.makeSound();
          return Text(
            '${remaining.inSeconds}',
            style: TextStyle(color: Colors.white, fontSize: 50.0),
          );
        },
      );
    } else {
      //Descanzo

      return Countdown(
        key: UniqueKey(),
        duration: Duration(seconds: widget.tiempoDeDescanzo),
        onFinish: () {
          setState(() {
            this._haciendoEjercicio = !this._haciendoEjercicio;
            _rutinasBloc.makeSound();
          });
        },
        builder: (BuildContext ctx, Duration remaining) {
          return Text(
            '${remaining.inSeconds}',
            style: TextStyle(color: Colors.orangeAccent, fontSize: 50.0),
          );
        },
      );
    }
  }

}
