import 'package:easygymclub/EasyFit/bloc/contador_google_maps_bloc.dart';
import 'package:easygymclub/EasyFit/bloc/cronometros_bloc.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class ChronometerMap extends StatefulWidget {
  @override
  _ChronometerMapState createState() => _ChronometerMapState();
}

class _ChronometerMapState extends State<ChronometerMap> {
  ContadorGoogleMapsBloc _contadorEjercicioBloc;

  @override
  Widget build(BuildContext context) {
    _contadorEjercicioBloc = BlocProvider.of<ContadorGoogleMapsBloc>(context);
    final _cronometrosBloc = BlocProvider.of<CronometrosBloc>(context);

    return StreamBuilder(
      stream: _contadorEjercicioBloc.tiempo,
      builder: (context,snap){

        if(!snap.hasData || snap.hasError){
          return Text("--:--:--",
            style: TextStyle(
                color: Colors.white
            ),
          );
        }else{
          _cronometrosBloc.setTiempo("${StopWatchTimer.getDisplayTime(snap.data)}"); 
          return Text("${StopWatchTimer.getDisplayTime(snap.data)}",
            style: TextStyle(
                color: Colors.orangeAccent,
                fontWeight: FontWeight.bold
            ),);
        }
      },
    );
  }
}


