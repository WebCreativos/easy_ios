import 'package:easygymclub/Musica/bloc/spotify_bloc.dart';
import 'package:easygymclub/Musica/widget/button_play_stop.dart';
import 'package:easygymclub/Musica/widget/icon_music.dart';
import 'package:easygymclub/Musica/widget/playlists.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:spotify_sdk/models/player_context.dart';
import 'package:spotify_sdk/models/player_state.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

class SpotifyPlayer extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _SpotifyPlayer();
  }

}

class _SpotifyPlayer extends State<SpotifyPlayer>{

  SpotifyBloc _spotifyBloc;

  @override
  Widget build(BuildContext context) {

    _spotifyBloc = BlocProvider.of<SpotifyBloc>(context);

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.only(
          left: 10.0,
          right: 10.0,
          top: 10.0
        ),
        child: Center(
          child: Column(
            children: <Widget>[
              IconMusic(),
              Divider(),
              PlayerContextWidget(),
              Divider(),
              PlayerStateWidget(),
              Divider(),
              PlayLists(),
              Container(
                margin: EdgeInsets.only(
                  top: 10.0
                ),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(5.0)
                  )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                          Icons.skip_previous,
                        color:Colors.white
                      ),
                      onPressed: () => _spotifyBloc.skipPrevious(),
                    ),
                    ButtonPlayStop(),
                    IconButton(
                      icon: Icon(
                          Icons.skip_next,
                          color:Colors.white
                      ),
                      onPressed: () => _spotifyBloc.skipNext(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}

Widget PlayerContextWidget() {
  return StreamBuilder<PlayerContext>(
    stream: SpotifySdk.subscribePlayerContext(),
    initialData: PlayerContext("", "", "", ""),
    builder: (BuildContext context, AsyncSnapshot<PlayerContext> snapshot) {
      if (snapshot.data != null && snapshot.data.uri != "") {
        var playerContext = snapshot.data;
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
                "Titulo: ${playerContext.title}",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800
              ),
              textAlign: TextAlign.center,
            ),
            Text(
                "${playerContext.subtitle}",
              style: TextStyle(
                  color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        );
      } else {
        return Center(
          child: Text(
              "Inicia tu reproductor en Spotify",
              style: TextStyle(
                color:Colors.white
              ),
          ),
        );
      }
    },
  );
}

Widget PlayerStateWidget() {

  return StreamBuilder<PlayerState>(
    stream: SpotifySdk.subscribePlayerState(),
    initialData: PlayerState(null, false, 1, 1, null, null),
    builder: (BuildContext context, AsyncSnapshot<PlayerState> snapshot) {
      if (snapshot.data != null && snapshot.data.track != null) {
        var playerState = snapshot.data;
        if(playerState.isPaused != null){
          BlocProvider.of<SpotifyBloc>(context).setStopOrPlay(playerState.isPaused);
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
                "${playerState.track.name} by ${playerState.track.artist.name} from the album ${playerState.track.album.name} ",
              style: TextStyle(
                  color: Colors.white
              ),
              textAlign: TextAlign.center,
            ),

          ],
        );
      } else {
        return Center(
          child: Text(
              "Inicia tu reproductor en Spotify",
            style: TextStyle(
              color: Colors.white
            ),
          ),
        );
      }
    },
  );
}
