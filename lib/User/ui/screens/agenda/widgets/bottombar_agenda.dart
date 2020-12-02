import 'package:easygymclub/User/bloc/agenda_bloc.dart';
import 'package:easygymclub/User/ui/screens/agenda/widgets/dropdown_actividades.dart';
import 'package:easygymclub/utils/LoadingProvider/loading_provider.dart';
import 'package:easygymclub/utils/format_date_mixin.dart';
import 'package:easygymclub/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:provider/provider.dart';

class BottombarAgenda extends StatefulWidget {

  DateTime date;
  BottombarAgenda({
    Key key,
    this.date
  });

  @override
  State<StatefulWidget> createState() {
    return _BottombarAgenda();
  }
}

class _BottombarAgenda extends State<BottombarAgenda> with FormatDateMixin{

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.13,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Color(0xffF34664), Color(0xffFBCE2D)]),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
          )
      ),
      child: _body()
    );
  }

  Widget _body(){

    return FutureBuilder(
      future: BlocProvider.of<AgendaBloc>(context)
          .actividadesDisponibles(this.dateToString(widget.date)),
      builder: (context, snap){

        if(!snap.hasData || snap.hasError ){
          return Center(child: CircularProgressIndicator());
        }else{
          switch(snap.connectionState){

            case ConnectionState.none:
              return Center(child: CircularProgressIndicator());
              break;
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            case ConnectionState.active:
              return _agendarseHabilitado(snap);
              break;
            case ConnectionState.done:
              return _agendarseHabilitado(snap);
              break;
          }
        }

        return null;
      },
    );
  }

  Widget _agendarseHabilitado(AsyncSnapshot snap){

    List<Map<String,dynamic>> actividadesDisponibles = snap.data;

    List<String> resultado = actividadesDisponibles.map(
        (act){
          return "${act['hora']} ${act['actividad']}";
        }
    ).toList();

    resultado.insert(0, "Selecciona actividad");

    DropdownActividades dropdown = DropdownActividades(
      actividades: resultado,
      color: Colors.orangeAccent,
      textStyle: TextStyle(color: Colors.white),
      value: "Selecciona actividad",
    );

    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
              bottom: 8.0,
            top: 8.0
          ),
          child: Text(
            "Agendar para el dia ${widget.date.day}:",
            style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w600
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              child: Container(
                padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.05,
                  left: MediaQuery.of(context).size.width * 0.05,
                ),
                child: dropdown,
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  right: MediaQuery
                      .of(context)
                      .size
                      .width * 0.05
              ),
              child: CustomButton(
                  text: "AGENDAR",
                  colorBg: false,
                  border: Border.all(color: Colors.white, width: 2.0),
                  callbackOnPressed: () {
                    if(!dropdown.isSelected()) {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        duration: Duration(seconds: 1),
                        content: Row(
                          children: <Widget>[
                            Icon(Icons.highlight_off,color:Colors.orangeAccent),
                            Text(" Selecciona alguna actividad")
                          ],
                        ),
                      ));
                      return;
                    }

                    int pk_actividad =  getPkFromActividad(snap,dropdown.getValue());

                    Provider.of<LoadingProvider>(context,listen: false).setLoadingState(StageLoading.Loading);
                    BlocProvider.of<AgendaBloc>(context).agendarseActividad(
                        pk_actividad.toString()
                    ).then((data){
                      Provider.of<LoadingProvider>(context,listen: false).setLoadingState(StageLoading.Loaded);

                      Scaffold.of(context).showSnackBar(SnackBar(
                        duration: Duration(seconds: 1),
                        content: Row(
                          children: <Widget>[
                            Icon(Icons.done,color:Colors.greenAccent),
                            Text(" Agendado correctamente")
                          ],
                        ),
                      ));
                    }).catchError((error){
                      Provider.of<LoadingProvider>(context,listen: false).setLoadingState(StageLoading.Error);

                      Scaffold.of(context).showSnackBar(SnackBar(
                        duration: Duration(seconds: 1),
                        content: Row(
                          children: <Widget>[
                            Icon(Icons.highlight_off,color:Colors.redAccent),
                            Text(" Error")
                          ],
                        ),
                      ));
                    });
                  }
              ),
            )
          ],
        )
      ],
    );
  }

  int getPkFromActividad(AsyncSnapshot snap,String value){

    List<Map<String,dynamic>> actividadesDisponibles = snap.data;

    for(var actividad in actividadesDisponibles){

      if("${actividad['hora']} ${actividad['actividad']}" == value){
        print(actividad);
        return actividad['id'];
      }

    }

  }

}
