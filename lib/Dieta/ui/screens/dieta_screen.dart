//bloc
import 'package:easygymclub/Dieta/bloc/dietas_bloc.dart';

//Models 
import 'package:easygymclub/Dieta/model/dieta_model.dart';

//Widgets
import 'package:easygymclub/Dieta/ui/widgets/dietas_widget.dart';
import 'package:easygymclub/widgets/card_widget.dart';

//Screens
import 'package:easygymclub/Dieta/ui/screens/dieta_individual_screen.dart';

//Framework
import 'package:flutter/material.dart';
import 'package:easygymclub/widgets/loadingCard.dart';

class DietaScreen extends StatefulWidget {

  final String tipo;

  DietaScreen({
    Key key,
    this.tipo
  });

  @override
  State < StatefulWidget > createState() {
    return _DietaScreen();
  }
}

// Comentario

class _DietaScreen extends State < DietaScreen > {
  Future < List < DietaModel >> _futureRetos;
  DietaBloc _dietaBloc;

  @override
  void initState() {
    _dietaBloc = DietaBloc();
    _futureRetos = _dietaBloc.getDieta(widget.tipo);
    super.initState();
  }

  @override
  void dispose() {
    _dietaBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _futureRetos,
      builder: (context, snap) {
        if (!snap.hasData || snap.hasError) {
          return _loading();
        } else {
          switch (snap.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return _loading();
              break;
            case ConnectionState.active:
            case ConnectionState.done:
              return _body(snap, context);
              break;
          }
        }

        return null;
      },
    );
  }

  Widget _loading() {

    return Container(
      height: MediaQuery
      .of(context)
      .size
      .height,
      child: Center(
        child: ListView.builder(
          itemCount: 12,
          itemBuilder: (context, index){
            return Container(
              margin: EdgeInsets.all(10),
              child:LoadingCard()
            ); 
          }
        ),
      ),
    );
  }


  Widget _body(AsyncSnapshot snap, BuildContext context) {
    List < DietaModel > listAuxiliar = snap.data;
    return Container(
      height: MediaQuery.of(context).size.height - 80,
      child: ListView.builder(
        itemCount:listAuxiliar.length,
        itemBuilder:(context,index){
          DietaModel dieta = listAuxiliar[index];
          return Container(
            margin: EdgeInsets.all(10),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      var aux = listAuxiliar[index];
                      return DietaIndividualScreen(
                        dietas: aux);
                    }
                  )
                );

              },
              child: CardWidget(
                data: dieta.toMap()
              ),
            ),
          );

        }
      ),
    );
  }
}