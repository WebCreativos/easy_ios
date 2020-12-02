import 'package:easygymclub/Musica/bloc/spotify_bloc.dart';
import 'package:easygymclub/Musica/widget/spotify_player.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class SpotifyLoginScreen extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _SpotifyLoginScreen();
  }

}

class _SpotifyLoginScreen extends State<SpotifyLoginScreen>{

  final SpotifyBloc _spotifyBloc = SpotifyBloc();
  final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();


  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      bloc: _spotifyBloc,
      child: _checkStatus(),
    );
  }

  Widget _checkStatus(){

    return StreamBuilder(
      stream: _spotifyBloc.isConnected(),
      builder: (context,snap){

        if(!snap.hasData || snap.hasError){
          return Container(
            child: Center(
              child: Text("Error"),
            ),
          );
        }else{
          return _body(snap);
        }

      },
    );
  }

  Widget _body(AsyncSnapshot snap){

    bool connected = snap.data;
    if(connected){

      return SpotifyPlayer();
    }else{

      return Container(
        margin: EdgeInsets.all(5.0),
        child: Center(
          child: RoundedLoadingButton(
            child: Text("Iniciar con Spotify",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
            ),
            controller: _btnController,
            color: Color(0xff1DB954),
            onPressed: () => _spotifyBloc.connectToSpotify(),
          ),
        ),
      );

    }
  }

}