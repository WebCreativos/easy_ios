import 'package:easygymclub/Gym/Main/model/metas_model.dart';
import 'package:easygymclub/Gym/Main/bloc/metas_bloc.dart';
import 'package:easygymclub/User/bloc/ranking_bloc.dart';
import 'package:easygymclub/User/ui/screens/mi_ranking/screens/historial_de_metas.dart';
import 'package:easygymclub/User/ui/screens/mi_ranking/widgets/list_reto_gym.dart';
import 'package:easygymclub/User/ui/screens/mi_ranking/widgets/mi_posicion.dart';
import 'package:flutter/material.dart';

class MiRanking extends StatefulWidget {
  @override
  _MiRanking createState() => _MiRanking();
}

class _MiRanking extends State<MiRanking> {
  Future<List<MetasModel>> _futureRetos;
  Future<List<Map>> _futureMetas;
  MetasBloc _metasBloc;
  RankingBloc _rankingBloc = RankingBloc();

  @override
  void initState() {
    _metasBloc = MetasBloc();
    _futureRetos = _metasBloc.getMetas();
    _futureMetas = _rankingBloc.getMiHistorial();

    super.initState();
  }

  @override
  void dispose() {
    _metasBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          MiPosicion(),
          Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15.0),
                      topLeft: Radius.circular(15.0))),
              child: _metasAlcanzadas())
        ],
      ),
    );
  }

  Widget _metasAlcanzadas() {
    return FutureBuilder(
      future: _futureMetas,
      builder: (context, snap) {
        print(snap.hasError);
        if (snap.hasError) {
          return CircularProgressIndicator();
        }

        List<Map> info_historial = snap.data;
        List<Widget> aux = List<Widget>();
        aux.add(Container(
          decoration: BoxDecoration(
            color: Color(0xff260d6c),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                'Meta',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                'Informacion',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ));

        for (var info_meta in info_historial) {
          aux.add(
            MetaActividad(meta: info_meta['meta'],actividad: info_meta['actividad'],),
          );
        }

        List<Widget> columnChildrens = List<Widget>();
        columnChildrens.add(ListRetos(
          title: "Retos del gimnasio",
          metas: _futureRetos,
        ));
        columnChildrens.addAll(aux);

        if (aux.length > 0) {
          columnChildrens.add(Container(
            margin: EdgeInsets.all(15.0),
            child: InkWell(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HistorialDeMetas())),
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  border: Border.all(color: Colors.white,width: 1)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    Text(
                      "Ver historial completo",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 20.0), 
                    )
                  ],
                ),
              ),
            ),
          ));
        }

        return Column(
          children: columnChildrens,
        );
      },
    );
  }
}

class MetaActividad extends StatelessWidget {

  String meta,actividad;

  MetaActividad({Key key,this.meta,this.actividad});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(
          3.0
      ),
      padding: EdgeInsets.only(
          right: 4.0,
          left: 4.0,
          top: 2.0,
          bottom: 2.0
      ),
      decoration: BoxDecoration(
          color: Color(0xff260d6c),
          border:Border.all(
              color: Color(0xff260d9c),
              width: 1
          ),
          borderRadius: BorderRadius.circular(
              3.0
          )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            this.meta,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          Text(
            this.actividad,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          )
        ],
      ),
    );
  }
}

