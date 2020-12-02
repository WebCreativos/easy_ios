import 'package:easygymclub/User/bloc/ranking_bloc.dart';
import 'package:flutter/material.dart';

class MiPosicion extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _MiPosicion();
  }

}

class _MiPosicion extends State<MiPosicion>{

  Future<Map<String,dynamic>> _future;
  RankingBloc _rankingBloc;

  @override
  void initState() {
    super.initState();
    _rankingBloc = RankingBloc();
    this._future = _rankingBloc.getMiPuesto();
  }

  @override
  void dispose() {
    _rankingBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: this._future,
      builder: (context, snap){
        print(snap);
        if(!snap.hasData || snap.hasError ){
          return _loading();
        }else{

          switch(snap.connectionState){

            case ConnectionState.none:
            case ConnectionState.waiting:
              return _loading();
              break;
            case ConnectionState.active:
            case ConnectionState.done:
              return _body(snap);
              break;
          }

        }
        return null;
      },
    );
  }

  Widget _body(AsyncSnapshot snap){

    Map puesto_puntos = snap.data;
    return Container(
      height: MediaQuery.of(context).size.height * 0.33,
      padding: EdgeInsets.all(0.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Color(0xff04E0BA),
            child: Text(puesto_puntos['puesto'].toString(),style: TextStyle(color: Colors.white),),
            minRadius: MediaQuery.of(context).size.width * 0.15,
          ),
          Text("Puntos: ${puesto_puntos['puntos']}",style: TextStyle(color: Colors.white),textAlign: TextAlign.left,)
        ],
      ),
    );
  }

  Widget _loading(){
    return Container(
      height: MediaQuery.of(context).size.height * 0.33,
      padding: EdgeInsets.all(0.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Color(0xff04E0BA),
            child: CircularProgressIndicator(),
            minRadius: MediaQuery.of(context).size.width * 0.15,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
              child: LinearProgressIndicator()
          )
        ],
      ),
    );
  }

}