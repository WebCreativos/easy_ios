import 'package:easygymclub/Musica/bloc/spotify_bloc.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class ButtonPlayStop extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {

    return _ButtonPlayStop();
  }

}

class _ButtonPlayStop extends State<ButtonPlayStop>{

  SpotifyBloc _spotifyBloc;

  @override
  Widget build(BuildContext context) {

    _spotifyBloc = BlocProvider.of<SpotifyBloc>(context);

    return Container(
      child: StreamBuilder<bool>(
        stream: _spotifyBloc.isPaused(),
        initialData: true,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {

          if (snapshot.hasData) {
            var isPaused = snapshot.data;

            if(isPaused){
              return IconButton(
                icon: Icon(
                    Icons.play_arrow,
                  color: Colors.white,
                ),
                onPressed: () => _spotifyBloc.resume(),
              );
            }else{
              return IconButton(
                icon: Icon(
                    Icons.pause,
                  color:Colors.white
                ),
                onPressed: () => _spotifyBloc.pause(),
              );
            }
          } else {
            return Center(
              child: Text(
                  "Not connected",
                style: TextStyle(
                  color:Colors.white
                ),
              ),
            );
          }

        },
      ),
    );
  }

}