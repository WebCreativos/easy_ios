import 'package:easygymclub/EasyFit/bloc/contador_google_maps_bloc.dart';
import 'package:easygymclub/EasyFit/repository/contador_google_maps_repository.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:easygymclub/EasyFit/bloc/cronometros_bloc.dart';
class PlayMap extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {

    return _PlayMap();
  }

}

class _PlayMap extends State<PlayMap>{
  ContadorGoogleMapsBloc _contadorEjercicioBloc;

  @override
  Widget build(BuildContext context) {
    _contadorEjercicioBloc = BlocProvider.of<ContadorGoogleMapsBloc>(context);
      final _cronometrosBloc = BlocProvider.of<CronometrosBloc>(context);

    return StreamBuilder<ButtonState>(
      stream: _contadorEjercicioBloc.buttonState,
      builder: (context, snap) {
        return AnimatedSwitcher(
          duration: const Duration(seconds: 1),
          child: () {
            switch (snap.data) {
              case ButtonState.stop:
              case ButtonState.pausa:
                return FloatingActionButton(
                  backgroundColor: Color(0xFF5937b2),
                  child: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _contadorEjercicioBloc.startTimer();
                  } ,
                  elevation: 0.0,
                  heroTag: "btnStart",
                );

              case ButtonState.start:
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FloatingActionButton(
                      backgroundColor: Color(0xFF5937b2),
                      child: Icon(
                        Icons.pause,
                        color: Colors.white,
                      ),
                      onPressed: () => _contadorEjercicioBloc.pauseTimer(),
                      elevation: 0.0,
                      heroTag: "btnPause",
                    ),
                    FloatingActionButton(
                      backgroundColor: Color(0xFF5937b2),
                      child: Icon(
                        Icons.stop,
                        color: Colors.white,
                      ),
                      onPressed: (){
                        _cronometrosBloc.saveCronometro();
                        _contadorEjercicioBloc.stopTimer();
                      } ,
                      elevation: 0.0,
                      heroTag: "btnStop",
                    ),
                  ],
                );

              default:
                return FloatingActionButton(
                  child: Icon(
                    Icons.error,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.red,
                  onPressed: null,
                );
            }
          }(),
        );
      },
    );
  }

}