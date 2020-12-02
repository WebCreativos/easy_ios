import 'package:easygymclub/Musica/bloc/spotify_bloc.dart';
import 'package:easygymclub/Musica/models/play_list_data_model.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class PlayLists extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _PlayLists();
  }

}

class _PlayLists extends State<PlayLists>{

  SpotifyBloc _spotifyBloc;


  @override
  Widget build(BuildContext context) {
    _spotifyBloc = BlocProvider.of<SpotifyBloc>(context);
    return FutureBuilder(
      future: _spotifyBloc.userPlaylists(),
      builder: (context,snap){
        
        if(!snap.hasData || snap.hasError){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xff08c467)),
            ),
          );
        }else{

          List<PlayListDataModel> aux = snap.data;
          return Container(
            height: 60.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: aux.length,
              itemBuilder: (context, index) => PlayListData(
                key: ValueKey("${aux[index].uri}"),
                dataModel: aux[index],
              ),
            ),
          );
        }
      },
    );


  }

}

class PlayListData extends StatelessWidget {

  PlayListDataModel dataModel;

  PlayListData({Key key, this.dataModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        BlocProvider.of<SpotifyBloc>(context).playUri(dataModel.uri);
      },
      child: Container(
        margin: EdgeInsets.only(
          right: 15.0
        ),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(
            Radius.circular(10.0)
          ),
          boxShadow: [
            BoxShadow(
                color: Color(0xff08c467),
              blurRadius: 0.7
            )
          ]
        ),
        width: 150.0,
        child: Row(
          children: <Widget>[
            Container(
              height: 60.0,
              width: 60.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(3.0)),
                image: DecorationImage(
                  image: NetworkImage(dataModel.imgPath)
                )
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  dataModel.nombre,
                  style: TextStyle(
                    color: Colors.white
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


