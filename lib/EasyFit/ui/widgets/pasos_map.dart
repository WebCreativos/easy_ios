import 'dart:async';

import 'package:easygymclub/EasyFit/bloc/contador_google_maps_bloc.dart';
import 'package:easygymclub/EasyFit/bloc/cronometros_bloc.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:pedometer/pedometer.dart';
import 'dart:math';

class PasosMap extends StatefulWidget {
  @override
  _PasosMapState createState() => _PasosMapState();
}

class _PasosMapState extends State < PasosMap > {
  ContadorGoogleMapsBloc _contadorEjercicioBloc;

  @override
  Widget build(BuildContext context) {
    _contadorEjercicioBloc = BlocProvider.of<ContadorGoogleMapsBloc>(context);

    return StreamBuilder < bool > (
      stream: _contadorEjercicioBloc.startMap,
      builder: (context, snap) {
        if (!snap.hasData || snap.hasError) {
          return OfflinePasos();
        } else {
          if(snap.data)
            return ContadorPasos();
          return OfflinePasos();
        }
      },
    );
  }
}


class OfflinePasos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: < Widget > [
          Text(
            "0",
            style: TextStyle(color: Colors.greenAccent, fontSize: 30, fontWeight: FontWeight.w300),
          ),
          Text("0 Kcal",
            style: TextStyle(color: Colors.red[400], fontSize: 22, fontWeight: FontWeight.w300),
          ),
          Text("0 Km",
            style: TextStyle(color: Colors.blue[400], fontSize: 20, fontWeight: FontWeight.w300),
          ),
        ]
    );
  }
}

class ContadorPasos extends StatefulWidget {
  AsyncSnapshot snap;

  ContadorPasos({
    Key key,
    this.snap
  });

  @override
  State < StatefulWidget > createState() {
    return _ContadorPasosState();
  }
}

class _ContadorPasosState extends State < ContadorPasos > {
  Pedometer _pedometer;
  StreamSubscription<int> _subscription;

  double _km = 0.0;
  double _kmx;
  int _cantidadDePasos = 0;
  int _auxcantidadDePasos = 0;
  double _calories = 0.0;
  bool firstValue = false;

  void getDistanceRun() {
    var distance = ((_cantidadDePasos * 78) / 100000);
    distance = num.parse(distance.toStringAsFixed(2)); //dos decimales
    var distancekmx = 0.04 * _cantidadDePasos; //34;
    distancekmx = num.parse(distancekmx.toStringAsFixed(2));
    //print(distance.runtimeType);
    setState(() {
      _km = distance;
    });
    setState(() {
      _kmx = distancekmx;
    });
  }

  void getBurnedRun() {
    setState(() {
      _calories = _kmx == null ? 0 : _kmx;
    });
  }

  @override
  void initState() {
    _pedometer = Pedometer();
    getDistanceRun();
    getBurnedRun();
    _subscription = _pedometer.pedometerStream.listen((cantidadDePasos) {
      if(_auxcantidadDePasos == 0){
        _auxcantidadDePasos = cantidadDePasos;
      }
      setState(() {
        _cantidadDePasos = cantidadDePasos - _auxcantidadDePasos;
      });
      getDistanceRun();
      getBurnedRun();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _cronometrosBloc = BlocProvider.of < CronometrosBloc > (context);
    _cronometrosBloc.setPasos(_cantidadDePasos);
    _cronometrosBloc.setDistancia(_km);
    _cronometrosBloc.setCalorias(_calories);
    return Column(
        children: < Widget > [
          Text(
            "$_cantidadDePasos",
            style: TextStyle(color: Colors.greenAccent, fontSize: 30, fontWeight: FontWeight.w300),
          ),
          Text(int.parse(_calories.toStringAsFixed(0)).toString() + " Kcal",
            style: TextStyle(color: Colors.red[400], fontSize: 22, fontWeight: FontWeight.w300),
          ),
          Text(_km.toString() + " Km",
            style: TextStyle(color: Colors.blue[400], fontSize: 20, fontWeight: FontWeight.w300),
          ),
        ]
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
