import 'package:easygymclub/User/bloc/agenda_bloc.dart';
import 'package:easygymclub/User/model/actividad_agendada_model.dart';
import 'package:easygymclub/User/ui/screens/agenda/widgets/actividades_agendadas.dart';
import 'package:easygymclub/utils/format_date_mixin.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class ListaDeActividadesAgendadas extends StatefulWidget  {

  final DateTime date;

  ListaDeActividadesAgendadas({Key key, this.date});

  @override
  State<StatefulWidget> createState() {
    return _ListaDeActividadesAgendadas();
  }
}

class _ListaDeActividadesAgendadas extends State<ListaDeActividadesAgendadas> with FormatDateMixin{
  String date;

  @override
  Widget build(BuildContext context) {
    date = this.dateToString(widget.date);
    return FutureBuilder(
      future: BlocProvider.of<AgendaBloc>(context).actividadesAgendadas(date),
      builder: (context, snap) {
        if (!snap.hasData || snap.hasError) {
          print(snap.error);
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          switch (snap.connectionState) {
            case ConnectionState.none:
              print("None");
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
              break;
            case ConnectionState.waiting:
              print("Waiting");
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
              break;
            case ConnectionState.active:
              print("Active");
              return _body(snap);
              break;
            case ConnectionState.done:
              print("Done");
              return _body(snap);
              break;
          }
        }

        return null;
      },
    );
  }

  Widget _body(AsyncSnapshot snap) {

    List<ActividadAgendadaModel> actividadesAgendadas = snap.data;
    if (actividadesAgendadas.isEmpty) {
      return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
        margin: EdgeInsets.only(
            right: MediaQuery.of(context).size.width * 0.04,
            left: MediaQuery.of(context).size.width * 0.04,
            bottom: MediaQuery.of(context).size.width * 0.02
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Color(0xff04E0BA), Color(0xff0283DA)]),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Center(
          child: Text(
              "No tienes actividades agendadas para este dia",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 20.0
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }else{
      return ActividadesAgendadas(
        actividades: actividadesAgendadas.map((actividad){
          return {
            'hora':actividad.date,
            'actividad':actividad.actividad
          };
        }).toList(),
      );
    }

  }
}
