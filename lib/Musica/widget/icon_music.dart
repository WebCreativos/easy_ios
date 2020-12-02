import 'package:avatar_glow/avatar_glow.dart';
import 'package:easygymclub/Musica/bloc/spotify_bloc.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';


class IconMusic extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _IconMusic();
  }

}

class _IconMusic extends State<IconMusic>{

  SpotifyBloc _spotifyBloc;

  @override
  Widget build(BuildContext context) {

    _spotifyBloc = BlocProvider.of<SpotifyBloc>(context);

    return StreamBuilder<bool>(
      stream: _spotifyBloc.isPaused(),
      initialData: true,
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          var isPaused = snapshot.data;

          if(isPaused){

            return AvatarGlow(
              key: UniqueKey(),
              endRadius: 80.0, //required
              child: Material( //required
                elevation: 8.0,
                shape: CircleBorder(),
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Image.asset(
                    'assets/img/spotify_logo.png', fit: BoxFit.cover,),
                  radius: 40.0,
                ),
              ),
              repeat: false,
              showTwoGlows: false,
              glowColor: Color(0xff1ed760),

            );
          }else{

            return AvatarGlow(
              key: UniqueKey(),
              endRadius: 80.0, //required
              child: Material( //required
                elevation: 8.0,
                shape: CircleBorder(),
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Image.asset(
                    'assets/img/spotify_logo.png', fit: BoxFit.cover,),
                  radius: 40.0,
                ),
              ),
              repeat: true,
              showTwoGlows: true,
              glowColor: Color(0xff1ed760),
              duration: Duration(seconds: 1),
            );
          }

        }else{
          return Text(
            "Not connected icon music",
            style: TextStyle(
              color: Colors.white
            ),
          );
        }
      }
    );
  }

}