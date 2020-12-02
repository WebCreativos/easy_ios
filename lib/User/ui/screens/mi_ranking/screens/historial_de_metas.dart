
import 'package:easygymclub/User/bloc/ranking_bloc.dart';
import 'package:easygymclub/User/ui/screens/mi_ranking/screens/mi_ranking.dart';
import 'package:flutter/material.dart';

class HistorialDeMetas extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _HistorialDeMetas();
  }

}

class _HistorialDeMetas extends State<HistorialDeMetas> {

  Future<List<Map>> _future;
  RankingBloc _metasBloc;

  @override
  void initState() {
    super.initState();
    _metasBloc = RankingBloc();
    _future = _metasBloc.getMiHistorial();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff3F1D9D),
        title: Text("Metas alcanzadas"),
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left, color:Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            //colors: [Color(0xffF34664), Color(0xffFBCE2D)]),
            colors: [
              Color(0xffF34664),
              Color(0xffFBCE2D)
            ]
          )
        ),
        child: FutureBuilder(
          future: _future,
          builder: (context,snap){

            if(!snap.hasData || snap.hasError){
              return Center(
                child: CircularProgressIndicator(),
              );
            }else{

              switch(snap.connectionState){

                case ConnectionState.none:
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                  break;
                case ConnectionState.active:
                case ConnectionState.done:
                  return _body(snap);
                  break;
              }
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _body(AsyncSnapshot snap){

    List<Map> listAuxiliar = snap.data;

    return ListView.builder(
        itemCount: listAuxiliar.length,
        itemBuilder: (context,index){
          return MetaActividad(
            meta: listAuxiliar[index]['meta'],
            actividad: "${listAuxiliar[index]['actividad']} +${listAuxiliar[index]['puntos']} puntos",
          );
        }
    );
  }

}